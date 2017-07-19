#lang racket
(define (cubic a b c)
  (lambda (x) (+ (* x x x) (* a x x) (* b x) c)))
((cubic 1 1 1) 3)
