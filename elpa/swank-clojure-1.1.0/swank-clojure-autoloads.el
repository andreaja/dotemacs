;;; swank-clojure-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (swank-clojure-project swank-clojure-cmd swank-clojure-slime-mode-hook
;;;;;;  swank-clojure-init) "swank-clojure" "swank-clojure.el" (19328
;;;;;;  30262))
;;; Generated autoloads from swank-clojure.el

(autoload (quote swank-clojure-init) "swank-clojure" "\
Not documented

\(fn FILE ENCODING)" nil nil)

(autoload (quote swank-clojure-slime-mode-hook) "swank-clojure" "\
Not documented

\(fn)" nil nil)

(autoload (quote swank-clojure-cmd) "swank-clojure" "\
Create the command to start clojure according to current settings.

\(fn)" nil nil)

(defadvice slime-read-interactive-args (before add-clojure) (require (quote assoc)) (aput (quote slime-lisp-implementations) (quote clojure) (list (swank-clojure-cmd) :init (quote swank-clojure-init))))

(autoload (quote swank-clojure-project) "swank-clojure" "\
Setup classpath for a clojure project and starts a new SLIME session.
  Kills existing SLIME session, if any.

\(fn PATH)" t nil)

;;;***

;;;### (autoloads nil nil ("swank-clojure-pkg.el") (19328 30262 753365))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; swank-clojure-autoloads.el ends here
