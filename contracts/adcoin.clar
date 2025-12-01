;; adcoin: a simple fungible token example

(define-constant ERR-INSUFFICIENT-BALANCE (err u100))

(define-data-var total-supply uint u0)

(define-map balances
  { owner: principal }
  { amount: uint })

;; === Helpers ===

(define-read-only (get-balance (owner principal))
  (default-to u0 (get amount (map-get? balances { owner: owner }))))

(define-private (set-balance (owner principal) (amount uint))
  (if (is-eq amount u0)
      (map-delete balances { owner: owner })
      (map-set balances { owner: owner } { amount: amount })))

;; === Public read-only functions ===

(define-read-only (get-total-supply)
  (ok (var-get total-supply)))

(define-read-only (get-balance-of (who principal))
  (ok (get-balance who)))

;; === Public token functions ===

(define-public (mint (recipient principal) (amount uint))
  (let
    (
      (current (get-balance recipient))
      (new-balance (+ current amount))
      (new-supply (+ (var-get total-supply) amount))
    )
    (begin
      (var-set total-supply new-supply)
      (set-balance recipient new-balance)
      (ok true))))

(define-public (transfer (amount uint) (recipient principal))
  (let
    (
      (sender tx-sender)
      (sender-balance (get-balance sender))
    )
    (if (< sender-balance amount)
        ERR-INSUFFICIENT-BALANCE
        (let
          (
            (new-sender (- sender-balance amount))
            (recipient-balance (get-balance recipient))
            (new-recipient (+ recipient-balance amount))
          )
          (begin
            (set-balance sender new-sender)
            (set-balance recipient new-recipient)
            (ok true))))))
