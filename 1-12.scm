#lang racket
(define (tri a b)
  (cond ((= b 1) 1)
	((= b a) 1)
	(else (+ (tri (- a 1) b)
		 (tri (- a 1) (- b 1))))))
(tri 5 3)
