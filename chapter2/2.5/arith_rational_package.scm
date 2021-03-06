;; Rational numbers package

(load "../export-defs.scm")
(load "./arith_lib.scm")

(define (install-rational-package)
  ;; internal procedures
  (define (numer x) (car x))
  (define (denom x) (cdr x))
  (define (make-rat n d)
    (let ((g (gcd n d)))
      (cons (/ n g) (/ d g))))
  (define (add-rat x y)
    (make-rat (+ (* (numer x) (denom y))
                 (* (numer y) (denom x)))
              (* (denom x) (denom y))))
  (define (sub-rat x y)
    (make-rat (- (* (numer x) (denom y))
                 (* (numer y) (denom x)))
              (* (denom x) (denom y))))
  (define (mul-rat x y)
    (make-rat (* (numer x) (numer y))
              (* (denom x) (denom y))))
  (define (div-rat x y)
    (make-rat (* (numer x) (denom y))
              (* (denom x) (numer y))))
  (define (add5 n1 n2 n3 n4 n5)
    (accumulate add (tag n1)
                (map tag (list n2 n3 n4 n5))))
  (define (mul5 n1 n2 n3 n4 n5)
    (accumulate mul (tag n1)
                (map tag (list n2 n3 n4 n5))))
  (define (equ? x y)
    (and (= (numer x) (numer y))
         (= (denom x) (denom y))))
  (define (zero? x) (= (numer x) 0))
  (define (neg-rational x)
    (make-rat (neg (numer x)) (denom x)))
  (define (raise x)
    (exact->inexact (/ (numer x) (denom x))))
  (define (project x)
    (round (/ (numer x) (denom x))))

  ;; interface to rest of the system
  (define types-arity-5
    '(rational rational rational rational rational))
  (define (tag x) (attach-tag 'rational x))
  (list (export-def 'add '(rational rational)
                    (lambda (x y) (tag (add-rat x y))))
        (export-def 'sub '(rational rational)
                    (lambda (x y) (tag (sub-rat x y))))
        (export-def 'mul '(rational rational)
                    (lambda (x y) (tag (mul-rat x y))))
        (export-def 'div '(rational rational)
                    (lambda (x y) (tag (div-rat x y))))
        (export-def 'add5 types-arity-5 add5)
        (export-def 'mul5 types-arity-5 mul5)
        (export-def 'equ? '(rational rational) equ?)
        (export-def '=zero? '(rational) zero?)
        (export-def 'neg '(rational)
                    (lambda (x) (tag (neg-rational x))))
        (export-def 'raise '(rational) raise)
        (export-def 'project '(rational) project)
        (export-def 'make 'rational
                    (lambda (n d) (tag (make-rat n d))))))
