#lang racket

(require "mk.rkt")
(require "numbers.rkt")

; Part1:

;; 1 What is the value of 
;(run 2 (q)
;  (== 5 q)
;  (conde
;   [(conde 
;     [(== 5 q)
;      (== 6 q)])
;    (== 5 q)]
;   [(== q 5)]))
;answer: '((5))
;Explanation: 
; first, it is asking for a list of maximum 2 result from q
; then (== 5 q) associates q with 5
; First conde fails because of inconsistence
; second conde succeeds because (== q 5) succeeds, which has been set originally
; Therefore, it returns '((5))

;; 2 What is the value of
;(run 1 (q)
;  (fresh (a b)
;    (== `(,a ,b) q)
;   (absento 'tag q)
;   (symbolo a)))
;answer: '(((_.0 _.1)))
;Explanation:
; (== `(,a ,b) q): associates `(,a ,b) with q (a,b are reified values)
; so we have (_.0 _.1), which means any two things
; (run 1 (q)...) ask for a list of maximum of 1 results of q.
; Therefore, it returns '(((_.0 _.1)))


;; 3 What do the following miniKanren constraints mean?
;; a == means equal to.
;; b =/= means not equal to.
;; c absento means no occurance.
;; d numbero means it is a number.
;; e symbolo means it is a symbol.

;Part 2:
(define assoco
  (λ (x ls o)
    (fresh (a d aa da)
           (== `(,a . ,d) ls)
           (== `(,aa . ,da) a)
           (conde
            ((== aa x) (== a o))
            ((=/= aa x) (assoco x d o))))))
#;
(run* q (assoco 'x '((x . 5)) '(x . 5)))

(define reverseo
  (λ (ls o)
    (conde
     ((== '() ls) (== '() o))
     ((fresh (a d res)
             (== `(,a . ,d) ls)
             (reverseo d res)
             (appendo res `(,a) o))))))

#;
(run* q (reverseo '(a b c d) q))

(define stuttero
  (λ (ls o)
    (conde
      ((== '() ls) (== '() o))
      ((fresh (a d res)
              (== `(,a . ,d) ls)
              (== o `(,a ,a . ,res))
              (stuttero d res))))))

#;
(run 1 q (fresh (a b c d) (== q `(,a ,b ,c ,d)) (stuttero `(,b 1) `(,c . ,d))))
