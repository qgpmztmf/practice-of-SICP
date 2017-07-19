#lang racket
(define (double g)
  (lambda (x) (g (g x))))
(((double (double double)) (lambda (x) (+ x 1))) 5)
