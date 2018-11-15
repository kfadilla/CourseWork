#lang racket
(require "parenthec.rkt")
(define-registers y^ k var env clos^ expression a^)
(define-program-counter pc)
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
(define-label apply-env
  (union-case env envr
              ;[(extend-env a^ env^) (if (zero? y^) (apply-k k^ a^) (apply-env env^ (sub1 y^) k^))]
              [(extend-env a^ env^) (if (zero? y^)
                                        (begin (set! k k)
                                               (set! var a^)
                                               (apply-k))
                                        (begin (set! env env^)
                                               (set! y^ (sub1 y^))
                                               (set! k k)
                                               (apply-env)))]
              [(empty-env) (error 'value-of "unbound identifier")]))

;; closure
(define-union clos
  (closure body env))
(define-label apply-closure
  (union-case clos^ clos
              ;[(closure body^ env^) (value-of-cps body^ (envr_extend-env a^ env^) k^)]
              [(closure body^ env^) (begin (set! expression body^)
                                           (set! env (envr_extend-env a^ env^))
                                           (set! k k)
                                           (value-of-cps))]
              ))

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
(define-label value-of-cps
  (union-case expression expr
              ;[(const cexp) (let* ([k k^]
              ;                     [var cexp])
              ;                (apply-k k var))]
              [(const cexp) (begin (set! var cexp)
                                   (set! k k)
                                   (apply-k))]
              ;[(mult nexp1 nexp2) (let* ([k^ (kt_mult-outer-k nexp2 env^ k^)]
              ;                           [expression nexp1])
              ;                      (value-of-cps expression env^ k^))]
              [(mult nexp1 nexp2) (begin (set! expression nexp1)
                                         (set! env env)
                                         (set! k (kt_mult-outer-k nexp2 env k))
                                         (value-of-cps))]
              ;[(sub1 nexp) (let* ([k^ (kt_sub1-constructor-k k^)]
              ;                    [expression nexp])
              ;               (value-of-cps expression env^ k^))]
              [(sub1 nexp) (begin (set! expression nexp)
                                    (set! env env)
                                    (set! k (kt_sub1-constructor-k k))
                                    (value-of-cps))]
              ;[(zero nexp) (let* ([k^ (kt_zero-constructor-k k^)]
                ;                    [expression nexp])
              ;               (value-of-cps expression env^ k^))]
              [(zero nexp) (begin (set! expression nexp)
                                  (set! env env)
                                  (set! k (kt_zero-constructor-k k))
                                  (value-of-cps))]
              ;[(if test conseq alt) (let* ([k^ (kt_if-constructor-k conseq alt env^ k^)]
              ;                             [expression test])
              ;                        (value-of-cps expression env^ k^))]
              [(if test conseq alt) (begin (set! expression test)
                                           (set! env env)
                                           (set! k (kt_if-constructor-k conseq alt env k))
                                           (value-of-cps))]
              
              ;[(letcc body) (let* ([env^ (envr_extend-env k^ env^)]
              ;                      [expression body])
              ;                 (value-of-cps expression env^ k^))]
              [(letcc body) (begin (set! expression body)
                                   (set! env (envr_extend-env k env))
                                   (set! k k)
                                   (value-of-cps))]
              ;[(throw kexp vexp) (let* ([k^ (kt_throw-outer-k vexp env^)]
              ;                          [expression kexp])
              ;                     (value-of-cps expression env^ k^))]
              [(throw kexp vexp) (begin (set! expression kexp)
                                        (set! env env)
                                        (set! k (kt_throw-outer-k vexp env))
                                        (value-of-cps))]
              
              ;[(let exp body) (let* ([k^ (kt_let-constructor-k body env^ k^)]
              ;                       [expression exp])
              ;                  (value-of-cps expression env^ k^))]
              [(let exp body) (begin (set! expression exp)
                                     (set! env env)
                                     (set! k (kt_let-constructor-k body env k))
                                     (value-of-cps))]
              ;[(var n) (let* ([y^ n]
              ;                [env env^])
              ;           (apply-env env y^ k^))]
              [(var n) (begin (set! y^ n)
                              (set! env env)
                              (set! k k)
                              (apply-env))]
              ;[(lambda body) (let* ([k k^]
              ;                      [var (clos_closure body env^)])
              ;                 (apply-k k var))]
              [(lambda body) (begin (set! var (clos_closure body env))
                                    (set! k k)
                                    (apply-k))]
              ;[(app rator rand) (let* ([k^ (kt_app-outer-k rand env^ k^)]
              ;                         [expression rator])
              ;                    (value-of-cps expression env^ k^))]
              [(app rator rand) (begin (set! expression rator)
                                       (set! env env)
                                       (set! k (kt_app-outer-k rand env k))
                                       (value-of-cps))]
              ))

(define-label apply-k
  (union-case k kt
              ;[(empty-k) (let* ([v var])
              ;             v)]
              [(empty-k) var]
              ;[(mult-inner-k var^ k^) (let* ([k k^]
              ;                               [var (* var var^)])
              ;                          (apply-k k var))]
              [(mult-inner-k var^ k^) (begin (set! var (* var var^))
                                               (set! k k^)
                                               (apply-k))]
              ;[(mult-outer-k nexp2^ env^ k^) (let* ([expression nexp2^]
              ;                                       [k^ (kt_mult-inner-k var k^)])
              ;                                  (value-of-cps expression env^ k^))]
              [(mult-outer-k nexp2^ env^ k^) (begin (set! k (kt_mult-inner-k var k^))
                                                    (set! env env^)
                                                    (set! expression nexp2^)
                                                    (value-of-cps))]
              ;[(sub1-constructor-k k^) (let* ([k k^]
              ;                                [var (sub1 var)])
              ;                           (apply-k k var))]
              [(sub1-constructor-k k^) (begin (set! var (sub1 var))
                                              (set! k k^)
                                              (apply-k))]
              ;[(zero-constructor-k k^) (let* ([k k^]
              ;                                [var (zero? var)])
              ;                            (apply-k k var))]
              [(zero-constructor-k k^) (begin (set! var (zero? var))
                                              (set! k k^)
                                              (apply-k))]
              ;[(if-constructor-k conseq^ alt^ env^ k^)
              ; (if var
              ;     (let* ([expression conseq^])
              ;       (value-of-cps expression env^ k^))
              ;     (let* ([expression alt^])
              ;       (value-of-cps expression env^ k^))
              ;     )]
              [(if-constructor-k conseq^ alt^ env^ k^)
               (if var
                   (begin (set! k k^)
                          (set! env env^)
                          (set! expression conseq^)
                          (value-of-cps))
                   (begin (set! k k^)
                          (set! env env^)
                          (set! expression alt^)
                          (value-of-cps)))]
              ;[(throw-inner-k v^) (let* ([k v^])
              ;                      (apply-k k var))]
              [(throw-inner-k v^) (begin (set! var var)
                                         (set! k v^)
                                         (apply-k))]
              ;[(throw-outer-k kexp^ env^) (let* ([k^ (kt_throw-inner-k var)]
              ;                                   [expression kexp^])
              ;                              (value-of-cps expression env^ k^))]
              [(throw-outer-k kexp^ env^) (begin (set! k (kt_throw-inner-k var))
                                                 (set! env env^)
                                                 (set! expression kexp^)
                                                 (value-of-cps))]
              ;[(let-constructor-k body^ env^ k^)
              ; (value-of-cps body^ (envr_extend-env var env^) k^)]
              [(let-constructor-k body^ env^ k^) (begin (set! k k^)
                                                        (set! env (envr_extend-env var env^))
                                                        (set! expression body^)
                                                        (value-of-cps))]
              ;[(app-inner-k var^ k^) (let* ([clos^ var^]
              ;                               [a^ var])
              ;                          (apply-closure clos^ a^ k^))]
              [(app-inner-k var^ k^) (begin (set! k k^)
                                            (set! a^ var)
                                            (set! clos^ var^)                                             
                                            (apply-closure))]
              ;[(app-outer-k rand^ env^ k^) (let* ([k^ (kt_app-inner-k var k^)]
              ;                                    [expression rand^])
              ;                               (value-of-cps expression env^ k^))]
              [(app-outer-k rand^ env^ k^)  (begin (set! k (kt_app-inner-k var k^))
                                                   (set! env env^)
                                                   (set! expression rand^)
                                                   (value-of-cps))]
              ))
(define-label main 
  (begin (set! k (kt_empty-k))
         (set! env (envr_empty-env))
         (set! expression (expr_let 
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
                            (expr_const 5))))
         (value-of-cps)))

(main)