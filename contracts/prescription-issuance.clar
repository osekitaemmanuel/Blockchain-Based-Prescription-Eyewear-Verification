;; Prescription Issuance Contract
;; Records optometrist-issued vision corrections

(define-data-var last-prescription-id uint u0)

;; Map of prescriptions by ID
(define-map prescriptions
  { prescription-id: uint }
  {
    patient-id: (string-utf8 36),
    optometrist-id: principal,
    sphere-right: int,
    cylinder-right: int,
    axis-right: uint,
    sphere-left: int,
    cylinder-left: int,
    axis-left: uint,
    add-power: int,
    pd: uint,
    issue-date: uint,
    expiry-date: uint
  }
)

;; Map of optometrists
(define-map optometrists
  { address: principal }
  { licensed: bool }
)

;; Get a prescription by ID
(define-read-only (get-prescription (prescription-id uint))
  (map-get? prescriptions { prescription-id: prescription-id })
)

;; Check if an address is a licensed optometrist
(define-read-only (is-optometrist (address principal))
  (default-to false (get licensed (map-get? optometrists { address: address })))
)

;; Register an optometrist
(define-public (register-optometrist)
  (begin
    (map-set optometrists
      { address: tx-sender }
      { licensed: true }
    )
    (ok true)
  )
)

;; Issue a new prescription
(define-public (issue-prescription
    (patient-id (string-utf8 36))
    (sphere-right int)
    (cylinder-right int)
    (axis-right uint)
    (sphere-left int)
    (cylinder-left int)
    (axis-left uint)
    (add-power int)
    (pd uint)
    (issue-date uint)
    (expiry-date uint)
  )
  (let
    (
      (new-prescription-id (+ (var-get last-prescription-id) u1))
    )

    ;; Only licensed optometrists can issue prescriptions
    (asserts! (is-optometrist tx-sender) (err u403))

    ;; Update last prescription ID
    (var-set last-prescription-id new-prescription-id)

    ;; Store the prescription
    (map-set prescriptions
      { prescription-id: new-prescription-id }
      {
        patient-id: patient-id,
        optometrist-id: tx-sender,
        sphere-right: sphere-right,
        cylinder-right: cylinder-right,
        axis-right: axis-right,
        sphere-left: sphere-left,
        cylinder-left: cylinder-left,
        axis-left: axis-left,
        add-power: add-power,
        pd: pd,
        issue-date: issue-date,
        expiry-date: expiry-date
      }
    )

    (ok new-prescription-id)
  )
)

;; Check if a prescription is valid and not expired
(define-read-only (is-prescription-valid (prescription-id uint) (current-time uint))
  (let
    (
      (prescription (get-prescription prescription-id))
    )
    (and
      (is-some prescription)
      (< current-time (get expiry-date (unwrap-panic prescription)))
    )
  )
)
