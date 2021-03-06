;; Exercise 2.1
;;
;; Define a better version of make-rat that handles both positive and negative arguments.
;; Make-rat should normalize the sign so that if the rational number is positive,
;; both the numerator and denominator are positive,
;; and if the rational number is negative, only the numerator is negative.

(load "workbook.scm")

(define (make-rat n d)
  (if (< d 0)
      (make-rat (- n) (- d))
      (let ((g (gcd n d)))
        (cons (/ n g) (/ d g)))))

;; gcd is available by default

;; (print-rat (make-rat 1 2))   ; 1/2
;; (print-rat (make-rat -1 2))  ; -1/2
;; (print-rat (make-rat 1 -2))  ; -1/2
;; (print-rat (make-rat -1 -2)) ; 1/2
