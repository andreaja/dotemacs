(defvar emacs-root (expand-file-name "~"))

(add-to-list 'load-path "~/.emacs.d/init")

(load "loadenv")

;(add-to-list 'load-path "/opt/local/lib/erlang/lib/tools-2.6.1/emacs/")
;(require 'erlang-start)

(put 'upcase-region 'disabled nil)
