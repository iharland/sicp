;; Some common definitions used globally across all the chapters.

(define (square x)
  (* x x))

(define (cube x)
  (* x x x))

(define (inc n)
  (+ n 1))

(define (dec n)
  (- n 1))

(define (identity x) x)

(define (average a b)
  (/ (+ a b) 2))

(define (fib-iter a b n)
  (if (> n 0)
      (fib-iter (+ a b) a (- n 1))
      b))

(define (fib n)
  (fib-iter 1 0 n))

(define (prime? n)
  (not (div-iter n 2)))

(define (div-iter n divisor)
  (cond ((< n (square divisor)) false)
	((divisible? n divisor) true)
	(else (div-iter n (+ divisor 1)))))

(define (divisible? n divisor)
  (= (remainder n divisor) 0))

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (all-equal? seq)
  (cond ((not (pair? seq)) true)
        ((not (pair? (cdr seq))) true)
        (else
         (if (equal? (car seq) (cadr seq))
             (all-equal? (cdr seq))
             false))))

(define (compose f g)
  (lambda (x)
    (f (g x))))

(define (repeated f n)
  (if (> n 0)
      (compose f (repeated f (- n 1)))
      identity))

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1)
       (variable? v2)
       (eq? v1 v2)))
