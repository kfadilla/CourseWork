#lang racket
(require racket/trace)


(define empty-k
  (lambda ()
    (let ((once-only #f))
      (lambda (v)
        (if once-only
	    (error 'empty-k "You can only invoke the empty continuation once")
	    (begin (set! once-only #t) v))))))

(define binary-to-decimal-cps
  (lambda (n k)
    (cond
      [(null? n) (k 0)]
      [else (binary-to-decimal-cps (cdr n)
                                   (lambda (a)
                                     (k (+ (car n) (* 2 a)))
                                     ))]
      )))
;(binary-to-decimal-cps '(1 1 0 1) (empty-k))
(define times-cps
  (lambda (ls k)
    (cond
      [(null? ls) (k 1)]
      [(zero? (car ls)) (k 0)]
      [else (times-cps (cdr ls)
                       (lambda (v) (k (* (car ls) v))))])))
;(times-cps '(1 2 3 4 5) (empty-k))

(define times-cps-shortcut
  (lambda (ls k)
    (cond
      [(null? ls) (k 1)]
      [(zero? (car ls)) 0]
      [else (times-cps-shortcut(cdr ls)
                               (lambda (v) (k (* (car ls) v))))])))

;(times-cps-shortcut '(1 2 3 4 5) (empty-k))
(define plus-cps
  (lambda (m k)
    (k (lambda (n k)
         (k (+ m n))))))
;(trace plus-cps)
;((plus-cps 2 (empty-k)) 3 (empty-k))

;((plus-cps ((plus-cps 2 (empty-k)) 3 (empty-k)) (empty-k)) 5 (empty-k))
(define remv-first-9*-cps
  (lambda (ls k)
    (cond
      [(null? ls) (k '())]
      [(pair? (car ls))
       (remv-first-9*-cps
        (car ls)
        (lambda (v)
          (cond
            [(equal? (car ls) v)
             (remv-first-9*-cps
              (cdr ls)
              (lambda (v) (k (cons (car ls) v))))]
            [else (remv-first-9*-cps
                   (car ls)
                   (lambda (v) (k (cons v (cdr ls)))))])))]
      [(eqv? (car ls) '9) (k (cdr ls))]
      [else (remv-first-9*-cps
             (cdr ls)
             (lambda (v) (k (cons (car ls) v))))])))

;(remv-first-9*-cps '(((((9) 9) 9) 9) 9) (empty-k))
(define cons-cell-count-cps
  (lambda (ls k)
    (cond
      [(pair? ls)
       (cons-cell-count-cps (car ls)
                            (lambda (a) (cons-cell-count-cps (cdr ls)
                                                             (lambda (b) (k (add1 (+ a b))))
                                                             )))]
      [else (k 0)]
      )))

(define find-cps
  (lambda (u s k)
    (let ([pr (assv u s)])
      (if pr (find-cps (cdr pr) s k) u))))

;(find-cps 7 '((5 . a) (6 . 5) (7 . 6)) (empty-k))

(define ack-cps
  (lambda (m n k)
    (cond
      [(zero? m) (k (add1 n))]
      [(zero? n) (ack-cps (sub1 m) 1 k)]
      [else (ack-cps m
                     (sub1 n)
                     (lambda (a) (ack-cps (sub1 m) a k)))]
      )))

;(ack-cps 1 1 (empty-k))

(define fib-cps
  (lambda (n k)
    ((lambda (fib-cps k)
       (fib-cps fib-cps n k))
     (lambda (fib-cps n k)
       (cond
	 [(zero? n) (k 0)]
	 [(zero? (sub1 n)) (k 1)]
         [else (fib-cps fib-cps
                        (sub1 n)
                        (lambda (a) (fib-cps fib-cps
                                             (sub1 (sub1 n))
                                             (lambda (b) (k (+ a b))))))]))
     k)))
;(trace fib-cps)
;(fib-cps 3 (empty-k))

(define unfold-cps
  (lambda (p f g seed k)
    ((lambda (h k)
       (h h (lambda (v) (v seed '() k))))
     (lambda (h k2)
       (k2 (lambda (seed ans k3)
         (p seed
            (lambda (v)
              (if v
                  (k3 ans)
                  (h h
                     (lambda (v2)
                       (g seed
                          (lambda (v3)
                            (f seed
                               (lambda (v4)
                                 (v2 v3 (cons v4 ans) k3)))))))))))))
     k)))

;(unfold-cps null? car cdr '(a b c d e) (empty-k))
(define empty-s
  (lambda ()
    '()))
(define unify-cps
  (lambda (u v s k)
    (cond
      [(eqv? u v) (k s)]
      [(number? u) (cons (cons u v) s)]
      [(number? v) (unify-cps v u s k)]
      [(pair? u)
       (if (pair? v)
           (let ([s (unify-cps
                     (find-cps (car u) s (empty-k)) (find-cps (car v) s (empty-k)) s k)])
             (if s
                 (unify-cps
                  (find-cps (cdr u) s (empty-k)) (find-cps (cdr v) s (empty-k)) s k)
                 (k #f)))
             (k #f))]
      [else (k #f)])))

;(unify-cps 'x 'y (empty-s) (empty-k))
(define M-cps
  (lambda (f k)
    (k (lambda (ls k)
         (cond
           [(null? ls) (k '())]
           [else (f (car ls)
                    (lambda (v)
                      (M-cps f (lambda (v2)
                                 (v2 (cdr ls)
                                     (lambda (v3)
                                       (k (cons v v3))))))))])))))

(define use-of-M-cps
  (M-cps (lambda (n k) (k (add1 n))) (lambda (f) (f '(1 2 3 4 5) (empty-k)))))