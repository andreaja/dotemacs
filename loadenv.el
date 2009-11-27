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
(add-to-list 'load-path "~/emacs/local")

(load "andreaja-modules")
(load "andreaja-minor-modes")
(load "local-ido")
(load "local-rails")
(load "local-settings")
(load "local-tramp")
(load "visual-basic-mode")
(load "ioke-mode")
(load "puppet-mode")

(load "local-functions")
(load "local-key-bindings")
(load "feature-mode")

(setq custom-file "~/emacs/settings.el")
(load custom-file 'noerror)


;; something wrong here, fix it later
;(labels ((add-path (p)
;	 (add-to-list 'load-path
;			(concat emacs-root p))))
;   (add-path "emacs/site-lisp/") ;; elisp stuff I find on the 'net
;)


