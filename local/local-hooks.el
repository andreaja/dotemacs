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

;; Don't look for inline formatting inside links.  markdown-mode scans link
;; text and URLs for emphasis and only rejects each hit afterwards, so a URL
;; carrying tracking parameters (utm_source, utm_medium, ...) makes the italic
;; matcher restart at every underscore.  On a file of ~600 such links that is
;; ~300 ms per keystroke; skipping links outright brings it to ~10 ms.
;;
;; The link matchers run before these five, so by the time they are called the
;; link faces are already in place and can be used to find the spans to skip.
(defconst aj/markdown-link-faces
  '(markdown-link-face markdown-url-face markdown-plain-url-face
    markdown-link-title-face markdown-reference-face)
  "Faces marking text that inline-formatting matchers should not scan.")

(defsubst aj/markdown-link-face-at-p (pos)
  (let ((f (get-text-property pos 'face)))
    (if (consp f)
        (let (hit)
          (dolist (x f hit)
            (when (memq x aj/markdown-link-faces) (setq hit t))))
      (memq f aj/markdown-link-faces))))

(defun aj/markdown-next-link-start (from to)
  "First position in FROM..TO carrying a link face, or nil if there is none."
  (let ((pos from) hit)
    (while (and (not hit) (< pos to))
      (if (aj/markdown-link-face-at-p pos)
          (setq hit pos)
        (setq pos (next-single-property-change pos 'face nil to))))
    hit))

(defun aj/markdown-match-outside-links (orig last)
  "Run inline matcher ORIG only on the parts of point..LAST outside links."
  (let (result)
    (while (and (not result) (< (point) last))
      (while (and (< (point) last) (aj/markdown-link-face-at-p (point)))
        (goto-char (next-single-property-change (point) 'face nil last)))
      (if (>= (point) last)
          (goto-char last)
        (let ((bound (or (aj/markdown-next-link-start (point) last) last)))
          (if (<= bound (point))
              (goto-char (min last (1+ (point))))
            (setq result (funcall orig bound))
            (unless result (goto-char bound))))))
    result))

(with-eval-after-load 'markdown-mode
  (dolist (f '(markdown-match-bold markdown-match-italic
               markdown-match-math-single markdown-match-math-double
               markdown-match-math-display))
    (advice-add f :around #'aj/markdown-match-outside-links)))

