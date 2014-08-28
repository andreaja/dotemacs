(tool-bar-mode 0)

(setq org-todo-keywords
      '((sequence "TODO(t)" "WAIT(w/!)" "|" "DONE(d!)" "DLGT(l!)" "CNCL(c!)")))

;; Flat mode-line
(set-face-attribute 'mode-line nil :box nil)
(set-face-attribute 'mode-line-inactive nil :box nil)

;;; Re-enable this once familiar with org-todo (rather than S-arrows)
;; (add-to-list 'org-drawers
;;              (setq org-log-into-drawer "STATE"))

(setq org-return-follows-link t)

(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

(setq locate-command "mdfind")

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

(setq scroll-preserve-screen-position t)


;; https://gist.github.com/robtillotson/5d162f9674ad9c207d44
;; Quick emacs version of syntactic line compression, found on reddit
(make-face 'mundane-line-face)
(set-face-attribute 'mundane-line-face nil :height 0.5)

(defun add-mundane-line-font-lock ()
  (setq font-lock-multiline t)
  (font-lock-add-keywords nil '(("^[ \t;`']*\n" 0 'mundane-line-face prepend))))

(add-hook 'prog-mode-hook 'add-mundane-line-font-lock)
