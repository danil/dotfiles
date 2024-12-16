(setq mew-name "Danil Kutkevich")
(setq mew-user "danil") ;from name@domain
(setq mew-mail-domain "domain")

(setq mew-smtp-user "danil@kutkevich.org")
(setq mew-smtp-server "smtp.gmail.com")
(setq mew-smtp-auth-list '("LOGIN"))   ; "CRAM-MD5", "PLAIN", and "LOGIN" can be used

;; If you want to use IMAP to receive e-mail messages, the followings
;; are necessary.
(setq mew-proto "%")
;; (setq mew-imap-server "your IMAP server")    ;; if not localhost
(setq mew-imap-user "danil")  ;; (user-login-name)

;; some customization
(setq mew-use-unread-mark t)
(setq mew-summary-form '(type " " (5 date) " " (5 time) "   " (30 from) " " t (0 subj)))
(setq mew-summary-form-extract-rule '(address))
;; make mew to show date in "dd/mm" format in summary instead of "mm/dd"
(defun mew-summary-form-date ()
  "A function to return a date, DD/MM."
  (let ((s (MEW-DATE)))
    (when (or (string= s "")
              (not (string-match mew-time-rfc-regex s)))
      (setq s (mew-time-ctz-to-rfc
               (mew-file-get-time (mew-expand-msg (MEW-FLD) (MEW-NUM))))))
    (if (string-match mew-time-rfc-regex s)
        (format "%02d/%02d"
                (mew-time-rfc-day)
                (mew-time-mon-str-to-int (mew-time-rfc-mon)))
      "")))
