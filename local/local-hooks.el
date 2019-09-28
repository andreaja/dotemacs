;; http://atomized.org/2008/12/emacs-create-directory-before-saving/
(add-hook 'before-save-hook
          '(lambda ()
             (or (file-exists-p (file-name-directory buffer-file-name))
                 (make-directory (file-name-directory buffer-file-name) t))))

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


(add-hook 'web-mode-hook (lambda  ()
                           (setq web-mode-markup-indent-offset 2)
                           (setq web-mode-css-indent-offset 2)
                           (setq web-mode-code-indent-offset 2)
                           (setq web-mode-enable-current-element-highlight 1)
                           (setq web-mode-enable-css-colorization t)
                           ))

