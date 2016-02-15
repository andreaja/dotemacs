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
        ((use-region-p)
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
    (if (use-region-p)
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

;; From magnars emacs.d
;; kill region if active, otherwise kill backward word
(defun kill-region-or-backward-word ()
  (interactive)
  (if (use-region-p)
      (kill-region (region-beginning) (region-end))
    (backward-kill-word 1)))


;; copy region if active
;; otherwise copy to whole line
;;   * with prefix, copy N whole lines

(defun copy-to-end-of-line ()
  (interactive)
  (kill-ring-save (point)
                  (line-end-position))
  (message "Copied to end of line"))

(defun copy-whole-lines (arg)
  "Copy lines (as many as prefix argument) in the kill ring"
  (interactive "p")
  (kill-ring-save (line-beginning-position)
                  (line-beginning-position (+ 1 arg)))
  (message "%d line%s copied" arg (if (= 1 arg) "" "s")))

(defun copy-line (arg)
  "Copy to end of line, or as many lines as prefix argument"
  (interactive "P")
  (if (null arg)
      (copy-whole-lines 1)
    (copy-whole-lines (prefix-numeric-value arg))))

(defun save-region-or-current-line (arg)
  (interactive "P")
  (if (use-region-p)
      (kill-ring-save (region-beginning) (region-end))
    (copy-line arg)))

;; Use M-w for copy-line if no active region
(global-set-key (kbd "M-w") 'save-region-or-current-line)
(global-set-key (kbd "C-w") 'kill-region-or-backward-word)

(autoload 'zap-up-to-char "misc")
(define-key my-keys-minor-mode-map [(meta z)] 'zap-up-to-char)

;; example of binding keys only when html-mode is active
;; http://ergoemacs.org/emacs/emacs_set_keys_for_major_mode.html

(defun my-html-mode-keys ()
  "Modify keymaps used by `html-mode'."
  (local-set-key [(control c) (control f)] 'sgml-close-tag)
  )

(add-hook 'html-mode-hook 'my-html-mode-keys)

(defun my-web-mode-keys ()
  "Modify keymaps used by `web-mode'."
  (local-set-key [(control c) (control f)] 'web-mode-element-close)
  )

(add-hook 'web-mode-hook 'my-web-mode-keys)

;; setup paredit
(require 'paredit)
(defun paredit-kill-region-or-backward-word ()
  (interactive)
  (if (use-region-p)
      (kill-region (region-beginning) (region-end))
    (paredit-backward-kill-word)))

(define-key paredit-mode-map (kbd "C-w") 'paredit-kill-region-or-backward-word)
(define-key paredit-mode-map (kbd "M-C-<backspace>") 'backward-kill-sexp)

(add-hook 'clojure-mode-hook (lambda () (paredit-mode 1)))
(add-hook 'emacs-lisp-mode-hook (lambda () (paredit-mode 1)))

