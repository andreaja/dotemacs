(setq custom-file "~/.emacs.d/init/settings.el")
(load custom-file 'noerror)

(load "~/.emacs.secrets" t)

(add-to-list 'load-path "~/.emacs.d/local")
(add-to-list 'load-path "~/.emacs.d/site-lisp/other")
;(add-to-list 'load-path "~/.emacs.d/site-lisp/io-mode")
(add-to-list 'load-path "~/.emacs.d/site-lisp/markdown-mode")
(add-to-list 'load-path "~/.emacs.d/site-lisp/hl-tags-mode")

(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)


(load "local-modes")
(load "local-settings")
(load "local-auto-modes")
(load "local-minor-modes")
(load "local-functions")
(load "local-hooks")
(load "local-key-bindings")
(load "local-edit")
(load "local-navigate")
(load "local-completion")
(load "local-theme")

(if (eq system-type 'darwin)
    (load "local-mac-mode"))

(load "local-desktop")


;; (autoload 'malabar-mode "cedet" "Cedet is required by malabar" t)
;; (require 'semantic)
;; (load "semantic/loaddefs.el")
;; (semantic-mode 1)
;; (require 'malabar-mode)
;; (add-hook 'malabar-mode-hook (lambda ()
;;                                (load "malabar-flycheck")))
;; (add-to-list 'auto-mode-alist '("\\.java\\'" . malabar-mode))
(my-keys-minor-mode 1)

(defun my-minibuffer-setup-hook ()
  (my-keys-minor-mode 0))

(add-hook 'minibuffer-setup-hook 'my-minibuffer-setup-hook)
