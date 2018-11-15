#lang racket
;initialize
(define m* #f)
(define n* #f)
(define k* #f)
(define v* #f)
(define ls* #f)

(define empty-k
  (lambda ()
    `(empty-k)))

(define ack-inner-k
  (lambda (m k)
    `(ack-inner-k ,m ,k)))

(define ack-apply-k
  (lambda ()
      (match k*
        [`(empty-k) v*]
        [`(ack-inner-k ,m ,k) (begin
                            (set! m* m)
                            (set! n* v*)
                            (set! k* k)
                            (ack))])))
(define ack-reg-driver
  (lambda (m n)
    (begin
      (set! m* m)
      (set! n* n)
      (set! k* (empty-k))
      (ack))))
(define ack
  (lambda ()
    (cond
      [(zero? m*) (begin
                    (set! v* (add1 n*))
                    (ack-apply-k))]
      [(zero? n*) (begin
                    (set! m* (sub1 m*))
                    (set! n* 1)
                    (ack))]
      [else (begin
              (set! n* (sub1 n*))
              (set! k* (ack-inner-k (sub1 m*) k*))
              (ack))]
      )))

;(ack-reg-driver 2 2)


(define depth-outer-k
  (lambda (ls k)
    `(depth-outer-k ,ls ,k)))
(define depth-inner-k
  (lambda (l k)
    `(depth-inner-k ,l ,k)))
(define depth-apply-k
  (lambda ()
      (match k*
        [`(empty-k) v*]
        [`(depth-outer-k ,ls ,k) (begin
                               (set! ls* ls)
                               (set! k* (depth-inner-k v* k))
                               (depth))]
        [`(depth-inner-k ,l ,k) (let ([l (add1 l)])
                                (if (< l v*)
                                    (begin
                                      (set! k* k)
                                      (depth-apply-k))
                                    (begin
                                      (set! k* k)
                                      (set! v* l)
                                      (depth-apply-k))))])))
(define depth-reg-driver
  (lambda (ls)
    (begin
      (set! ls* ls)
      (set! k* (empty-k))
      (depth))))
(define depth
  (lambda ()
    (cond
      [(null? ls*) (begin (set! v* 1) (depth-apply-k))]
      [(pair? (car ls*)) (begin
                           (set! k* (depth-outer-k (car ls*) k*))
                           (set! ls* (car ls*))
                           (depth))]
      [else (begin
              (set! ls* (cdr ls*))
              (depth))]
      )))

;(depth-reg-driver '(1 (2 (3 (4)))))


(define fact-inner-k
  (lambda (n k)
    `(fact-inner-k ,n ,k)))
(define fact-reg-driver
  (lambda (n)
    (begin
      (set! n* n)
      (set! k* (empty-k))
      (fact))))

(define fact-apply-k
  (lambda ()
      (match k*
        [`(empty-k) v*]
        [`(fact-inner-k ,n ,k) (begin
                               (set! k* k)
                               (set! v* (* n v*))
                               (fact-apply-k))])))
(define fact
  (lambda ()
    ((lambda (fact) (fact fact))
     (lambda (fact)
       (cond
         [(zero? n*) (begin
                       (set! v* 1)
                       (fact-apply-k))]
         [else (begin
                   (set! k* (fact-inner-k n* k*))
                   (set! n* (sub1 n*))
                   (fact fact))]
     )))))

;(fact-reg-driver 5)


(define pascal-outer-k
  (lambda (m a k)
    `(pascal-outer-k ,m ,a ,k)))
(define pascal-inner-k
  (lambda (a k)
    `(pascal-inner-k ,a ,k)))
(define pascal-outer-k-f
  (lambda (k)
    `(pascal-outer-k-f ,k)))

(define pascal-apply-k
  (lambda ()
      (match k*
      [`(empty-k) v*]
      [`(pascal-outer-k ,m ,a ,k) (begin
                                    (set! k* (pascal-inner-k a k))
                                    (v* m a))]
      [`(pascal-inner-k ,a ,k) (begin
                                 (set! v* (cons a v*))
                                 (set! k* k)
                                 (pascal-apply-k))]
      [`(pascal-outer-k-f ,k) (begin (set! k* k) (v* 1 0))])))
(define pascal-reg-driver
  (lambda (n)
    (begin
      (set! n* n)
      (set! k* (empty-k))
      (pascal))))


(define pascal
  (lambda ()
    (let ((pascal
           (lambda (pascal)
             (begin
               (set! v* (lambda (m a)
                          (cond
                            [(> m n*) (begin
                                        (set! v* '())
                                        (pascal-apply-k))]
                            [else (let ([a (+ a m)])
                                    (begin
                                      (set! k* (pascal-outer-k (add1 m) a k*))
                                      (pascal pascal)))])))
               (pascal-apply-k)))))
      (begin
        (set! k* (pascal-outer-k-f k*))
        (pascal pascal)))))

;(pascal-reg-driver 10)

