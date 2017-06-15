#lang racket
(define (expt_fast b n product)
  (define (square x) (* x x))
  (define (ramainder n m)
    (cond ((< n m) n)
	  (else (ramainder (- n m) m))))
  (cond ((= n 0) product)
	((> n 0) (cond ((= 0 (ramainder n 2)) (expt_fast (square b) (/ n 2) product))
		       (else (expt_fast b (- n 1) (* b product)))))))
(expt_fast 2 10 1)
