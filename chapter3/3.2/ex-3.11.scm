;; Exercise 3.11
;;
;; In section 3.2.3 we saw how the environment model described
;; the behavior of procedures with local state.
;;
;; Now we have seen how internal definitions work.
;; A typical message-passing procedure contains both of these aspects.
;;
;; Consider the bank account procedure of section 3.1.1:
;;
(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch m)
    (cond ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          (else (error "Unknown request -- MAKE-ACCOUNT"
                       m))))
  dispatch)

;; Show the environment structure generated by the sequence
;; of interactions
;;
;; (define acc (make-account 50))
;;
;; ((acc 'deposit) 40)
;; 90
;;
;; ((acc 'withdraw) 60)
;; 30
;;
;; Where is the local state for acc kept?
;;
;; Suppose we define another account
;;
;; (define acc2 (make-account 100))
;;
;; How are the local states for the two accounts kept distinct?
;; Which parts of the environment structure are shared between
;; acc and acc2?


;; Result of defining 'make-account' in the global environment:
;;
;; ----------------------------------------------------------------------------------
;;
;;  Global
;;  Env      make-account---↓
;;                          |
;; -------------------------|--------------------------------------------------------
;;                          |    ↑
;;                          ↓    |
;;                        |x|x|--↑
;;                         |
;;                         ↓
;;               parameters: balance
;;               body: (define withdraw ...)
;;                     (define deposit ...)
;;                     (define dispatch ...)
;;                     dispatch


;; Result of evaluating (define acc (make-account 50))
;;
;; ----------------------------------------------------------------------------------------------
;;
;;  Global
;;  Env      make-account---↓                         acc---↓
;;                          |                               |
;; -------------------------|-------------------------------|------------------------------------
;;                          |    ↑                          |             ↑
;;                          ↓    |                          |             |______________________
;;                        |x|x|--↑                          |           E1|balance:50
;;                         |                                |             |withdraw:
;;                         ↓                                |             |deposit:
;;               parameters: balance                        |             |dispatch:-----↓     ↑
;;               body: (define withdraw ...)                |             |______________|_____|_
;;                     (define deposit ...)                 |             |              |     |
;;                     (define dispatch ...)                ↓             |            |x|x|---↑
;;                     dispatch                           |x|x|-----------↑             ↓
;;                                                         ↓                  parameters:m
;;                                               parameters:m                 body: (cond ...)
;;                                               body: (cond ...)


;; Evaluation of ((acc 'deposit) 40)
;;
;; ------------------------------------------------------------------------------------------------------------------------------------------
;;
;;  Global
;;  Env      make-account---↓                         acc---↓
;;                          |                               |
;; -------------------------|-------------------------------|--------------------------------------------------------------------------------
;;                          |    ↑                          |             ↑
;;                          ↓    |                          |             |__________________________________________________________________
;;                        |x|x|--↑                          |           E1|balance:50
;;                         |                                |             |withdraw:
;;                         ↓                                |             |deposit:
;;               parameters: balance                        |             |dispatch:-----↓     ↑
;;               body: (define withdraw ...)                |             |______________|_____|_____________________________________________
;;                     (define deposit ...)                 |             |              |     |       ↑                      ↑
;;                     (define dispatch ...)                ↓             |            |x|x|---↑       |                      |
;;                     dispatch                           |x|x|-----------↑             ↓            E2|m:'deposit          E3|amount:40
;;                                                         ↓                  parameters:m           <call to dispatch>     <call to deposit>
;;                                               parameters:m                 body: (cond ...)
;;                                               body: (cond ...)


;; Result of evaluating ((acc 'deposit) 40)
;;
;; ----------------------------------------------------------------------------------------------
;;
;;  Global
;;  Env      make-account---↓                         acc---↓
;;                          |                               |
;; -------------------------|-------------------------------|------------------------------------
;;                          |    ↑                          |             ↑
;;                          ↓    |                          |             |______________________
;;                        |x|x|--↑                          |           E1|balance:90
;;                         |                                |             |withdraw:
;;                         ↓                                |             |deposit:
;;               parameters: balance                        |             |dispatch:-----↓     ↑
;;               body: (define withdraw ...)                |             |______________|_____|_
;;                     (define deposit ...)                 |             |              |     |
;;                     (define dispatch ...)                ↓             |            |x|x|---↑
;;                     dispatch                           |x|x|-----------↑             ↓
;;                                                         ↓                  parameters:m
;;                                               parameters:m                 body: (cond ...)
;;                                               body: (cond ...)


;; Evaluation of ((acc 'withdraw) 60)
;;
;; ------------------------------------------------------------------------------------------------------------------------------------------
;;
;;  Global
;;  Env      make-account---↓                         acc---↓
;;                          |                               |
;; -------------------------|-------------------------------|--------------------------------------------------------------------------------
;;                          |    ↑                          |             ↑
;;                          ↓    |                          |             |__________________________________________________________________
;;                        |x|x|--↑                          |           E1|balance:90
;;                         |                                |             |withdraw:
;;                         ↓                                |             |deposit:
;;               parameters: balance                        |             |dispatch:-----↓     ↑
;;               body: (define withdraw ...)                |             |______________|_____|_____________________________________________
;;                     (define deposit ...)                 |             |              |     |      ↑                      ↑
;;                     (define dispatch ...)                ↓             |            |x|x|---↑      |                      |
;;                     dispatch                           |x|x|-----------↑             ↓           E2|m:'withdraw         E3|amount:60
;;                                                         ↓                 parameters:m         <call to dispatch>     <call to withdraw>
;;                                               parameters:m                body: (cond ...)
;;                                               body: (cond ...)


;; Result of evaluating ((acc 'withdraw) 60)
;;
;; ----------------------------------------------------------------------------------------------
;;
;;  Global
;;  Env      make-account---↓                         acc---↓
;;                          |                               |
;; -------------------------|-------------------------------|------------------------------------
;;                          |    ↑                          |             ↑
;;                          ↓    |                          |             |______________________
;;                        |x|x|--↑                          |           E1|balance:30
;;                         |                                |             |withdraw:
;;                         ↓                                |             |deposit:
;;               parameters: balance                        |             |dispatch:-----↓     ↑
;;               body: (define withdraw ...)                |             |______________|_____|_
;;                     (define deposit ...)                 |             |              |     |
;;                     (define dispatch ...)                ↓             |            |x|x|---↑
;;                     dispatch                           |x|x|-----------↑             ↓
;;                                                         ↓                  parameters:m
;;                                               parameters:m                 body: (cond ...)
;;                                               body: (cond ...)


;; Result of evaluating (define acc2 (make-account 100))
;;
;; --------------------------------------------------------------------------------------------------------------------------------------------
;;
;;  Global
;;  Env      make-account---↓                         acc---↓                                      acc2---↓
;;                          |                               |                                             |
;; -------------------------|-------------------------------|---------------------------------------------|------------------------------------
;;                          |    ↑                          |             ↑                               |             ↑
;;                          ↓    |                          |             |______________________         |             |______________________
;;                        |x|x|--↑                          |           E1|balance:50                     |           E2|balance:100
;;                         |                                |             |withdraw:                      |             |withdraw:
;;                         ↓                                |             |deposit:                       |             |deposit:
;;               parameters: balance                        |             |dispatch:-----↓     ↑          |             |dispatch:-----↓     ↑
;;               body: (define withdraw ...)                |             |______________|_____|_         |             |______________|_____|_
;;                     (define deposit ...)                 |             |              |     |          |             |              |     |
;;                     (define dispatch ...)                ↓             |            |x|x|---↑          ↓             |            |x|x|---↑
;;                     dispatch                           |x|x|-----------↑             ↓               |x|x|-----------↑             ↓
;;                                                         ↓                  parameters:m               ↓                  parameters:m
;;                                               parameters:m                 body: (cond ...) parameters:m                 body: (cond ...)
;;                                               body: (cond ...)                              body: (cond ...)
;;
;;
;; The accounts acc and acc2 keep their balances in separate environments.
;; It can be supposed that the only thing acc and acc2 share is
;; the code of the procedure dispatch, which is a detail
;; of implementation.
