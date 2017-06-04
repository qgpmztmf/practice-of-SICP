#lang racket
(define (f n)
  (cond ((< n 3) n)
	(else (+ (f (- n 1))
		 (* 2 (f (- n 2)))
		 (* 3 (f (- n 3)))))))

(define (f_fast a b c n) 
  (cond ((= n 0) c)
	((= n 1) b)
	((= n 2) a)
	(else (f_fast (+ a (+ (* 2 b) (* 3 c))) a b (- n 1)))))
(f 10)
(f_fast 2 1 0 0)
