
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(defvar emacs-root (expand-file-name "~"))

(add-to-list 'load-path "~/.emacs.d/init")

(load "loadenv")

;(add-to-list 'load-path "/opt/local/lib/erlang/lib/tools-2.6.1/emacs/")
;(require 'erlang-start)

(put 'upcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)
