;; http://atomized.org/2008/12/emacs-create-directory-before-saving/
(add-hook 'before-save-hook
          '(lambda ()
             (or (file-exists-p (file-name-directory buffer-file-name))
                 (make-directory (file-name-directory buffer-file-name) t))))

;; For pom-file buffers
(defun detect-and-rename-pom-file-buffer ()
  (interactive)
  (when (string= (buffer-name) "pom.xml")
    (let* ((folders (split-string (buffer-file-name) "/"))
           (base-dir (car (last folders 2))))
      (rename-buffer (format "%s-pom" base-dir)))))
(add-hook 'find-file-hook 'detect-and-rename-pom-file-buffer)


(add-hook 'focus-out-hook (lambda () (save-some-buffers t)))
