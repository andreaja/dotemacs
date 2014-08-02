;;; visible-mark-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "visible-mark" "visible-mark.el" (21468 60750
;;;;;;  0 0))
;;; Generated autoloads from visible-mark.el

(autoload 'visible-mark-mode "visible-mark" "\
A mode to make the mark visible.

\(fn &optional ARG)" t nil)

(defvar global-visible-mark-mode nil "\
Non-nil if Global-Visible-Mark mode is enabled.
See the command `global-visible-mark-mode' for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `global-visible-mark-mode'.")

(custom-autoload 'global-visible-mark-mode "visible-mark" nil)

(autoload 'global-visible-mark-mode "visible-mark" "\
Toggle Visible-Mark mode in all buffers.
With prefix ARG, enable Global-Visible-Mark mode if ARG is positive;
otherwise, disable it.  If called from Lisp, enable the mode if
ARG is omitted or nil.

Visible-Mark mode is enabled in all buffers where
`visible-mark-mode-maybe' would do it.
See `visible-mark-mode' for more information on Visible-Mark mode.

\(fn &optional ARG)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; visible-mark-autoloads.el ends here
