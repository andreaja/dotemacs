(tool-bar-mode 0)
(setq org-todo-keywords
      '((sequence "TODO" "WAIT" "|" "DONE" "DLGT" "CNCL")))

(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

;; http://www.masteringemacs.org/articles/2011/10/02/improving-performance-emacs-display-engine/
;; (makes keyboard scrolling in org-mode faster?)
(setq redisplay-dont-pause 1)

(setq powershell-indent 4)

(setq powershell-continuation-indent 2)

(yas-global-mode 1)

(setq ns-use-srgb-colorspace t)

(setq create-lockfiles nil)
