(add-to-list 'load-path "~/emacs/site-lisp")
(add-to-list 'load-path "~/emacs/site-lisp/emacs-rails")
(add-to-list 'load-path "~/emacs/site-lisp/php-mode/php-mode-src")
(add-to-list 'load-path "~/emacs/site-lisp/magit")
(add-to-list 'load-path "~/emacs/site-lisp/yasnippet")
(add-to-list 'load-path "~/emacs/site-lisp/distel/elisp")
(add-to-list 'load-path "~/emacs/site-lisp/scala")
(add-to-list 'load-path "~/emacs/site-lisp/groovy")
(add-to-list 'load-path "~/emacs/customs")

(load "customs")
(load "rails-on-emacs")
(load "snippets")
(load "scala")
(load "groovy")
(load "load-ido")
(load "php")
(load "snippets")

(setq exec-path (cons "/home/aja/var/scala/bin/" exec-path))

;; something wrong here, fix it later
;(labels ((add-path (p)
;	 (add-to-list 'load-path
;			(concat emacs-root p))))
;   (add-path "emacs/site-lisp/") ;; elisp stuff I find on the 'net
;)


