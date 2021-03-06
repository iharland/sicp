;; Exercise 2.24
;;
;; Suppose we evaluate the expression (list 1 (list 2 (list 3 4))).
;; Give the result printed by the interpreter, the corresponding box-and-pointer structure,
;; and the interpretation of this as a tree.


;; 1. The result printed by the interpreter

(list 1 (list 2 (list 3 4))) ; (1 (2 (3 4)))


;; 2. The corresponding box-and-pointer structure

;; -> [ x ][ x-]----->[ x ][ x-]----->[ x ][ x-]----->[ x ][ / ]
;;      |               |               |               |
;;      1               2               3               4


;; 3. The interpretation of this as a tree

;; (1 (2 (3 4)))
;;      |
;;     / \
;;    1   (2 (3 4))
;;           |
;;          / \
;;         2   (3 4)
;;               |
;;              / \
;;             3   4
