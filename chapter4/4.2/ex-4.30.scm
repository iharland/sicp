;; Exercise 4.30
;;
;; Cy D. Fect, a reformed C programmer, is worried that some side effects
;; may never take place, because the lazy evaluator doesn't force
;; the expressions in a sequence.
;;
;; Since the value of an expression in a sequence other than the last one
;; is not used (the expression is there only for its effect, such as
;; assigning to a variable or printing), there can be no subsequent use of
;; this value (e.g., as an argument to a primitive procedure) that
;; will cause it to be forced.
;;
;; Cy thus thinks that when evaluating sequences, we must force
;; all expressions in the sequence except the final one.
;;
;; He proposes to modify eval-sequence from section 4.1.1 to use
;; 'actual-value' rather than 'eval':

(define (eval-sequence exps env)
  (cond ((last-exp? exps) (eval (first-exp exps) env))
        (else (actual-value (first-exp exps) env)
              (eval-sequence (rest-exps exps) env))))

;; a. Ben Bitdiddle thinks Cy is wrong.
;;    He shows Cy the for-each procedure described in exercise 2.23,
;;    which gives an important example of a sequence with side effects:

(define (for-each proc items)
  (if (null? items)
      'done
      (begin (proc (car items))
             (for-each proc (cdr items)))))

;; He claims that the evaluator in the text (with the original eval-sequence)
;; handles this correctly:

;;; L-Eval input:
(for-each (lambda (x) (newline) (display x))
          (list 57 321 88))
;; 57
;; 321
;; 88

;;; L-Eval value:
done

;; Explain why Ben is right about the behavior of for-each.

;; a. Answer
;;
;;    Ben is right about the behavior of for-each simply because
;;    the procedure for-each forces the thunk associated with
;;    its parameter 'proc' in case there are more items.
;;    The thunk resolves to a procedure that, when applied,
;;    forces the thunk associated with its parameter 'x'
;;    by applying the primitive procedure 'display'.


;; b. Cy agrees that Ben is right about the for-each example,
;;    but says that that's not the kind of program he was thinking about
;;    when he proposed his change to eval-sequence.
;;    He defines the following two procedures in the lazy evaluator:

(define (p1 x)
  (set! x (cons x '(2)))
  x)

(define (p2 x)
  (define (p e)
    e
    x)
  (p (set! x (cons x '(2)))))

;; What are the values of (p1 1) and (p2 1) with the original eval-sequence?

(p1 1) ; (1 2)
(p2 1) ; 1

;; What would the values be with Cy's proposed change to eval-sequence?

(p1 1) ; (1 2)
(p2 1) ; (1 2)

;; The original eval-sequence does not force the thunk associated with
;; the parameter 'e' of the inner procedure p, thereby leaving x be 1.
;;
;; With Cy's proposed change the above mentioned thunk gets forced,
;; which creates a list and assignes it to x.


;; c. Cy also points out that changing eval-sequence as he proposes
;;    does not affect the behavior of the example in part a.
;;    Explain why this is true.

;; This is true because Cy's proposed change to eval-sequence
;; forces the thunk that is forced by the primitive procedure
;; 'display' anyway.


;; d. How do you think sequences ought to be treated in the lazy evaluator?
;;    Do you like Cy's approach, the approach in the text,
;;    or some other approach?

;; Cy's approach treats sequences better if there are expressions
;; intended to produce side effects.
;; In case there are no side effects, either method works fine,
;; with a small addition that the original eval-sequence delayes
;; forcing thunks until the last possible moment.
;;
;; Should the program be able to discern between statements with
;; side effects and those without, eval-sequence can be made
;; to alternate between two methods.
