#lang racket
(define (!= x y)
  (not (= x y)))

(define (even? x)
  (= 0 (remainder x 2)))

(define (square x)
  (* x x))

(define (composite? x)
  (define (composite_test x a)
    (cond ((> (square a) x) #f)
	  ((= 0 (remainder x a)) #t)
	  (else (composite_test x (+ a 1)))
	  ))
  (composite_test x 2))

(define (expmod base exp n)
  (cond ((= exp 0) 1)
	((even? exp) (remainder (square (expmod base (/ exp 2) n)) n))
	(else (remainder (* base (expmod base (- exp 1) n)) n))))

(define (carmicheal_test x a)
  (cond ((< a 1) #t)
	((!= a (expmod a x x)) #f)
	(else (carmicheal_test x (- a 1)))))

(define (carmicheal? x)
  (and (carmicheal_test x (- x 1)) (composite? x)))

(define (find_carmicheal_lessthan x)
  (cond ((< x 1) #t)
	(else (if (carmicheal? x)
		  ((display x) (newline) (find_carmicheal_lessthan (- x 1)))
		  (find_carmicheal_lessthan (- x 1))))))
(find_carmicheal_lessthan 10000)


