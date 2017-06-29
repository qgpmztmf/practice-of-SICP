#lang racket
(define (simpson a b n f)
  (define (add_s x) (+ x (/ (- b a) n)))
  (define (sum_fixed a b next act times)
    (define (multi x) 
      (cond ((= 0 times) x)
	    ((= n times) x)
	    ((= 1 (remainder times 2)) (* x 4))
	    ((= 0 (remainder times 2)) (* x 2))))
    (if (> a b)
      0
      (+ (multi (act a))
	 (sum_fixed (next a) b next act (+ times 1)))))
  
  (* (/ (/ (- b a) n) 3)
     (sum_fixed a b add_s f 0))
)
  (define (square x) (* x x))
(simpson 0 0.5 500 square)
