(tool-bar-mode 0)

(setq org-todo-keywords
      '((sequence "TODO(t)" "WAIT(w/!)" "|" "DONE(d!)" "DLGT(l!)" "CNCL(c!)")))

;; Flat mode-line
(set-face-attribute 'mode-line nil :box nil)
(set-face-attribute 'mode-line-inactive nil :box nil)

(setq org-return-follows-link t)

(setq use-dialog-box nil)

(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

(setq locate-command "mdfind")

;; http://www.masteringemacs.org/articles/2011/10/02/improving-performance-emacs-display-engine/
;; (makes keyboard scrolling in org-mode faster?)
(setq redisplay-dont-pause 1)

(setq powershell-indent 4)

(setq powershell-continuation-indent 2)

(yas-global-mode 1)

(setq ns-use-srgb-colorspace t)

;; Correctly set up PATH from bash variables
(let ((path (shell-command-to-string ". ~/.bashrc; echo -n $PATH")))
  (setenv "PATH" path)
  (setq exec-path
        (append
         (split-string-and-unquote path ":")
         exec-path)))

(setq scroll-preserve-screen-position t)


(js2r-add-keybindings-with-prefix "C-c C-m")


;; https://gist.github.com/robtillotson/5d162f9674ad9c207d44
;; Quick emacs version of syntactic line compression, found on reddit
(make-face 'mundane-line-face)
(set-face-attribute 'mundane-line-face nil :height 0.5)

(defun add-mundane-line-font-lock ()
  (setq font-lock-multiline t)
  (font-lock-add-keywords nil '(("^[ \t;`']*\n" 0 'mundane-line-face prepend))))

(add-hook 'prog-mode-hook 'add-mundane-line-font-lock)

(setq magit-last-seen-setup-instructions "1.4.0")

(setq frame-title-format '("%e" mode-line-front-space mode-line-mule-info mode-line-client mode-line-modified mode-line-remote mode-line-frame-identification mode-line-buffer-identification "   " mode-line-position
                           (vc-mode vc-mode)
                           "  " mode-line-modes mode-line-misc-info mode-line-end-spaces))
(set-face-attribute 'mode-line nil
                    :background "black"
                    :height 0.1)
(set-face-attribute 'mode-line-inactive nil
                    :background "dark grey")


;;; From http://doc.norang.ca/org-mode.html
(defun bh/is-subproject-p ()
  "Any task which is a subtask of another project"
  (let ((is-subproject)
        (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
    (save-excursion
      (while (and (not is-subproject) (org-up-heading-safe))
        (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
          (setq is-subproject t))))
    (and is-a-task is-subproject)))

(defun aja/is-not-subproject-p ()
  "Inverts bh/is-subproject-p"
  (not (bh/is-subproject-p)))

;; http://pages.sachachua.com/.emacs.d/Sacha.html
(defun aja/org-agenda-skip-scheduled-and-non-tasks ()
  (org-agenda-skip-entry-if 'scheduled 'aja/is-not-subproject-p))

(setq org-agenda-custom-commands
      `(("w" "Waiting for" tags-todo "/!WAIT"
         ((org-agenda-overriding-header "Waiting for response")
          (org-agenda-skip-function 'bh/skip-non-projects)
          (org-tags-match-list-sublevels 'indented)
          (org-agenda-sorting-strategy
           '(category-keep))))
        (" " "Daily agenda with TODO"
         ((agenda "" ((org-agenda-ndays 1)
                      (org-agenda-show-log t)))
          (tags-todo "-CATEGORY=\"Inbox\"/!TODO"
                     ((org-agenda-overriding-header "Projects")
                      (org-agenda-skip-function 'aja/org-agenda-skip-scheduled-and-non-tasks)
                      (org-tags-match-list-sublevels 'indented)
                      (org-agenda-sorting-strategy
                       '(category-keep))))
          ))
        ("p" "Other daily agenda with TODO"
         ((agenda "" ((org-agenda-ndays 1)
                      (org-agenda-show-log t)))
          (tags-todo "-CATEGORY=\"Inbox\"/!TODO"
                     ((org-agenda-overriding-header "Projects")
                      (org-agenda-skip-function 'aja/org-agenda-skip-scheduled-and-non-tasks)
                      (org-tags-match-list-sublevels 'indented)
                      (org-agenda-sorting-strategy
                       '(category-keep)))))
         ((org-agenda-files "~/.org.file.list.p")))
        ("f" "Fortnight schedule"
         ((agenda "" ((org-agenda-ndays 14)
                      (org-agenda-start-day "-3d")
                      (org-agenda-start-on-weekday nil)))))
        ))

(defun hacky-template-issue-workaround ()
  (format "**** %s" (current-kill 0 t)))


(setq org-capture-templates
      '(("t" "New todo item" entry
         (file+headline (expand-file-name (car (org-agenda-files))) "Incoming")
         "** TODO %?\n   %U")
        ("l" "New link for slack" entry
         (file+headline (expand-file-name (car (org-agenda-files))) "Share a link on Slack")
         (function hacky-template-issue-workaround) :prepend t :immediate-finish 1)))

;; http://orgmode.org/manual/Deadlines-and-scheduling.html
(setq org-agenda-skip-scheduled-if-done 1)
(setq org-agenda-skip-deadline-if-done 1)
(setq org-agenda-window-setup 'current-window)
(setq org-ellipsis "⤵")

(setq-default mode-line-format "")

(add-hook 'org-load-hook
          (lambda ()
            (add-to-list 'org-drawers
                         (setq org-log-into-drawer "STATE"))
            (org-add-link-type
             "docx" 'follow-doc-link)
            (org-add-link-type
             "pdf" 'follow-doc-link)
            (require 'org-depend)
            (defun follow-doc-link (tag)
              (shell-command (format "open \"%s\"" tag)))))


