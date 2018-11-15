#lang racket

(struct My-struct (x body env) #:transparent)
(define (my-struct x body env)
  (My-struct x body env))
(define (apply-my-struct s xv interp ext)
  (match s
    [(My-struct cx cbody cenv) (interp cbody (ext cenv cx xv))]
    [else (error 'apply-env "applying non-my-struct" s xv)]))

(define (empty-env-ds) '())
(define (extend-env-ds env n v) (cons `(,n . ,v) env))
(define (apply-env-ds env n)
  (let ([res (assv n env)])
    (if res
        (cdr res)
        (error 'value-of "unbound variable ~s" n))))

;(define empty-env empty-env-ds)


(define extend-env extend-env-ds)
(define apply-env apply-env-ds)
(define empty-env empty-env-ds)


(define (value-of term env)
  (match term
    [n #:when (number? n) n]
    [b #:when (boolean? b) b]
    [`(zero? ,zt) (zero? (value-of zt env))]
    [`(sub1 ,st) (sub1 (value-of st env))]
    [`(* ,n1 ,n2) (* (value-of n1 env) (value-of n2 env))]
    [`(if ,test ,conseq ,alt) (if (value-of test env)
                                  (value-of conseq env)
                                  (value-of alt env))]
    [var #:when (symbol? var) (unbox (apply-env env var))]
    [`(lambda (,x) ,body) #:when (symbol? x) (my-struct x body env)]
    [`(,rator ,rand) (let ([ratorv (value-of rator env)]
                           [randv (value-of rand env)])
                       (apply-my-struct ratorv (box randv) value-of extend-env))]
    [`(let ([,n ,v]) ,body) #:when (symbol? n)
                            (value-of body (extend-env env n (box (value-of v env))))]

    [`(set! ,id ,expr) #:when (symbol? id) (let ([idbox (apply-env env id)])
                                   (set-box! idbox (value-of expr env)))]
    [`(begin2 ,op1 ,op2) (begin (value-of op1 env) (value-of op2 env))]))



(define (empty-env-fn) (lambda (x) (error 'value-of "unbound variable ~s" x)))
(define (extend-env-fn env n v)
  (lambda (x)
    (if (eqv? x n) v
        (env x))))

(define (apply-env-fn env n)
  (env n))

(define (value-of-fn term env)
  (match term
    [n #:when (number? n) n]
    [b #:when (boolean? b) b]
    [`(zero? ,zt) (zero? (value-of-fn zt env))]
    [`(sub1 ,st) (sub1 (value-of-fn st env))]
    [`(* ,n1 ,n2) (* (value-of-fn n1 env) (value-of-fn n2 env))]
    [`(if ,test ,conseq ,alt) (if (value-of-fn test env)
                                  (value-of-fn conseq env)
                                  (value-of-fn alt env))]
    [var #:when (symbol? var) (apply-env-fn env var)]
    [`(lambda (,x) ,body) #:when (symbol? x) (my-struct x body env)]
    [`(,rator ,rand) (let ([ratorv (value-of-fn rator env)]
                           [randv (value-of-fn rand env)])
                       (apply-my-struct ratorv randv value-of-fn extend-env-fn))]
    [`(let ([,n ,v]) ,body) #:when (symbol? n)
                            (let ([vv (value-of-fn v env)])
                              (value-of-fn body (extend-env-fn env n vv)))]))

(define (value-of-ds term env)
  (match term
    [n #:when (number? n) n]
    [b #:when (boolean? b) b]
    [`(zero? ,zt) (zero? (value-of-ds zt env))]
    [`(sub1 ,st) (sub1 (value-of-ds st env))]
    [`(* ,n1 ,n2) (* (value-of-ds n1 env) (value-of-ds n2 env))]
    [`(if ,test ,conseq ,alt) (if (value-of-ds test env)
                                  (value-of-ds conseq env)
                                  (value-of-ds alt env))]
    [var #:when (symbol? var) (apply-env env var)]
    [`(lambda (,x) ,body) #:when (symbol? x) (my-struct x body env)]
    [`(,rator ,rand) (let ([ratorv (value-of-ds rator env)]
                           [randv (value-of-ds rand env)])
                       (apply-my-struct ratorv randv value-of-ds extend-env))]
    [`(let ([,n ,v]) ,body) #:when (symbol? n)
                            (value-of-ds body (extend-env env n (value-of-ds v env)))]))





(define (fo-eulav term env)
  (struct My-struct (x body env) #:transparent)
  (define (my-struct x body env)
    (My-struct x body env))
  (define (apply-my-struct s xv interp ext)
    (match s
      [(My-struct cx cbody cenv) (interp cbody (ext cenv cx xv))]
      [else (error 'apply-env "applying non-my-struct" s xv)]))
  (letrec ([extend-env extend-env-ds]
           [apply-env apply-env-ds]
           [R (lambda (t env)
    (match t
      [n #:when (number? n) n]
      [b #:when (boolean? b) b]
      [`(,zt ?orez) (zero? (R zt env))]
      [`(,st 1bus) (sub1 (R st env))]
      [`(,n2 ,n1 *) (* (R n1 env) (R n2 env))]
      [`(,alt ,conseq ,test fi) (if (R test env)
                                    (R conseq env)
                                    (R alt env))]
      [var #:when (symbol? var) (apply-env env var)]
      [`(,body (,x) adbmal) #:when (symbol? x) (my-struct x body env)]
      [`(,rand ,rator ) (let ([ratorv (R rator env)]
                             [randv (R rand env)])
                         (apply-my-struct ratorv randv R extend-env))]
      [`(,body ([,v ,n] tel)) #:when (symbol? n)
                              (R body (extend-env env n (R v env)))]))])
    (R term env)))

;brainteaser
(define apply-env-lex list-ref)

(define empty-env-lex 
  (lambda () '()))

(define extend-env-lex cons)

(define value-of-lex
  (lambda(exp env)
    (match exp
      [`(const ,y) #:when (or (boolean? y) (number? y)) y]
      [`(sub1 ,body) (sub1 (value-of-lex body env))]
      [`(zero ,body) (zero? (value-of-lex body env))]
      [`(* ,a ,b) (* (value-of-lex a env) (value-of-lex b env))]
      [`(if ,f ,g ,h) (if (value-of-lex f env) (value-of-lex g env) (value-of-lex
                                                                     h env))]
      [`(var ,n) (apply-env-lex env n)]
      [`(lambda ,body) (lambda (i) (value-of-lex body (extend-env-lex i env)))]
      [`(,rator ,rand) ((value-of-lex rator env) (value-of-lex rand env))])))

;;dessert
(define c0 (lambda (f) (lambda (x) x)))
(define c5 (lambda (f) (lambda (x) (f (f (f (f (f x))))))))

(define c+ (lambda (m) 
               (lambda (n) 
                 (lambda (a) (lambda (b) ((m a) ((n a) b)))))))

(let ((c10 ((c+ c5) c5)))
    ((c10 add1) 0))
(define csub1
  (lambda (n)
    (lambda (f)
      (lambda (base)
        (((n (lambda (g) (lambda (h) (h (g f))))) 
          (lambda (u) base)) 
         (lambda (id) id))))))