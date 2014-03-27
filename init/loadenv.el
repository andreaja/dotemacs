(setq custom-file "~/.emacs.d/init/settings.el")
(load custom-file 'noerror)

(add-to-list 'load-path "~/.emacs.d/local")
(add-to-list 'load-path "~/.emacs.d/site-lisp/other")
;(add-to-list 'load-path "~/.emacs.d/site-lisp/io-mode")
(add-to-list 'load-path "~/.emacs.d/site-lisp/markdown-mode")

(require 'package)
(package-initialize)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)


(load "local-modes")
(load "local-settings")
(load "local-auto-modes")
(load "local-minor-modes")
(load "local-ido")
(load "local-functions")
(load "local-hooks")
(load "local-key-bindings")

(if (eq system-type 'darwin)
    (load "local-mac-mode"))

