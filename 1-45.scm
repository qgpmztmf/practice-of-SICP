#lang racket

(define tolerance 0.000001)
(define (square x) (* x x))
(define (fixed-point f init)
  (define (close-enough? a b)
    (< (abs (- a b)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
	  (if (close-enough? next guess)
	  next
	  (try next))))
(try init))

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (if (= n 1)
      f
      (compose (repeated f (- n 1)) f)))

(define (average-damp f)
  (lambda (x) (/ (+ x (f x)) 2)))

(define (expt_fast b n product)
  (cond ((= n 0) product)
	((> n 0) (cond ((= 0 (remainder n 2)) (expt_fast (square b) (/ n 2) product))
		       (else (expt_fast b (- n 1) (* b product)))))))

(define (log2m_int m ans)
    (if (or (= m 1) (< m 1))
	ans
	(log2m_int (/ m 2) (+ ans 1))))
(define (n-rt x n)
  (fixed-point ((repeated average-damp (log2m_int n 0)) (lambda (y)  (/ x (expt_fast y (- n 1) 1)))) 1.0))  
(n-rt 64 6)
