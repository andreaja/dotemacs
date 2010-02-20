(add-to-list 'load-path "~/emacs/site-lisp")
(add-to-list 'load-path "~/emacs/site-lisp/emacs-rails")
(add-to-list 'load-path "~/emacs/site-lisp/php-mode/php-mode-src")
(add-to-list 'load-path "~/emacs/site-lisp/magit")
(add-to-list 'load-path "~/emacs/site-lisp/maxframe")
(add-to-list 'load-path "~/emacs/site-lisp/yasnippet")
(add-to-list 'load-path "~/emacs/site-lisp/distel/elisp")
(add-to-list 'load-path "~/emacs/site-lisp/scala")
(add-to-list 'load-path "~/emacs/site-lisp/groovy")
(add-to-list 'load-path "~/emacs/site-lisp/gist")
(add-to-list 'load-path "~/emacs/site-lisp/ioke")
(add-to-list 'load-path "~/emacs/site-lisp/cucumber")
(add-to-list 'load-path "~/emacs/site-lisp/elpa")
(add-to-list 'load-path "~/emacs/local")

(if (eq system-type 'darwin)
    (load "local-mac-mode"))

(load "andreaja-modules")
(load "andreaja-minor-modes")
(load "local-ido")
(load "local-rails")
(load "local-settings")
(load "local-tramp")
(load "ioke-mode")
(load "local-functions")
(load "local-key-bindings")
(load "feature-mode")

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load "package.el")
  (package-initialize))

(setq custom-file "~/emacs/settings.el")
(load custom-file 'noerror)

