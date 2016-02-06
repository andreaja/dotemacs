(add-to-list 'auto-mode-alist '("\.trig$" . plsql-mode))
(add-to-list 'auto-mode-alist '("\.pkg$" . plsql-mode))
(add-to-list 'auto-mode-alist '("\.proc$" . plsql-mode))
(add-to-list 'auto-mode-alist '("\.vws$" . sql-mode))
(add-to-list 'auto-mode-alist '("\.cpp$" . c++-mode))
(add-to-list 'auto-mode-alist '("\.pp$" . puppet-mode))
(add-to-list 'auto-mode-alist '("\.md$" . markdown-mode))
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
(add-hook 'slime-repl-mode-hook 'clojure-mode-font-lock-setup)
(add-hook 'slime-repl-mode-hook 'rainbow-delimiters-mode)
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)

(add-to-list 'auto-mode-alist '("\.ps1$" . powershell-mode))
(add-to-list 'auto-mode-alist '("\.xsd$" . xml-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

(add-hook 'prog-mode-hook 'ggtags-mode)
(add-hook 'prog-mode-hook 'subword-mode)
(add-hook 'xml-mode-hook 'ggtags-mode)

(global-hl-line-mode t)
(global-flycheck-mode t)
(global-hungry-delete-mode t)
(global-aggressive-indent-mode 1)
