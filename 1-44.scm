#lang racket
(define (repeated f n)
  (if (= n 1)
      f
      (compose (repeated f (- n 1)) f)))
;((repeated square 2) 5)

(define (smooth f)
  (define dx 0.001)
  (lambda (x) (/ (+ (f (- x dx)) (f x) (f (+ x dx))) 3)))
;((smooth (cubic 1 1 1)) 3)
;(((repeated smooth 5) (cubic 1 1 1)) 3)
