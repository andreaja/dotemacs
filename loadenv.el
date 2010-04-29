(add-to-list 'load-path "~/.emacs.d/site-lisp")
;; (add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-rails")
(add-to-list 'load-path "~/.emacs.d/site-lisp/php-mode/php-mode-src")
(add-to-list 'load-path "~/.emacs.d/site-lisp/magit")
(add-to-list 'load-path "~/.emacs.d/site-lisp/maxframe")
(add-to-list 'load-path "~/.emacs.d/site-lisp/yasnippet")
(add-to-list 'load-path "~/.emacs.d/site-lisp/distel/elisp")
(add-to-list 'load-path "~/.emacs.d/site-lisp/scala")
(add-to-list 'load-path "~/.emacs.d/site-lisp/groovy")
(add-to-list 'load-path "~/.emacs.d/site-lisp/gist")
(add-to-list 'load-path "~/.emacs.d/site-lisp/ioke")
(add-to-list 'load-path "~/.emacs.d/site-lisp/cucumber")
(add-to-list 'load-path "~/.emacs.d/elpa")
(add-to-list 'load-path "~/.emacs.d/local")

(if (eq system-type 'darwin)
    (load "local-mac-mode"))

(load "andreaja-modules")
(load "andreaja-minor-modes")
(load "local-ido")
;; (load "local-rails")
(load "local-settings")
(load "local-tramp")
(load "visual-basic-mode")
(load "ioke-mode")
(load "puppet-mode")
(load "sql-indent")
(eval-after-load "sql"
  (load-library "sql-indent"))
(load "plsql")

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

(setq custom-file "~/.emacs.d/settings.el")
(load custom-file 'noerror)

