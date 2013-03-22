;;; powershell-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (powershell) "powershell" "powershell.el" (20618
;;;;;;  38052))
;;; Generated autoloads from powershell.el

(autoload 'powershell "powershell" "\
Run an inferior PowerShell, with I/O through tne named BUFFER (which defaults to `*PowerShell*').

Interactively, a prefix arg means to prompt for BUFFER.

If BUFFER exists but the shell process is not running, it makes a new shell.

If BUFFER exists and the shell process is running, just switch to BUFFER.

If PROMPT-STRING is non-nil, sets the prompt to the given value.

See the help for `shell' for more details.  (Type
\\[describe-mode] in the shell buffer for a list of commands.)

\(fn &optional BUFFER PROMPT-STRING)" t nil)

;;;***

;;;### (autoloads nil nil ("powershell-pkg.el") (20618 38052 776116))

;;;***

(provide 'powershell-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; powershell-autoloads.el ends here
