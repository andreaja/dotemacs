(setq custom-file "~/.emacs.d/settings.el")
(load custom-file 'noerror)

(add-to-list 'load-path "~/.emacs.d/local")
(add-to-list 'load-path "~/.emacs.d/site-lisp/yasnippet")
(add-to-list 'load-path "~/.emacs.d/site-lisp/other")
;(add-to-list 'load-path "~/.emacs.d/site-lisp/io-mode")
(add-to-list 'load-path "~/.emacs.d/site-lisp/markdown-mode")
(add-to-list 'load-path "~/.emacs.d/site-lisp/puppet")

(require 'puppet-mode)
(require 'markdown-mode)

(load "local-settings")
(load "local-auto-modes")
(load "local-minor-modes")
(load "local-modes")
(load "local-ido")
(load "local-functions")
(load "local-hooks")
(load "local-key-bindings")

(if (eq system-type 'darwin)
    (load "local-mac-mode"))

