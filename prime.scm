#lang racket
(define (min_divisor n)
  (define (min_divisor_test n m)
    (cond ((> (square m) n) n)
	  ((= (remainder n m) 0) m)
	  (else (min_divisor_test n (+ 1 m)))))
  (min_divisor_test n 2))
;(min_divisor 121)

(define (prime? n)
  (= n (min_divisor n)))
;(prime? 996)

;use Fermat's little theorem to find a prime
(define (expmod base exp n)
  (remainder (expt_fast base exp 1) n))

(define (expmod_new base exp n)
  (cond ((= exp 0) 1)
	((= 0 (remainder exp 2)) (remainder (square (expmod_new base (/ exp 2) n)) n))
        (else (remainder (* base (expmod base (- exp 1) n)) n))
))

(define (fermat_test n)
  (define (fermat_test_try a)
    (= a (expmod_new a n n)))
(fermat_test_try (+ 1 (- (random n) 1))))

(define (fast_prime? n times)
  (cond ((= times 0) #t)
	((fermat_test n) (fast_prime? n (- times 1)))
	(else #f)))

;(fast_prime? 997 5)
