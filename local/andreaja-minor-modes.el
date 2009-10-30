
(fset 'xml-mode 'nxml-mode)

(setq column-number-mode t)
(setq-default transient-mark-mode t) ;; only needed on mac (default otherwise?)

(mouse-avoidance-mode 'animate)

(setq-default indent-tabs-mode nil)

(global-hl-line-mode t)

(scroll-bar-mode nil)

(show-paren-mode t)

;; perl stuff

(setq-default perl-tab-always-indent 1)
(setq-default perl-indent-level 8)
(add-to-list 'auto-mode-alist '("\.t$" . perl-mode)) ;; perl test files
