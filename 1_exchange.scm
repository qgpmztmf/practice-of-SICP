#lang racket
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

(exchange 5)
