(setq ruby-insert-encoding-magic-comment nil)

(setq backup-directory-alist '(("." . "~/.emacs-backups")))
(setq auto-save-default nil)

(setq-default truncate-lines nil)

(require 'hl-tags-mode)

(add-hook 'org-mode-hook 'visual-line-mode)
(add-hook 'org-mode-hook 'variable-pitch-mode)

;; Disable visual-line-mode and visual-fill-column in org tables
(defun aj/org-table-visual-line-manager ()
  "Disable visual-line-mode and visual-fill-column-mode when inside an org table."
  (when (eq major-mode 'org-mode)
    (if (org-at-table-p)
        (progn
          (when visual-line-mode
            (visual-line-mode -1))
          (when (bound-and-true-p visual-fill-column-mode)
            (visual-fill-column-mode -1)))
      (progn
        (unless visual-line-mode
          (visual-line-mode 1))
        (unless (bound-and-true-p visual-fill-column-mode)
          (visual-fill-column-mode 1))))))

(add-hook 'org-mode-hook
          (lambda ()
            (add-hook 'post-command-hook #'aj/org-table-visual-line-manager nil t)))

;; Configure visual-fill-column for org-mode
(use-package visual-fill-column
  :config
  (setq-default visual-fill-column-width 80)
  (setq-default visual-fill-column-center-text nil)
  (setq-default visual-fill-column-adjust-for-text-scale nil)

  (advice-add 'text-scale-adjust :after #'visual-fill-column-adjust)

  :hook (org-mode . visual-fill-column-mode))
