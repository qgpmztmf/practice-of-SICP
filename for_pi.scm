#lang racket
(define (cube x) (* x (square x)))
(define (inc x) (+ x 1))
(define (square x) (* x x))

(define (product a b next act)
  (if (> a b)
      1
      (* (act a)
	 (product (next a) b next act))))

(define (product_iter a b next act)
  (define (iter a result) 
    (if (> a b)
	result
	(iter (next a) (* (act a) result))))
  (iter a 1))
(define (pi x)
  (if (= 0 (remainder x 2))
      (/ (+ x 2) (+ x 1))
      (/ (+ x 1) (+ x 2))))

(* 4 (exact->inexact (product_iter 1 10000 inc pi)))
(product_iter 1 1000 inc pi)
