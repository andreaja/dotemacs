(set-scroll-bar-mode nil)
(tool-bar-mode 0)
(setq column-number-mode t)

(prefer-coding-system 'utf-8)

(show-paren-mode t)
(setq-default show-trailing-whitespace t)  
(set-face-background 'trailing-whitespace "red4")


(setq ruby-insert-encoding-magic-comment nil)


(setq backup-directory-alist '(("." . "~/.emacs-backups")))
(fset 'yes-or-no-p 'y-or-n-p) 
(setq inhibit-startup-message t)
(set-cursor-color 'red)
(setq-default truncate-lines nil)

(global-hl-line-mode t)

;(global-set-key "\M-/" 'hippie-expand)
