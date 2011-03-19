
(fset 'xml-mode 'nxml-mode)

(setq column-number-mode t)
(setq-default transient-mark-mode t) ;; only needed on mac (default otherwise?)

(mouse-avoidance-mode 'animate)

(setq-default indent-tabs-mode nil)

(global-hl-line-mode t)

(scroll-bar-mode nil)

(prefer-coding-system 'utf-8)

(show-paren-mode t)
(setq-default show-trailing-whitespace t)
(set-face-background 'trailing-whitespace "red4")

(when (fboundp 'winner-mode)
  (winner-mode 1))

(global-set-key [C-tab] 'other-window)

(setq ruby-insert-encoding-magic-comment nil)

(require 'snippet)

;; perl stuff

;(setq-default perl-tab-always-indent 1)
;(setq-default perl-indent-level 8)

