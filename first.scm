#lang racket
(define (square x) (* x x))
;(square 5)

(define (abs x) 
  (cond ((> x 0) x)
        ((= x 0) x)
        ((< x 0) (- x)))) 
;(abs -6)
;(and 1 2 3 4)

;;define >=
(define (>= x y)
  (or (> x y) (= x y)))
;;define min
(define (min a b c)
  (cond ((and (>= b a) (>= c a)) a)
	((and (>= c b) (>= a b)) b)
	(else c)))

(define (sum2Of3 a b c)
(- (+ a b c)
   (min a b c)))

;(sum2Of3 3 3 3)

;;function can be selected
(if (> 4 3) + -)

;;testing whether a complier is under Normal order or Applicative order
(define (p) (p))
(define (test x y)
  (if (= 0 x)
      0
      y))
;;(test 0 (p))

(define (_if predicate then-clause else-clause)
    (cond (predicate then-clause)
          (else else-clause)))

;;(_if #t (display "good") (display "bad"))

;;define sqrt
(define (sqrt x)
  (define (goodEnough a b)
          (< (abs (- a b))
             0.00001))

  (define (improve guess x)
          (/ (+ guess (/ x guess))
       　	2))

　(define (newton guess x) 
          (if (goodEnough guess (improve guess x))
              guess
	      (newton (improve guess x) x))) 
(newton (/ x 2) x))

;(exact->inexact (sqrt 1))

;Fibonacci
(define (fib n) 
(cond ((= n 0) 0)
      ((= n 1) 1)
      (else (+ (fib (- n 1))
               (fib (- n 2))))))
;(fib 20)

(define (fib_fast a b n)
  (if (> n 0)
      (fib_fast b (+ a b) (- n 1))
      a))
;(fib_fast 0 1 20)

;exchange money
(define (exchange x) 
  (define (work x kinds)
    (cond ((= x 0) 1)
	  ((< x 0) 0)
	  ((= kinds 0) 0)
	  (else (+ (work x (- kinds 1))
		   (work (- x (kinds_cost kinds)) kinds)))))
  (define (kinds_cost n) 
    (cond ((= n 1) 1)
	  ((= n 2) 5)
	  ((= n 3) 10)
	  ((= n 4) 25)
	  ((= n 5) 50)))
  (work x 5)
)
;(exchange 5)

;1.11
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
;(f 10)
;(f_fast 2 1 0 0)

(define (tri a b)
  (cond ((= b 1) 1)
	((= b a) 1)
	(else (+ (tri (- a 1) b)
		 (tri (- a 1) (- b 1))))))
;(tri 5 3)

(define (expt b n) 
  (cond ((= n 0) 1)
	(else (* b (expt b (- n 1))))))
;(expt 2 10)



(define (remainder_ n m)
  (cond ((< n m) n)
	(else (remainder (- n m) m))))
;(ramainder 6 2)

(define (expt_fast b n product)
  (cond ((= n 0) product)
	((> n 0) (cond ((= 0 (remainder n 2)) (expt_fast (square b) (/ n 2) product))
		       (else (expt_fast b (- n 1) (* b product)))))))
;(expt_fast 2 10 1)

(define (min_divisor n)
  (define (min_divisor_test n m)
    (cond ((> (square m) n) n)
	  ((= (remainder n m) 0) m)
	  (else (min_divisor_test n (+ 1 m)))))
  (min_divisor_test n 2))
;(min_divisor 19999)

(define (prime? n)
  (= n (min_divisor n)))
;(prime? 996)

;use Fermat's little theorem to find a prime
(define (expmod base exp n)
  (remainder (expt_fast base exp 1) n))

(define (expmod_new base exp n)
  (cond ((= exp 0) 1)
	((= 0 (remainder exp 2)) (remainder (square (expmod_new base (/ exp 2) n)) n))
        (else (remainder (* base (expmod_new base (- exp 1) n)) n))
))
;(expmod_new 3 36000 36000)

(define (fermat_test n)
  (define (fermat_test_try a)
    (= a (expmod_new a n n)))
(fermat_test_try (+ 1 (- (random n) 1))))

(define (fast_prime? n times)
  (cond ((= times 0) #t)
	((fermat_test n) (fast_prime? n (- times 1)))
	(else #f)))

;(fast_prime? 1999 5)


(define (sum a b next act)
  (if (> a b)
      0
      (+ (act a)
	 (sum (next a) b next act))))
(define (cube x) (* x (square x)))
(define (inc x) (+ x 1))
;(sum 1 10 inc cube)

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
;;(product_iter 1 1000 inc pi)


(define (integral a b dx f)
  (define (add_dx x) (+ x dx))
  (* dx
     (sum (+ a (/ dx 2)) b add_dx f))
)

;(integral 0 1 0.0001 square)


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

;(simpson 0 0.5 500 square)

