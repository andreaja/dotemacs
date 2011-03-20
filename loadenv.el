(setq custom-file "~/.emacs.d/settings.el")
(load custom-file 'noerror)

(add-to-list 'load-path "~/.emacs.d/local")
(add-to-list 'load-path "~/.emacs.d/site-lisp/yasnippet")
(add-to-list 'load-path "~/.emacs.d/site-lisp/other")

(load "plsql")
(load "rainbow-mode")
(load "js2-mode")
(load "local-settings")
(load "local-auto-modes")
(load "local-minor-modes")
(load "local-modes")
(load "local-ido")

(if (eq system-type 'darwin)
    (load "local-mac-mode"))

