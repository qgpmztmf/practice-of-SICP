#lang racket
;;define sqrt
(define (sqrt x)
  (define (goodEnough a b)
          (< (abs (- a b))
             0.00001))

  (define (improve guess x)
          (/ (+ guess (/ x guess))
       　	2))

　(define (newton guess x) 
          (if (goodEnough guess (improve guess x))
              guess
	      (newton (improve guess x) x))) 
(newton (/ x 2) x))

(exact->inexact (sqrt 1))

