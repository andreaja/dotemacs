(require 'ido)

(setq ido-enable-flex-matching t) ; fuzzy matching is a must have

(setq ido-execute-command-cache nil)
(ido-mode t)

;; TODO make this work
;; (defun aja-ido-find-file-in-tag-files ()
;;   (interactive)
;;   (save-excursion
;;     (let ((enable-recursive-minibuffers t))
;;       (visit-tags-table-buffer))
;;       (ido-completing-read "Project files: "
;;                         (tags-table-files)
;;                         nil t)))
