;; http://endlessparentheses.com/emacs-narrow-or-widen-dwim.html
(defun narrow-or-widen-dwim (p)
  "Widen if buffer is narrowed, narrow-dwim otherwise.
Dwim means: region, org-src-block, org-subtree, or defun,
whichever applies first. Narrowing to org-src-block actually
calls `org-edit-src-code'.

With prefix P, don't widen, just narrow even if buffer is
already narrowed."
  (interactive "P")
  (declare (interactive-only))
  (cond ((and (buffer-narrowed-p) (not p)) (widen))
        ((region-active-p)
         (narrow-to-region (region-beginning) (region-end)))
        ((derived-mode-p 'org-mode)
         ;; `org-edit-src-code' is not a real narrowing
         ;; command. Remove this first conditional if you
         ;; don't want it.
         (cond ((ignore-errors (org-edit-src-code))
                (delete-other-windows))
               ((ignore-errors (org-narrow-to-block) t))
               (t (org-narrow-to-subtree))))
        ((derived-mode-p 'latex-mode)
         (LaTeX-narrow-to-environment))
        (t (narrow-to-defun))))

(define-key my-keys-minor-mode-map [(control x) (n)] 'narrow-or-widen-dwim)
(add-hook 'LaTeX-mode-hook
          (lambda () (define-key LaTeX-mode-map "\C-xn" nil)))



;; thanks josse
(defun yank-flexible ()
  "Use Ido to select a kill-ring entry to yank."
  (interactive)
  (insert (ido-completing-read "Select kill: " kill-ring)))

(defun yank-pop-dwim (&optional arg)
  (interactive "*p")
  (if (eq last-command 'yank)
      (yank-pop arg)
    (yank-flexible)))
(define-key my-keys-minor-mode-map [(meta y)] 'yank-pop-dwim)


;; http://emacsredux.com/blog/2013/03/27/indent-region-or-buffer/
(defun indent-buffer ()
  "Indent the currently visited buffer."
  (interactive)
  (indent-region (point-min) (point-max)))

(defun indent-region-or-buffer ()
  "Indent a region if selected, otherwise the whole buffer."
  (interactive)
  (save-excursion
    (if (region-active-p)
        (progn
          (indent-region (region-beginning) (region-end))
          (message "Indented selected region."))
      (progn
        (indent-buffer)
        (message "Indented buffer.")))))
(define-key my-keys-minor-mode-map [(control .) (i)] 'indent-region-or-buffer)
(define-key my-keys-minor-mode-map [(control meta \\)] 'indent-region-or-buffer)

;;; Stefan Monnier <foo at acm.org>. It is the opposite of fill-paragraph
(defun unfill-paragraph ()
  "Takes a multi-line paragraph and makes it into a single line of text."
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))
(define-key my-keys-minor-mode-map (kbd "C-M-q") 'unfill-paragraph)

;; example of binding keys only when html-mode is active
;; http://ergoemacs.org/emacs/emacs_set_keys_for_major_mode.html

(defun my-html-mode-keys ()
  "Modify keymaps used by `html-mode'."
  (local-set-key [(control c) (control f)] 'sgml-close-tag)
  )

;; add to hook
(add-hook 'html-mode-hook 'my-html-mode-keys)

(defun my-web-mode-keys ()
  "Modify keymaps used by `web-mode'."
  (local-set-key [(control c) (control f)] 'web-mode-element-close)
  )

;; add to hook
(add-hook 'web-mode-hook 'my-web-mode-keys)

