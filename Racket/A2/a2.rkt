#lang racket
(define list-ref
  (lambda (l n)
    (letrec
        ([nth-cdr
          (lambda (n)
            (cond
              [(zero? n) l]
              [else (cdr (nth-cdr (- n 1)))]))])
      (car (nth-cdr n)))))

;(list-ref '(a b c) 2)

(define union
  (lambda (l1 l2)
    (cond
      [(null? l1) l2]
      [else (if (memv (car l1) l2) (union (cdr l1) l2)
                (cons (car l1) (union (cdr l1) l2)))])))

;(union '() '())
;(union '(x y) '(x z))

(define extend
  (lambda (x pred)
    (lambda (e)
      (or (eqv? e x)
          (pred e)))))

;(filter (extend 7 (extend 3 (extend 1 even?))) '(0 1 2 3 4 5))


(define (walk-symbol x l)
    (let ([s (assv x l)])
      (if (not s) x (walk-symbol (cdr s) l))))

;(walk-symbol 'd '((a . 5) (b . 6) (c . f) (e . c) (d . e)))

(define lambda->lumbda
  (lambda (e)
    (match e
      [`(lambda (,m) ,y)
       `(lumbda (,m) ,(lambda->lumbda y))]
      [`(,rator ,rand)
       `(,(lambda->lumbda rator)
         ,(lambda->lumbda rand))]
      [`,m (not (pair? m))
           m])
    ))


;(lambda->lumbda '(lambda (z) ((lambda (y) (a z)) (h (lambda (x) (h a))))))


(define var-occurs?
  (lambda (varnm e)
    (match e
      [`(lambda (,m) ,y)
       (var-occurs? varnm y)]
      [`(,rator ,rand)
       (or (var-occurs? varnm rator)
           (var-occurs? varnm rand))]
      [`,m (not (pair? m))
           (eq? varnm m)])
    ))


;(var-occurs? 'x '(lambda (y) x))


(define vars
  (lambda (e)
    (match e
      [`(lambda (,m) ,y)
       (vars y)]
      [`(,rator ,rand)
       (append (vars rator)
               (vars rand))]
      [`,m (not (pair? m))
       `(,m)])
    ))

;(vars '(lambda (z) ((lambda (y) (a z)) (h (lambda (x) (h a))))))



(define unique-vars
  (lambda (e)
    (match e
      [`(lambda (,m) ,y)
       (unique-vars y)]
      [`(,rator ,rand)
       (union (unique-vars rator)
              (unique-vars rand))]
      [`,m (not (pair? m))
       `(,m)])
    ))

;(unique-vars '((lambda (y) (x x)) (x y)))


(define var-occurs-free?
  (lambda (sym e)
    (match e
      [`(lambda (,m) ,y)
       (if (eq? m sym)
           #f
           (var-occurs-free? sym y))]
      [`(,rator ,rand)
       (or (var-occurs-free? sym rator)
           (var-occurs-free? sym rand))]
      [`,m (not (pair? m))
           (eq? m sym)])
    ))


;(var-occurs-free? 'y '((lambda (y) (x y)) (lambda (x) (x y))))


(define var-occurs-bound?
  (lambda (sym e)
    (match e
      [`(,rator ,rand)
       (or (var-occurs-bound? sym rator)
           (var-occurs-bound? sym rand))]
      [`(lambda (,m) ,y)
       (cond
         [(memv sym (vars y))
          (cond
            ((eq? sym m) #t)
            (else (var-occurs-bound? sym y)))]
         (else #f))]
      [`,m (symbol? m)
           #f])
    ))


;(var-occurs-bound? 'z '(lambda (y) (lambda (z) (y z))))


(define unique-free-vars
  (lambda (x)
    (match x
      [`(,rator ,rand)
       (union (unique-free-vars rator)
              (unique-free-vars rand))]
      [`(lambda (,m) ,y)
       (remv m (unique-free-vars y))]
      [`,m (symbol? m)
       `(,m)])
    ))

;(unique-free-vars '((lambda (x) ((x y) e)) (lambda (c) (x (lambda (x) (x (e c)))))))


(define (unique-bound-vars x)
  (remove-duplicates (unique-bound-vars-helper x)))


(define unique-bound-vars-helper
  (lambda (x)
    (match x
      [`(,rator ,rand)
       (union (unique-bound-vars-helper rator)
              (unique-bound-vars-helper rand))]
      [`(lambda (,m) ,y)
           (if (memv m (unique-vars y))
               (cons m (unique-bound-vars-helper y))
               (unique-bound-vars-helper y))]
       [`,m (symbol? m)
           '()]
      )
    ))


;(unique-bound-vars '((lambda (x) ((x y) e)) (lambda (c) (x (lambda (x) (x (e c)))))))


(define lex
  (lambda (x accum)
    (match x
      [`(,rator ,rand)
       (list (lex rator accum)
             (lex rand accum))]
      [`(lambda (,m) ,body)
       `(lambda ,(lex body (cons m accum)))]
      [`,m (symbol? m)
           `(var ,(- (length accum)
                     (length (memv m accum))))
               ])
    ))


;(lex '(lambda (y) (lambda (x) y)) '())

   


;14
(define (walk-symbol-update x ls)
  (letrec ((helper
            (lambda (x ls acc)
              (let ([s (assv x ls)])
                (if (not s) (foldr (lambda (a b)
                                     (if (eq? (unbox (cdr a)) x) x
                                         (set-box! (cdr a) x))) x acc)
                    (helper (unbox (cdr s)) (remv s ls) (cons s acc)))))))
    (helper x ls '())))


(define a-list `((c . ,(box 15)) (e . ,(box 'f)) (b . ,(box 'c)) (a . ,(box 'b))))
(walk-symbol-update 'a a-list)