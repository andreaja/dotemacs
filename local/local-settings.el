(tool-bar-mode 0)

(setq org-todo-keywords
      '((sequence "TODO(t)" "WAIT(w/!)" "|" "DONE(d!)" "DLGT(l!)" "CNCL(c!)")))


;;; Re-enable this once familiar with org-todo (rather than S-arrows)
;; (add-to-list 'org-drawers
;;              (setq org-log-into-drawer "STATE"))

(setq org-return-follows-link t)


(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

;; http://www.masteringemacs.org/articles/2011/10/02/improving-performance-emacs-display-engine/
;; (makes keyboard scrolling in org-mode faster?)
(setq redisplay-dont-pause 1)

(setq powershell-indent 4)

(setq powershell-continuation-indent 2)

(yas-global-mode 1)

(setq ns-use-srgb-colorspace t)

;; Correctly set up PATH from bash variables
(let ((path (shell-command-to-string ". ~/.bashrc; echo -n $PATH")))
  (setenv "PATH" path)
  (setq exec-path 
        (append
         (split-string-and-unquote path ":")
         exec-path)))
