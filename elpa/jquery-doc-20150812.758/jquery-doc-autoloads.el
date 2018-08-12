;;; jquery-doc-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "jquery-doc" "jquery-doc.el" (0 0 0 0))
;;; Generated autoloads from jquery-doc.el

(autoload 'jquery-doc-ac-prefix "jquery-doc" "\


\(fn)" nil nil)

(defvar ac-source-jquery '((candidates . jquery-doc-methods) (symbol . "f") (document . jquery-doc-documentation) (prefix . jquery-doc-ac-prefix) (cache)))

(autoload 'company-jquery "jquery-doc" "\
`company-mode' completion back-end using `jquery-doc'.

\(fn COMMAND &optional ARG &rest IGNORE)" t nil)

(autoload 'jquery-doc-setup "jquery-doc" "\


\(fn)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "jquery-doc" '("company-jquery-modes" "jquery-doc")))

;;;***

;;;### (autoloads nil nil ("jquery-doc-data.el" "jquery-doc-pkg.el")
;;;;;;  (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; jquery-doc-autoloads.el ends here
