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
(add-to-list 'load-path "~/emacs/local")

(load "local-find-recursive")
(load "local-functions")
(load "local-gist")
(load "local-groovy")
(load "local-ido")
(load "local-maxframe")
(load "local-minor-modes")
(load "local-php")
(load "local-rails")
(load "local-scala")
(load "local-settings")
(load "local-snippets")
(load "local-tramp")


(setq custom-file "~/emacs/settings.el")
(load custom-file 'noerror)


;; something wrong here, fix it later
;(labels ((add-path (p)
;	 (add-to-list 'load-path
;			(concat emacs-root p))))
;   (add-path "emacs/site-lisp/") ;; elisp stuff I find on the 'net
;)


