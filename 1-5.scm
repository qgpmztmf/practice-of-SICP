;;testing whether a complier is under Normal order or Applicative order
#lang racket
(define (p) (p))
(define (test x y)
  (if (= 0 x)
      0
      y))
(test 0 (p))
