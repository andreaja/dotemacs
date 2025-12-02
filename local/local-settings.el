(setq org-todo-keywords
      '((sequence "TODO(t)" "WAIT(w/!)" "|" "DONE(d!)" "DLGT(l!)" "CNCL(c!)")))

(setq org-return-follows-link t)

(setq use-dialog-box nil)

(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

(setq powershell-indent 4)

(setq powershell-continuation-indent 2)

(setq auto-revert-verbose nil)

(set-default 'imenu-auto-rescan t)

(setq sentence-end-double-space nil)

(setq smooth-scroll-margin 6)

;; Correctly set up PATH from bash variables
(let ((path (shell-command-to-string ". ~/.bashrc; echo -n $PATH")))
  (setenv "PATH" path)
  (setq exec-path
        (append
         (split-string-and-unquote path ":")
         exec-path)))

(setq scroll-preserve-screen-position t)

(js2r-add-keybindings-with-prefix "C-c C-m")
(setq-default js2-global-externs '("module" "require" "process" "console"))

(add-hook 'go-mode-hook (lambda () (setq tab-width 4)))

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

;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
              (append flycheck-disabled-checkers
                      '(javascript-jshint)))
;; use eslint with web-mode for jsx files
(flycheck-add-mode 'javascript-eslint 'web-mode)
(flycheck-add-mode 'javascript-eslint 'js2-mode)


(defun my-org-agenda-format-item (orig-fun &rest args)
  (let* ((txt (apply orig-fun args))
         (loc (org-entry-get (point) "LOCATION")))
    (if loc
        (format "%s  [%s]" txt loc)
      txt)))

(advice-add 'org-agenda-format-item :around #'my-org-agenda-format-item)

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
         ((agenda "" ((org-agenda-span 1)
                      (org-agenda-show-log t)))
          (tags-todo "-CATEGORY=\"Inbox\"/!TODO"
                     ((org-agenda-overriding-header "Projects")
                      (org-agenda-prefix-format "%20c ")
                      (org-columns-default-format-for-agenda "%TODO %7EFFORT %PRIORITY     %100ITEM 100%TAGS")
                      (org-agenda-skip-function 'aja/org-agenda-skip-scheduled-and-non-tasks)
                      (org-tags-match-list-sublevels 'indented)
                      (org-agenda-sorting-strategy
                       '(priority-down category-keep))))
          ))
        ("p" "Other daily agenda with TODO"
         ((agenda "" ((org-agenda-span 1)
                      (org-agenda-show-log t)))
          (tags-todo "-CATEGORY=\"Inbox\"/!TODO"
                     ((org-agenda-overriding-header "Projects")
                      (org-agenda-skip-function 'aja/org-agenda-skip-scheduled-and-non-tasks)
                      (org-tags-match-list-sublevels 'indented)
                      (org-agenda-sorting-strategy
                       '(category-keep)))))
         ((org-agenda-files "~/.org.file.list.p")))
        ("f" "Fortnight schedule"
         ((agenda "" ((org-agenda-span 14)
                      (org-agenda-start-day "-3d")
                      (org-agenda-start-on-weekday nil)))))
        ("W" "Done last week"
         agenda "" ((org-agenda-start-day "-14d")
                    (org-agenda-span 14)
                    (org-agenda-start-on-weekday 0)
                    (org-agenda-start-with-log-mode '(closed))
                    (org-agenda-overriding-header "Tasks completed last week:")
                    ))
        ))

(defun hacky-template-issue-workaround ()
  (format "**** %s" (current-kill 0 t)))


(setq org-capture-templates
      '(("t" "New todo item" entry
         (file+headline (lambda () (expand-file-name (car (org-agenda-files)))) "Incoming")
         "** TODO %?\n   %U\n")
        ("l" "New link for slack" entry
         (file+headline (lambda () (expand-file-name (car (org-agenda-files)))) "Share a link on Slack")
         (function hacky-template-issue-workaround) :prepend t :immediate-finish 1)
        ("f" "New link for FYI" entry
         (file+headline (lambda () (expand-file-name (car (org-agenda-files)))) "FYI")
         (function hacky-template-issue-workaround) :prepend t :immediate-finish 1)
        ("r" "Reading list" entry
         (file+headline (lambda () (expand-file-name (car (org-agenda-files)))) "Read one article from list")
         (function hacky-template-issue-workaround) :prepend t :immediate-finish 1)))

;; log CLOSED: when tasks are marked as done
(setq org-log-done 'time)

;; http://orgmode.org/manual/Deadlines-and-scheduling.html
(setq org-agenda-skip-scheduled-if-done 1)
(setq org-agenda-skip-deadline-if-done 1)
(setq org-agenda-window-setup 'current-window)
(setq org-ellipsis "…")

(add-hook 'org-load-hook
          (lambda ()
            (org-add-link-type
             "docx" 'follow-doc-link)
            (org-add-link-type
             "pdf" 'follow-doc-link)
            (require 'org-depend)
            (defun follow-doc-link (tag)
              (shell-command (format "open \"%s\"" tag)))))



(require 'netrc)
(setq netrc-file "~/.netrc-emacs")



;; Borrowed from magnars .emacs.d
;; Show keystrokes in progress
(setq echo-keystrokes 0.1)

;; Real emacs knights don't use shift to mark things
(setq shift-select-mode nil)

;; UTF-8 please
(setq locale-coding-system 'utf-8) ; pretty
(set-terminal-coding-system 'utf-8) ; pretty
(set-keyboard-coding-system 'utf-8) ; pretty
(set-selection-coding-system 'utf-8) ; please
(prefer-coding-system 'utf-8) ; with sugar on top

(fset 'yes-or-no-p 'y-or-n-p)

;; Lines should be 80 characters wide, not 72
(setq fill-column 80)

;; Don't be so stingy on the memory, we have lots now. It's the distant future.
(setq gc-cons-threshold 20000000)

;; No electric indent
(setq electric-indent-mode nil)

