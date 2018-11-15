#lang racket
(define filter-sps
  (lambda (k l1 l2)
    (cond
      [(null? l1) (values l1 l2)]
      [(k (car l1)) (let-values
                        ([(subl1 subl2) (filter-sps k (cdr l1) l2)])
                      (values (cons (car l1) subl1) subl2))]
      [else (let-values
                        ([(subl1 subl2) (filter-sps k (cdr l1) l2)])
              (values subl1 (cons (car l1) subl2)))])))


;(filter-sps even? '(1 2 3 4 5 6 7 8 9 10) '())

;(filter-sps odd? '(1 2 3  4 5 6 7) '())

(define filter*-sps
  (lambda (k l1 l2)
    (cond
      [(null? l1) (values l1 l2)]
      [(null? (car l1)) (values l1 l2)]
      [(pair? (car l1))
       (let-values
           ([(a1 a2) (filter*-sps k (car l1) l2)])
         (let-values ([(b1 b2) (filter*-sps k (cdr l1) l2)])
         (values (cons a1 b1) (cons a2 b2))
         ))
       ]
      [(k (car l1)) (let-values
                        ([(subl1 subl2) (filter*-sps k (cdr l1) l2)])
                      (values (cons (car l1) subl1) subl2))]
      [else (let-values
                        ([(subl1 subl2) (filter*-sps k (cdr l1) l2)])
              (values subl1 (cons (car l1) subl2)))])))


;(filter*-sps odd? '(1 (2 3 (4 5)) 6 7) '())

(define (fib-sps n k)
  (cond
    [(assv n k) => (λ (a) (values (cdr a) k))]
    [(zero? n)  (values 0 (cons (cons 0 0) k))] 
    [(zero? (sub1 n)) (values 1 k)]
    [else (let-values ([(fn-1 fn-1/k) (fib-sps (sub1 n) k)])
            (let-values ([(fn-2 fn-2/k) (fib-sps (sub1 (sub1 n)) fn-1/k)])
              (let ([ans (+ fn-1 fn-2)])
                (values ans (cons (cons n ans) fn-2/k)))))]))

#;
(fib-sps 10 '())

(define-syntax and*
  (syntax-rules ()
    [(and* ) #t]
    [(and* n) n]
    [(and* a b ...) (if a (and* b ...) #f)]))

;(and* #t #t #t #f #t #t #t #t #t)
(define-syntax list*
  (syntax-rules ()
    [(list* ,n) ,n]
    [(list* a b ...) (cons a (list* b ...))]))

;(list* 'a 'b 'c 'd)

(define-syntax macro-list
  (syntax-rules ()
    [(macro-list) '()]
    [(macro-list a b ...) (cons a (list* b ...))]
    ))

;(macro-list 1 'b 2 'd)

(define-syntax mcond
  (syntax-rules ()
    [(mcond (#t bool)) bool]
    [(mcond (#f bool)) #f]
    [(mcond (else sth)) sth]
    [(mcond sth) sth]
    [(mcond a b ...) (if (mcond a) (mcond a) (mcond b ...))]
    ))
#;
(mcond 
    (else 'cat))

(define-syntax macro-map
  (syntax-rules ()
    [(macro-map ,f (a b ...)) (cons (f a) (macro-map f (b ...)))]
    [(macro-map f a) a]
    ))

;(macro-map quote '((trinidad and tobago) (saint vincent and the grenadines) (antigua and barbuda)))