#lang racket
(require "parenthec.rkt")

(define-union expr
  (const cexp)
  (var n)
  (if test conseq alt)
  (mult nexp1 nexp2)
  (sub1 nexp)
  (zero nexp)
  (letcc body)
  (throw kexp vexp)
  (let exp body)              
  (lambda body)
  (app rator rand))

;env
(define-union envr
  (empty-env)
  (extend-env a^ env^))
(define apply-env
  (lambda (env y^ k^)
    (union-case env envr
      ;[(extend-env a^ env^) (if (zero? y^) (apply-k k^ a^) (apply-env env^ (sub1 y^) k^))]
                [(extend-env a^ env^) (if (zero? y^)
                                          (let* ([k k^]
                                                 [var a^])
                                            (apply-k k var))
                                          (let* ([y^ (sub1 y^)]
                                                 [env env^])
                                            (apply-env env y^ k^)))]
                [(empty-env) (error 'value-of "unbound identifier")])))

;; closure
(define-union clos
  (closure body env))
(define apply-closure
  (lambda (clos^ a^ k^)
   (union-case clos^ clos
     ;[(closure body^ env^) (value-of-cps body^ (envr_extend-env a^ env^) k^)]
               [(closure body^ env^) (let* ([expression body^]
                                            [env^ (envr_extend-env a^ env^)])
                                       (value-of-cps expression env^ k^))]
               )))

;; continuation
(define-union kt
  (empty-k)
  (mult-inner-k v^ k^)
  (mult-outer-k nexp2^ env^ k^)
  (sub1-constructor-k k^)
  (zero-constructor-k k^)
  (if-constructor-k conseq^ alt^ env^ k^)
  (throw-inner-k vexp^)
  (throw-outer-k kexp^ env^)
  (let-constructor-k body^ env^ k^)
  (app-inner-k v^ k^)
  (app-outer-k rand^ env^ k^))

;; interpreter
(define value-of-cps
  (lambda (expression env^ k^)
    (union-case expression expr
                ;[(const cexp) (apply-k k^ cexp)]
                [(const cexp) (let* ([k k^]
                                     [var cexp])
                                (apply-k k var))]
                ;[(mult nexp1 nexp2) (value-of-cps nexp1 env^ (kt_mult-outer-k nexp2 env^ k^))]
                [(mult nexp1 nexp2) (let* ([k^ (kt_mult-outer-k nexp2 env^ k^)]
                                           [expression nexp1])
                                      (value-of-cps expression env^ k^))]
                ;[(sub1 nexp) (value-of-cps nexp env^ (kt_sub1-constructor-k k^))]
                [(sub1 nexp) (let* ([k^ (kt_sub1-constructor-k k^)]
                                    [expression nexp])
                               (value-of-cps expression env^ k^))]
                ;[(zero nexp) (value-of-cps nexp env^ (kt_zero-constructor-k k^))]
                [(zero nexp) (let* ([k^ (kt_zero-constructor-k k^)]
                                    [expression nexp])
                               (value-of-cps expression env^ k^))]
                ;[(if test conseq alt)
                ;(value-of-cps test env^ (kt_if-constructor-k conseq alt env^ k^))]
                [(if test conseq alt) (let* ([k^ (kt_if-constructor-k conseq alt env^ k^)]
                                             [expression test])
                                        (value-of-cps expression env^ k^))]
                ;[(letcc body) (value-of-cps body (envr_extend-env k^ env^) k^)]
                [(letcc body) (let* ([env^ (envr_extend-env k^ env^)]
                                     [expression body])
                                (value-of-cps expression env^ k^))]
                ;[(throw kexp vexp) (value-of-cps kexp env^ (kt_throw-outer-k vexp env^))]
                [(throw kexp vexp) (let* ([k^ (kt_throw-outer-k vexp env^)]
                                          [expression kexp])
                                     (value-of-cps expression env^ k^))]
                ;[(let exp body) (value-of-cps exp env^ (kt_let-constructor-k body env^ k^))]
                [(let exp body) (let* ([k^ (kt_let-constructor-k body env^ k^)]
                                       [expression exp])
                                  (value-of-cps expression env^ k^))]
                ;[(var n) (apply-env env^ n k^)]
                [(var n) (let* ([y^ n]
                                [env env^])
                           (apply-env env y^ k^))]
                ;[(lambda body) (apply-k k^ (clos_closure body env^))]
                [(lambda body) (let* ([k k^]
                                      [var (clos_closure body env^)])
                                 (apply-k k var))]
                ;[(app rator rand) (value-of-cps rator env^ (kt_app-outer-k rand env^ k^))]
                [(app rator rand) (let* ([k^ (kt_app-outer-k rand env^ k^)]
                                         [expression rator])
                                    (value-of-cps expression env^ k^))]
                )))

(define apply-k
  (lambda (k var)
    (union-case k kt
                ;[(empty-k) var]
                [(empty-k) (let* ([v var])
                             v)]
                ;[(mult-inner-k var^ k^) (apply-k k^ (* var var^))]
                [(mult-inner-k var^ k^) (let* ([k k^]
                                               [var (* var var^)])
                                          (apply-k k var))]
                ;[(mult-outer-k nexp2^ env^ k^)
                ; (value-of-cps nexp2^ env^ (kt_mult-inner-k var k^))]
                [(mult-outer-k nexp2^ env^ k^) (let* ([expression nexp2^]
                                                      [k^ (kt_mult-inner-k var k^)])
                                                 (value-of-cps expression env^ k^))]
                ;[(sub1-constructor-k k^) (apply-k k^ (sub1 var))]
                [(sub1-constructor-k k^) (let* ([k k^]
                                                [var (sub1 var)])
                                           (apply-k k var))]
                ;[(zero-constructor-k k^) (apply-k k^ (zero? var))]
                [(zero-constructor-k k^) (let* ([k k^]
                                                [var (zero? var)])
                                            (apply-k k var))]
                ;[(if-constructor-k conseq^ alt^ env^ k^)
                ; (if var (value-of-cps conseq^ env^ k^) (value-of-cps alt^ env^ k^))]
                [(if-constructor-k conseq^ alt^ env^ k^)
                 (if var
                     (let* ([expression conseq^])
                       (value-of-cps expression env^ k^))
                     (let* ([expression alt^])
                       (value-of-cps expression env^ k^))
                     )]
                ;[(throw-inner-k v^) (apply-k v^ var)]
                [(throw-inner-k v^) (let* ([k v^])
                                      (apply-k k var))]
                ;[(throw-outer-k kexp^ env^) (value-of-cps kexp^ env^ (kt_throw-inner-k var))]
                [(throw-outer-k kexp^ env^) (let* ([k^ (kt_throw-inner-k var)]
                                                   [expression kexp^])
                                              (value-of-cps expression env^ k^))]
                ;[(let-constructor-k body^ env^ k^)
                ; (value-of-cps body^ (envr_extend-env var env^) k^)]
                [(let-constructor-k body^ env^ k^) (let* ([expression body^]
                                                          [env^ (envr_extend-env var env^)])
                                                     (value-of-cps expression env^ k^))]
                ;[(app-inner-k var^ k^) (apply-closure var^ var k^)]
                [(app-inner-k var^ k^) (let* ([clos^ var^]
                                              [a^ var])
                                         (apply-closure clos^ a^ k^))]
                ;[(app-outer-k rand^ env^ k^) (value-of-cps rand^ env^ (kt_app-inner-k var k^))]
                [(app-outer-k rand^ env^ k^) (let* ([k^ (kt_app-inner-k var k^)]
                                                    [expression rand^])
                                               (value-of-cps expression env^ k^))]
      )))


(define main 
  (lambda ()
    (let* ([k^ (kt_empty-k)]
           [env^ (envr_empty-env)]
           [expression (expr_let 
                        (expr_lambda
                         (expr_lambda 
                          (expr_if
                           (expr_zero (expr_var 0))
                           (expr_const 1)
                           (expr_mult (expr_var 0) (expr_app (expr_app (expr_var 1) (expr_var 1))
                                                             (expr_sub1 (expr_var 0)))))))
                        (expr_mult
                         (expr_letcc
                          (expr_app
                           (expr_app (expr_var 1) (expr_var 1))
                           (expr_throw (expr_var 0) (expr_app (expr_app (expr_var 1) (expr_var 1))
                                                              (expr_const 4)))))
                         (expr_const 5)))])
      (value-of-cps expression env^ k^))))
    
(main)