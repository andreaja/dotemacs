;; find-file-recursively, useful for projects
(require 'find-recursive)

;; Create gists from buffers/files, open gists as buffers.
(require 'gist)

;; from .emacs in site-lisp/groovy. Remember to keep this updated...
;;; use groovy-mode when file ends in .groovy or has #!/bin/groovy at start
(autoload 'groovy-mode "groovy-mode" "Groovy editing mode." t)
(add-to-list 'auto-mode-alist '("\.groovy$" . groovy-mode))
(add-to-list 'interpreter-mode-alist '("groovy" . groovy-mode))

;; PHP
(require 'php-mode)

;; Scala
(require 'scala-mode-auto)
(setq exec-path (cons "/home/aja/var/scala/bin/" exec-path))

;; YASnippet
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/site-lisp/yasnippet/snippets")
(add-to-list 'yas/extra-mode-hooks 'erlang-mode-hook)