;; no-littering redirects package state into var/, but it cannot reach the
;; native-comp cache: `startup-redirect-eln-cache' has to run before anything
;; is compiled, which is earlier than package.el and so earlier than
;; no-littering can be loaded.  Keep this in sync with
;; `no-littering-var-directory'.

(when (and (fboundp 'startup-redirect-eln-cache)
           (native-comp-available-p))
  (startup-redirect-eln-cache
   (convert-standard-filename
    (expand-file-name "var/eln-cache/" user-emacs-directory))))
