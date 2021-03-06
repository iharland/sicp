;; Exercise 2.67
;;
;; Define an encoding tree and a sample message:

(load "workbook.scm")

(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree
                   (make-leaf 'B 2)
                   (make-code-tree (make-leaf 'D 1)
                                   (make-leaf 'C 1)))))

(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))

;; Use the decode procedure to decode the message, and give the result.

(decode sample-message sample-tree) ; (a d a b b c a)

;; 0 110 0 10 10 111 0
;; a   d a  b  b   c a
