;; Exercise 1.43
;;
;; If f is a numerical function and n is a positive integer,
;; then we can form the nth repeated application of f,
;; which is defined to be the function whose value at x is f(f(...(f(x))...)).
;;
;; For example, if f is the function x -> x+1,
;; then the nth repeated application of f is the function x -> x+n.
;;
;; If f is the operation of squaring a number,
;; then the nth repeated application of f is the function
;; that raises its argument to the 2^nth power.
;;
;; Write a procedure that takes as inputs a procedure that computes f and a positive integer n
;; and returns the procedure that computes the nth repeated application of f.
;;
;; Your procedure should be able to be used as follows:
;;
;; ((repeated square 2) 5) ; 625

(load "../../common.scm")
(load "ex-1.42.scm")

(define (repeated f n)
  (if (> n 0)
      (compose f (repeated f (- n 1)))
      identity))


;; ((repeated square 0) 5) ; 5
;; ((repeated square 1) 5) ; 25

;; ((repeated square 2) 5) ; 625
;; ((repeated square 4) 2) ; 65336

;; ((repeated inc 4) 1)   ; 5
;; ((repeated inc 10) 99) ; 109
