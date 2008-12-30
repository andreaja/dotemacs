(defvar emacs-root "/home/aja/")

(add-to-list 'load-path "~/emacs")
(load "loadenv")


(add-to-list 'load-path "/opt/local/lib/erlang/lib/tools-2.6.1/emacs/")
(require 'erlang-start)

;; disable toolbar (should be mac only, linux uses .Xresources)
(tool-bar-mode 0)

;; giss an eshell dear
(eshell)
