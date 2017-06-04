#lang racket
;;define >=
(define (>= x y)
  (or (> x y) (= x y)))
;;define min
(define (min a b c)
  (cond ((and (>= b a) (>= c a)) a)
	((and (>= c b) (>= a b)) b)
	(else c)))

(define (sum2Of3 a b c)
(- (+ a b c)
   (min a b c)))

(sum2Of3 3 3 3)
