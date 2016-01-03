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

(require 'super-save)

(defun save-some-buffers-quietly ()
  (cl-flet ((message
             (format &rest args) nil))
    (save-some-buffers t)))

(defun super-save-command ()
  "Save the current buffer if needed."
  (when (and buffer-file-name
             (buffer-modified-p (current-buffer))
             (file-writable-p buffer-file-name))
    (save-some-buffers-quietly)))

(super-save-initialize)

(add-hook 'js2-mode-hook 'jquery-doc-setup)

;; Disable electric here docs in shell-script-mode
;; http://unix.stackexchange.com/questions/20121/how-to-disable-emacs-here-document-completion
(add-hook 'sh-mode-hook
          (lambda ()
            (sh-electric-here-document-mode -1)))

(add-hook 'css-mode-hook (lambda () (rainbow-mode 1)))
(add-hook 'html-mode-hook (lambda () (rainbow-mode 1)))


