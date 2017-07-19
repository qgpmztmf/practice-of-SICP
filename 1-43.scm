#lang racket
(define (repeated f n)
  (if (= n 1)
      f
      (compose (repeated f (- n 1)) f)))
;((repeated square 2) 5)
