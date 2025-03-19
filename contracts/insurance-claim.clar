;; Insurance Claim Contract
;; Manages coverage for vision care

(define-data-var last-claim-id uint u0)

;; Map of insurance policies
(define-map insurance-policies
  { policy-id: (string-utf8 36) }
  {
    patient-id: (string-utf8 36),
    insurer-id: principal,
    coverage-amount: uint,
    deductible: uint,
    start-date: uint,
    end-date: uint,
    active: bool
  }
)

;; Map of insurance claims
(define-map insurance-claims
  { claim-id: uint }
  {
    policy-id: (string-utf8 36),
    glasses-id: (string-utf8 36),
    claim-amount: uint,
    claim-date: uint,
    approved: (optional bool),
    payment-tx-id: (optional (string-utf8 64))
  }
)

;; Map of registered insurers
(define-map insurers
  { address: principal }
  { registered: bool }
)

;; Get a policy by ID
(define-read-only (get-policy (policy-id (string-utf8 36)))
  (map-get? insurance-policies { policy-id: policy-id })
)

;; Get a claim by ID
(define-read-only (get-claim (claim-id uint))
  (map-get? insurance-claims { claim-id: claim-id })
)

;; Check if an address is a registered insurer
(define-read-only (is-insurer (address principal))
  (default-to false (get registered (map-get? insurers { address: address })))
)

;; Register an insurer
(define-public (register-insurer)
  (begin
    (map-set insurers
      { address: tx-sender }
      { registered: true }
    )
    (ok true)
  )
)

;; Create a new insurance policy
(define-public (create-policy
    (policy-id (string-utf8 36))
    (patient-id (string-utf8 36))
    (coverage-amount uint)
    (deductible uint)
    (start-date uint)
    (end-date uint)
  )
  (begin
    ;; Only registered insurers can create policies
    (asserts! (is-insurer tx-sender) (err u403))

    ;; Store the policy
    (map-set insurance-policies
      { policy-id: policy-id }
      {
        patient-id: patient-id,
        insurer-id: tx-sender,
        coverage-amount: coverage-amount,
        deductible: deductible,
        start-date: start-date,
        end-date: end-date,
        active: true
      }
    )

    (ok true)
  )
)

;; File an insurance claim
(define-public (file-claim
    (policy-id (string-utf8 36))
    (glasses-id (string-utf8 36))
    (claim-amount uint)
    (current-time uint)
  )
  (let
    (
      (policy (unwrap! (get-policy policy-id) (err u404)))
      (new-claim-id (+ (var-get last-claim-id) u1))
    )

    ;; Verify policy is active and not expired
    (asserts! (and
      (get active policy)
      (>= current-time (get start-date policy))
      (<= current-time (get end-date policy))
    ) (err u400))

    ;; Verify claim amount is within coverage
    (asserts! (<= claim-amount (get coverage-amount policy)) (err u400))

    ;; Update last claim ID
    (var-set last-claim-id new-claim-id)

    ;; Store the claim
    (map-set insurance-claims
      { claim-id: new-claim-id }
      {
        policy-id: policy-id,
        glasses-id: glasses-id,
        claim-amount: claim-amount,
        claim-date: current-time,
        approved: none,
        payment-tx-id: none
      }
    )

    (ok new-claim-id)
  )
)

;; Process an insurance claim
(define-public (process-claim (claim-id uint) (approved bool) (payment-tx-id (optional (string-utf8 64))))
  (let
    (
      (claim (unwrap! (get-claim claim-id) (err u404)))
      (policy (unwrap! (get-policy (get policy-id claim)) (err u404)))
    )

    ;; Only the insurer can process claims
    (asserts! (is-eq tx-sender (get insurer-id policy)) (err u403))

    ;; Update the claim
    (map-set insurance-claims
      { claim-id: claim-id }
      (merge claim {
        approved: (some approved),
        payment-tx-id: payment-tx-id
      })
    )

    (ok true)
  )
)

