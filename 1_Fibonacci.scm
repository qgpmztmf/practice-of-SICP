#lang racket
;Fibonacci
(define (fib n) 
(cond ((= n 0) 0)
      ((= n 1) 1)
      (else (+ (fib (- n 1))
               (fib (- n 2))))))
(fib 20)

(define (fib_fast a b n)
  (if (> n 0)
      (fib_fast b (+ a b) (- n 1))
      a))
(fib_fast 0 1 20)
