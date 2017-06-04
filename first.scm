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
(tri 5 3)
