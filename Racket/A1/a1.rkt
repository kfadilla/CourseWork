#lang racket
;1
(define countdown
  (λ (n)
  (cond
    [(zero? n) '(0)]
    [else (cons n
                (countdown (sub1 n)))])))

;(countdown 5)
;2
(define insertR
  (λ (x y ls)
    (cond
      [(null? ls) ls]
      [else (if (eqv? (car ls) x) (cons x
                                        (cons y
                                              (insertR x y (cdr ls))))
                (cons (car ls) (insertR x y (cdr ls))))])))
;foldr version
(define insertR-fr
  (λ (x y ls)
    (foldr (λ (a b)
             (cond
               [(eqv? x a) (cons x (cons y b))]
               [else (cons a b)])) '() ls)))


;(insertR-fr 'x 'y '(x z z x y x))
;3
(define remv-1st
  (λ (x ls)
    (cond
      [(null? ls) ls]
      [(eqv? x (car ls)) (cdr ls)]
      [else (cons (car ls)
                  (remv-1st x (cdr ls)))])))

;(remv-1st 'x '(x y z x))

;4
(define list-index-ofv?
  (λ (x ls)
    (cond
      [(eqv? x (car ls)) 0]
      [else (add1 (list-index-ofv? x (cdr ls)))])))
;(list-index-ofv? 'x '(x y z x x))

;5
(define filter
  (λ (f ls)
    (cond
      [(null? ls) empty]
      [else (if (f (car ls)) (cons (car ls)
                                   (filter f (cdr ls)))
                (filter f (cdr ls)))])))
;foldr
(define filter-fr
  (λ (f ls)
    (foldr (λ (a b)
             (cond
               [(f a) (cons a b)]
               [else b])) '() ls)))
;(filter-fr even? '(1 2 3 4 5 6))
;(filter even? '(1 2 3 4 5 6))

;6
(define zip
  (λ (ls1 ls2)
    (cond
      [(null? ls1) empty]
      [(null? ls2) empty]
      [else (cons (cons (car ls1)
                        (car ls2))
                  (zip (cdr ls1) (cdr ls2)))])))

;(zip '(1 2 3) '(a b c))

;7
(define map
  (λ (f ls)
    (cond
      [(null? ls) empty]
      [else (cons (f (car ls))
                  (map f (cdr ls)))])))

(define map-fr
  (λ (f ls)
    (foldr (λ (a b)
             (cons (f a) b)) '() ls)))
;(map add1 '(1 2 3 4))

;8
(define append
  (λ (ls1 ls2)
    (cond
      [(null? ls1) ls2]
      [else (cons (car ls1)
                  (append (cdr ls1) ls2))])))

;foldr
(define append-fr
  (λ (ls1 ls2)
    (foldr cons ls2 ls1)))

;(append '(a b c) '(1 2 3))
;(append-fr '(a b c) '(1 2 3))
;9
(define reverse
  (λ (ls)
    (cond
      [(null? ls) '()]
      [else (append (reverse (cdr ls)) `(,(car ls)))])))

(define reverse-fr
  (λ (ls)
    (foldr (λ (a b) (append b `(,a))) '() ls)))
;(reverse '(a 3 x))
;(reverse-fr '(a 3 x))

;10
(define fact
  (λ (n)
    (cond
      [(zero? n) 1]
      [else (* n (fact (sub1 n)))])))

;11
(define memv
  (λ (x ls)
    (cond
      [(null? ls) #f]
      [(eqv? (car ls) x) ls]
      [else (memv x (cdr ls))])))

;(memv 'a '(a b c))
;(memv 'b '(a ? c))
;(memv 'b '(a b c b))

;12
(define fib
  (λ (n)
    (cond
      [(< n 2) n]
      [else (+ (fib (- n 1))
               (fib (- n 2)))])))

;(fib 7)

;13
(equal? '((w x) y (z)) '((w . (x . ())) . (y . ((z . ()) . ()))))

;14
(define binary->natural
  (λ (ls)
    (cond
      [(null? ls) 0]
      [else (+ (car ls) (* 2 (binary->natural (cdr ls))))])))

(define binary->natural-fr
  (λ (ls)
    (foldr (λ (a b) (+ a (* 2 b))) 0 ls)))
;(binary->natural '(0 0 1))
;(binary->natural-fr '(0 0 1))

;15
(define minus
  (λ (n1 n2)
    (cond
      [(zero? n2) n1]
      [else (minus (sub1 n1) (sub1 n2))])))

;(minus 100 50)

(define div
  (λ (n1 n2)
    (cond
      [(zero? n1) 0]
      [else (+ 1 (div (- n1 n2) n2))])))

;(div 50 5)

(define append-map
  (λ (f ls)
    (cond
      ((null? ls) empty)
      (else (append (f (car ls)) (append-map f (cdr ls)))))))

(define append-map-fr
  (λ (f ls)
    (foldr (λ (a b) (append (f a) b)) '() ls)))
;(append-map countdown (countdown 5))
;(append-map countdown (countdown 5))

(define set-difference
  (λ (s1 s2)
    (cond
      [(null? s1) empty]
      [(null? s2) s1]
      [else (set-difference (filter
                             (lambda (x)
                               (not (eqv? x (car s2)))) s1)
                            (cdr s2))])))

(define (set-difference-fr s1 s2)
  (foldr (λ (a b)
           (append (if (not (member a s2)) (list a) '()) b)) '() s1)) 

;(set-difference '(1 2 3 4 5) '(2 4 6 8))
;(set-difference-fr '(1 2 3 4 5) '(2 4 6 8))


(define powerset
  (λ (set)
    (cond
      ((null? set) '(()))
      (else (append (powerset (cdr set)) (map (lambda (subset)
                                             (cons (car set) subset)) (powerset (cdr set))))))))

(define (powerset-fr ls)
  (foldr (lambda (a b)
           (append b (map (λ (subset)
                            (cons a subset)) b))) '(()) ls))

;(powerset '(x y z))
;(powerset-fr '(x y z))


;(define cartesian-product
 ; (λ (ls)
  ;  (cond
   ;   [(null? ls) '()]
    ;  [else (append-map (lambda (a)
     ;                         (map (lambda (b)
      ;                               (cons a b))
       ;;                            (cartesian-product (cdr ls))))
         ;                   (car ls))])))


(define (cartesian-product l)
  (cond
    [(null? (car l)) '()]
    [else (append (map
                   (λ (x)
                     (cons (caar l) (list x)))
                   (cadr l))
                  (cartesian-product (cons (cdar l) (cdr l))))]))


(define (cartesian-product-fr l)
  (foldr (λ (a b)
            (append (map (λ ( c)
                           (cons a (list c))
                           )
                         (cadr l))
                    b)
           )
         `()
         (car l)
         ))


;(cartesian-product '((5 4) (3 2 1)))
;(cartesian-product-fr '((5 4) (3 2 1)))

(define (collatz n)
    (if (> n 0) 1 "Invalid Value"))


(define quine
  (λ (n)
    #t))