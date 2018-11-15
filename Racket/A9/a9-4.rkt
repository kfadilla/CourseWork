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

;; env
(define-union envr
  (empty-env)
  (extend-env a^ env^))
(define apply-env
  (lambda (env y^ k^)
    (union-case env envr
                [(extend-env a^ env^) (if (zero? y^) (apply-k k^ a^) (apply-env env^ (sub1 y^) k^))]
                [(empty-env) (error 'value-of "unbound identifier")])))

;; closure
(define-union clos
  (closure body env))
(define apply-closure
  (lambda (clos^ a^ k^)
   (union-case clos^ clos
               [(closure body^ env^) (value-of-cps body^ (envr_extend-env a^ env^) k^)])))

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
              [(const cexp) (apply-k k^ cexp)]
              [(mult nexp1 nexp2) (value-of-cps nexp1 env^ (kt_mult-outer-k nexp2 env^ k^))]
              [(sub1 nexp) (value-of-cps nexp env^ (kt_sub1-constructor-k k^))]
              [(zero nexp) (value-of-cps nexp env^ (kt_zero-constructor-k k^))]
              [(if test conseq alt)
               (value-of-cps test env^ (kt_if-constructor-k conseq alt env^ k^))]
              [(letcc body) (value-of-cps body (envr_extend-env k^ env^) k^)]
              [(throw kexp vexp) (value-of-cps kexp env^ (kt_throw-outer-k vexp env^))]
              [(let exp body) (value-of-cps exp env^ (kt_let-constructor-k body env^ k^))]
              [(var n) (apply-env env^ n k^)]
              [(lambda body) (apply-k k^ (clos_closure body env^))]
              [(app rator rand) (value-of-cps rator env^ (kt_app-outer-k rand env^ k^))]
              )))

(define apply-k
  (lambda (k var)
    (union-case k kt
      ;[`(empty-k) var]
                [(empty-k) var]
      ;[`(mult-inner-k ,var^ ,k^) (apply-k k^ (* var var^))]
                [(mult-inner-k var^ k^) (apply-k k^ (* var var^))]
      ;[`(mult-outer-k ,x2^ ,env^ ,k^) (value-of-cps x2^ env^ (mult-inner-k var k^))]
                [(mult-outer-k nexp2^ env^ k^)
                 (value-of-cps nexp2^ env^ (kt_mult-inner-k var k^))]
      ;[`(sub1-constructor-k ,k^) (apply-k k^ (sub1 var))]
                [(sub1-constructor-k k^) (apply-k k^ (sub1 var))]
      ;[`(zero-constructor-k ,k^) (apply-k k^ (zero? var))]
                [(zero-constructor-k k^) (apply-k k^ (zero? var))]
      ;[`(if-constructor-k ,conseq^ ,alt^ ,env^ ,k^)
      ; (if var (value-of-cps conseq^ env^ k^) (value-of-cps alt^ env^ k^))]
                [(if-constructor-k conseq^ alt^ env^ k^)
                 (if var (value-of-cps conseq^ env^ k^) (value-of-cps alt^ env^ k^))]
      ;[`(throw-inner-k ,v^) (apply-k v^ var)]
                [(throw-inner-k v^) (apply-k v^ var)]
      ;[`(throw-outer-k ,k-exp^ ,env^) (value-of-cps k-exp^ env^ (throw-inner-k var))]
                [(throw-outer-k kexp^ env^) (value-of-cps kexp^ env^ (kt_throw-inner-k var))]
      ;[`(let-constructor-k ,body^ ,env^ ,k^)
       ;(value-of-cps body^ (envr_extend-env var env^) k^)]
                [(let-constructor-k body^ env^ k^)
                 (value-of-cps body^ (envr_extend-env var env^) k^)]
      ;[`(app-inner-k ,var^ ,k^) (apply-closure var^ var k^)]
                [(app-inner-k var^ k^) (apply-closure var^ var k^)]
      ;[`(app-outer-k ,rand^ ,env^ ,k^) (value-of-cps rand^ env^ (app-inner-k var k^))]
                [(app-outer-k rand^ env^ k^) (value-of-cps rand^ env^ (kt_app-inner-k var k^))]
      )))


(define main 
  (lambda ()
    (value-of-cps 
     (expr_let 
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
       (expr_const 5)))
     (envr_empty-env)
     (kt_empty-k))))
(main)