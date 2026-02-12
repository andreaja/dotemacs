(defun find-files (list-of-files)
  (mapcar (lambda (x) (find-file-noselect x)) list-of-files)
  )


(defun load-calendar ()
  (interactive)
  (find-file (expand-file-name CALENDAR_FILE))
  (setq-local auto-revert-use-notify nil)
  (auto-revert-mode))

(find-files (read-lines (expand-file-name "~/.org.file.list")))
(find-files (read-lines (expand-file-name "~/.org.file.list.p")))
(load-calendar)

(switch-to-buffer "*scratch*")

