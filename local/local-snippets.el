(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/emacs/site-lisp/yasnippet/snippets")
(add-to-list 'yas/extra-mode-hooks 'erlang-mode-hook)