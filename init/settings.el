(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(create-lockfiles nil)
 '(flycheck-disabled-checkers '(emacs-lisp-checkdoc))
 '(flycheck-tidyrc "/Users/andreaja/.tidyrc")
 '(fringe-mode 0 nil (fringe))
 '(hippie-expand-try-functions-list
   '(try-expand-dabbrev try-expand-dabbrev-visible
                        try-expand-dabbrev-all-buffers
                        try-expand-dabbrev-from-kill
                        try-complete-file-name
                        try-complete-file-name-partially
                        try-expand-list try-expand-all-abbrevs
                        try-complete-lisp-symbol-partially
                        try-complete-lisp-symbol))
 '(indent-tabs-mode nil)
 '(insert-shebang-file-types 'nil)
 '(js-indent-level 2)
 '(js2-skip-preprocessor-directives t)
 '(load-prefer-newer t)
 '(magit-save-repository-buffers 'dontask)
 '(markdown-command "/usr/local/bin/multimarkdown")
 '(ns-auto-hide-menu-bar nil)
 '(org-M-RET-may-split-line '((table)))
 '(org-agenda-files "~/.org.file.list")
 '(org-archive-location "%s_archive::* Archive")
 '(org-catch-invisible-edits 'smart)
 '(org-fold-catch-invisible-edits 'smart)
 '(org-log-into-drawer "STATE")
 '(org-reverse-note-order t)
 '(package-selected-packages
   '(ace-window aggressive-indent applescript-mode blacken
                browse-kill-ring diminish elnode expand-region f
                flycheck ggtags gh go-mode gradle-mode htmlize
                hungry-delete idomenu iedit insert-shebang
                js2-refactor json-reformat lorem-ipsum lua-mode magit
                markdown-mode mermaid-ts-mode mustache-mode
                org-bullets paredit prettier-js projectile
                rainbow-delimiters rainbow-mode restclient rust-mode s
                slime smartscan smex smooth-scrolling solarized-theme
                super-save terraform-mode urlenc visual-fill-column
                web-mode))
 '(require-final-newline 'visit-save)
 '(safe-local-variable-values '((js2-basic-offset . 2) (js-indent-level . 2)))
 '(show-paren-delay 0)
 '(super-save-triggers
   '(switch-to-buffer other-window windmove-up windmove-down
                      windmove-left windmove-right ace-window))
 '(vc-follow-symlinks nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-document-title ((t (:inherit default :weight bold :font "Lucida Grande" :foreground "#ec423a" :height 2.0 :underline nil))))
 '(org-level-1 ((t (:inherit default :weight bold :font "Lucida Grande" :foreground "#ec423a" :height 1.75))))
 '(org-level-2 ((t (:inherit default :weight bold :font "Lucida Grande" :foreground "#db5823" :height 1.5))))
 '(org-level-3 ((t (:inherit default :weight bold :font "Lucida Grande" :foreground "#c49619" :height 1.25))))
 '(org-level-4 ((t (:inherit default :weight bold :font "Lucida Grande" :foreground "#93a61a" :height 1.1))))
 '(org-level-5 ((t (:inherit default :weight bold :font "Lucida Grande" :foreground "#3cafa5"))))
 '(org-level-6 ((t (:inherit default :weight bold :font "Lucida Grande" :foreground "#3c98e0"))))
 '(org-level-7 ((t (:inherit default :weight bold :font "Lucida Grande" :foreground "#7a7ed2"))))
 '(org-level-8 ((t (:inherit default :weight bold :font "Lucida Grande" :foreground "#e2468f"))))
 '(rainbow-delimiters-depth-1-face ((t (:foreground "Purple"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "#8F0427"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "#C74E6C"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "#B58B28"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "#B5A028"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "#D1C686"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "Yellow"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "Magenta"))))
 '(rainbow-delimiters-depth-9-face ((t (:foreground "Green")))))
