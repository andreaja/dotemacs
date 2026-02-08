(setq ruby-insert-encoding-magic-comment nil)

(setq backup-directory-alist '(("." . "~/.emacs-backups")))
(setq auto-save-default nil)

(setq-default truncate-lines nil)

(require 'hl-tags-mode)

(add-hook 'org-mode-hook 'visual-line-mode)

;; Configure visual-fill-column for org-mode
(use-package visual-fill-column
  :config
  (setq-default visual-fill-column-width 80)
  (setq-default visual-fill-column-center-text nil)
  :hook (org-mode . visual-fill-column-mode))
