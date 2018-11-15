#lang racket


(define (lex exp env)
  (match exp
    [`,y #:when (symbol? y) `(var ,(- (length env) (length (memv y env))))]
    [`,y #:when (number? y) `(const ,y)]
    [`(zero? ,y) `(zero? ,(lex y env))]
    [`(sub1 ,y) `(sub1 ,(lex y env))]
    [`(* ,x ,y) `(* ,(lex x env) ,(lex y env))]
    [`(if ,boo ,x ,y) `(if ,(lex boo env) ,(lex x env) ,(lex y env))]
    [`(let ([,id ,y]) ,body)
     `(let ,(lex y env) ,(lex body (cons id env)))]
    [`(lambda (,id) ,body) `(lambda ,(lex body (cons id env)))]
    [`(,rator ,rand) `(,(lex rator env) ,(lex rand env))]
    ))
;(lex '((lambda (x) x) 5)  '())
;(lex '(lambda (!)
 ; 	  (lambda (n)
  ;	    (if (zero? n) 1 (* n (! (sub1 n))))))
;	'())

(define (empty-env) '())

(define extend-env
  (lambda (id arg env)
    `(extend-env ,id ,arg ,env)))

(define apply-env
  (lambda (env var)
    (match env
      [`(empty-env) (error 'empty-env "unbound identifier ~s" var)]
      [`(extend-env ,id ,arg ,env)
       (if (eqv? id var)
           arg
           (apply-env env var))]
      )))

(define closure-fn
  (lambda (id body env)
    (lambda (arg)
      (value-of-fn body (extend-env id arg env)))))

(define apply-closure-fn
  (lambda (cl arg)
    (cl arg)))

(define value-of-fn
  (lambda (e env)
    (match e
      [`,y #:when (or (boolean? y) (number? y)) y]
      [`,y #:when (symbol? y) (apply-env env y)]
      [`(zero? ,y) (zero? (value-of-fn y env))]
      [`(sub1 ,y) (sub1 (value-of-fn y env))]
      [`(* ,x ,y) (* (value-of-fn x env) (value-of-fn y env))]
      [`(if ,boo ,x ,y)
       (if (value-of-fn boo env) (value-of-fn x env)( value-of-fn y env))]
      [`(let ([,id ,val-expr]) ,body)
       (let ([arg (value-of-fn val-expr env)])
         (value-of-fn body (extend-env id arg env)))]
      [`(lambda (,id) ,body)
       (closure-fn id body env)]
      [`(,rator ,rand) (apply-closure-fn (value-of-fn rator env) (value-of-fn rand env))]
      )))

;(value-of-fn 
 ;   '((lambda (x) (if (zero? x) 
  ;                    12 
   ;                   47)) 
    ;   0) 
    ;(empty-env))
(define (closure-ds id body env)
    `(closure ,id ,body ,env))

(define apply-closure-ds
  (lambda (cl arg)
    (match cl
      [`(closure ,id ,body ,env)
       (value-of-ds body (extend-env id arg env))]
      )))

(define value-of-ds
  (lambda (e env)
    (match e
      [y #:when (number? y) y]
      [y #:when (boolean? y) y]
      [`(zero? ,zt) (zero? (value-of-fn zt env))]
      [`(sub1 ,st) (sub1 (value-of-fn st env))]
      [`(* ,n1 ,n2) (* (value-of-fn n1 env) (value-of-fn n2 env))]
      [`(if ,test ,conseq ,alt) (if (value-of-fn test env)
                                  (value-of-fn conseq env)
                                  (value-of-fn alt env))]
      [`(let ([,id ,val-expr]) ,body)
       (let ([arg (value-of-ds val-expr env)])
         (value-of-ds body (extend-env id arg env)))]
      [`(lambda (,id) ,body)
       (closure-ds id body env)]
      [`(,rator ,rand) (apply-closure-ds
                        (value-of-ds rator env)
                        (value-of-ds rand env))]
      )))

;(value-of-ds
 ;  '(let ([x (* 2 3)])
  ;    (let ([x (sub1 x)])
   ;     (* x x)))
   ;(empty-env))
(define value-of-dynamic
  (lambda (e env)
    (match e
      [`,y #:when (symbol? y) (apply-env env y)]
      [`,y #:when (or (boolean? y) (number? y)) y]
      [`(quote ,y) y]
      [`(null? ,ls) (null? (value-of-dynamic ls env))]
      [`(car ,ls) (car (value-of-dynamic ls env))]
      [`(cdr ,ls) (cdr (value-of-dynamic ls env))]
      [`(cons ,x ,y) (cons (value-of-dynamic x env) (value-of-dynamic y env))]
      [`(zero? ,y) (zero? (value-of-dynamic y env))]
      [`(sub1 ,y) (sub1 (value-of-dynamic y env))]
      [`(* ,x ,y) (* (value-of-dynamic x env) (value-of-dynamic y env))]
      [`(if ,boo ,x ,y)
       (if (value-of-dynamic boo env) (value-of-dynamic x env) (value-of-dynamic y env))]
      [`(let ([,id ,expr]) ,body)
       (let ([arg (value-of-dynamic expr env)])
         (value-of-dynamic body (extend-env id arg env)))]
      [`(lambda (,id) ,body) `(lambda (,id) ,body)]
      [`(,rator ,rand)
        (match-let
            ([`(lambda (,id) ,body) (value-of-dynamic rator env)]
             [`,arg (value-of-dynamic rand env)])
          (value-of-dynamic body (extend-env id arg env)))]
      )))

;(value-of-dynamic
  ;  '(let ([f (lambda (x) (cons x l))])
 ;      (let ([cmap 
;	      (lambda (f)
;		(lambda (l)               
;		  (if (null? l) 
;		      '()
;		      (cons (f (car l)) ((cmap f) (cdr l))))))])
;	 ((cmap f) (cons 1 (cons 2 (cons 3 '())))))) 
;    (empty-env))