;;; midje-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "clojure-jump-to-file" "clojure-jump-to-file.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from clojure-jump-to-file.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "clojure-jump-to-file" '("midje-" "clojure-midje-")))

;;;***

;;;### (autoloads nil "midje-mode" "midje-mode.el" (0 0 0 0))
;;; Generated autoloads from midje-mode.el

(autoload 'midje-mode "midje-mode" "\
A minor mode for running Midje tests when using cider.

\\{midje-mode-map}

\(fn &optional ARG)" t nil)

(defun midje-mode-maybe-enable nil "\
Enable midje-mode if the current buffer contains a \"midje.\" string." (let ((regexp "midje\\.")) (save-excursion (when (or (re-search-backward regexp nil t) (re-search-forward regexp nil t)) (midje-mode t)))))

(add-hook 'clojure-mode-hook 'midje-mode-maybe-enable)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "midje-mode" '("midje-" "nrepl-check-fact-handler" "last-checked-midje-fact")))

;;;***

;;;### (autoloads nil "midje-mode-praise" "midje-mode-praise.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from midje-mode-praise.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "midje-mode-praise" '("midje-")))

;;;***

;;;### (autoloads nil nil ("midje-mode-pkg.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; midje-mode-autoloads.el ends here
