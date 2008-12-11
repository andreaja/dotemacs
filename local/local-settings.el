(setq backup-directory-alist '(("." . "~/.emacs-backups")))
(fset 'yes-or-no-p 'y-or-n-p) 
(setq inhibit-startup-message t)
(setq-default transient-mark-mode t) ;; only needed on mac (default otherwise?)

