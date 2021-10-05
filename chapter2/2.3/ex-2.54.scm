;; Exercise 2.54
;;
;; Two lists are said to be equal if they contain equal elements arranged in the same order.
;; For example,
;;
;; (equal? '(this is a list) '(this is a list))
;;
;; is true, but
;;
;; (equal? '(this is a list) '(this (is a) list))
;;
;; is false. To be more precise, we can define 'equal?' recursively in terms of
;; the basic eq? equality of symbols by saying that a and b are equal? if
;; they are both symbols and the symbols are eq?, or if they are both lists
;; such that (car a) is equal? to (car b) and (cdr a) is equal? to (cdr b).
;;
;; Using this idea, implement equal? as a procedure.


(define (deep-eq? a b)
  (cond ((and (not (pair? a))
              (not (pair? b)))
         (eq? a b))
        ((and (pair? a) (pair? b))
         (and (deep-eq? (car a) (car b))
              (deep-eq? (cdr a) (cdr b))))
        (else false)))


;; (deep-eq? 1 1) ; true
;; (deep-eq? 1 2) ; false

;; (deep-eq? 1 '()) ; false
;; (deep-eq? '() 1) ; false

;; (deep-eq? '() '()) ; true

;; (deep-eq? '(1 2 3) '(1 2 3))           ; true
;; (deep-eq? '(1 '(2 3) 4) '(1 '(2 3) 4)) ; true

;; (deep-eq? '(this is a list) '(this is a list))   ; true
;; (deep-eq? '(this is a list) '(this (is a) list)) ; false
