;;; midje-mode.el --- Minor mode for Midje tests

(require 'clojure-mode)
(require 'cider)
(require 'nrepl-client)
(require 'newcomment)
(require 'midje-mode-praise)

(defvar midje-running-fact nil)   ;; KLUDGE!

(defvar midje-comments ";.;.")
(defvar last-checked-midje-fact nil)
(defvar last-checked-midje-fact-ns nil)
(defvar midje-fact-regexp "^(\\(\\(facts?\\)\\|\\(tabular\\)\\)\\([[:space:]]\\|$\\)")
(defvar midje-syntax-table nil)

(defun midje-goto-above-fact ()
  (if (bolp) (forward-char)) ; at first character of defun, beginning-of-defun moves back.
  (beginning-of-defun))

(defun midje-goto-below-code-under-test ()
  (end-of-defun)
  (forward-line))

;; Util

(defun midje-at-start-of-identifier? ()
  (not (string= (string (char-syntax (char-before))) "w")))

(defun midje-identifier ()
  "Return text of nearest identifier."
  (when (not midje-syntax-table)
    (setq midje-syntax-table (make-syntax-table (syntax-table)))
    (modify-syntax-entry ?- "w" midje-syntax-table)
    (modify-syntax-entry ?? "w" midje-syntax-table)
    (modify-syntax-entry ?! "w" midje-syntax-table))

  (save-excursion
    (with-syntax-table midje-syntax-table
      (let ((beg (if (midje-at-start-of-identifier?)
                     (point)
                   (progn (backward-word) (point)))))
        (forward-word)
        (buffer-substring-no-properties beg (point))))))

(defun midje-to-unfinished ()
  (goto-char (point-min))
  (search-forward-regexp "(\\(.*/\\)?unfinished"))

(defun midje-within-unfinished? ()
  (let ((target (point))
        unfinished-beg
        unfinished-end)
    (save-excursion
      (save-restriction
        (midje-to-unfinished)
        (beginning-of-defun)
        (setq unfinished-beg (point))
        (end-of-defun)
        (setq unfinished-end (point))
        (and (>= target unfinished-beg)
             (<= target unfinished-end))))))

(defun midje-tidy-unfinished ()
  (midje-to-unfinished) (let ((fill-prefix "")) (fill-paragraph nil))
  (midje-to-unfinished)
  (beginning-of-defun)
  (let ((beg (point)))
    (end-of-defun)
    (indent-region beg (point))))

(defun midje-eval-unfinished ()
  (midje-to-unfinished)
  (end-of-defun)
  (cider-eval-last-expression))

(defun midje-add-identifier-to-unfinished-list (identifier)
  (save-excursion
    (save-restriction
      (widen)
      (midje-to-unfinished) (insert " ") (insert identifier)
      (midje-tidy-unfinished)
      (midje-eval-unfinished))))

(defun midje-remove-identifier-from-unfinished-list ()
  (save-excursion
    (save-restriction
      (widen)
      (let ((identifier (midje-identifier)))
        (with-syntax-table midje-syntax-table
          (unless (midje-at-start-of-identifier?) (backward-word))
          (kill-word nil)
          (midje-tidy-unfinished)
          identifier)))))

(defun midje-add-defn-after-unfinished (identifier)
  (widen)
  (end-of-defun)
  (newline-and-indent)
  (insert "(defn ")
  (insert identifier)
  (insert " [])")
  (newline-and-indent)
  (newline-and-indent)
  (insert "(fact \"\")")
  (newline-and-indent)
  (search-backward "[]")
  (forward-char))

(defun midje-insert-failure-message (str &optional justify)
  (let ((start-point (point))
        (end-point (progn (insert str) (point))))
    (midje-add-midje-comments start-point end-point)
    (ansi-color-apply-on-region start-point end-point)
    (goto-char start-point)
    (unless (string= ";" (char-to-string (char-after)))
      (delete-char 1))))

(defun midje-display-reward ()
  (save-excursion
    (save-restriction
      (let ((start (point)))
        (insert (midje-random-praise))
        (narrow-to-region start (point))
        (goto-char (point-min))
        (fill-paragraph nil)
        (midje-add-midje-comments (point-min) (point-max))))))

(defun midje-add-midje-comments (start-point end-point)
  (let ((comment-start midje-comments)
        (comment-empty-lines t))
    (comment-region start-point end-point)))

(defun midje-on-fact? ()
  (save-excursion
    (save-restriction
      (narrow-to-defun)
      (goto-char (point-min))
      (search-forward "fact" nil t))))

(defun midje-doto-facts (fun)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward midje-fact-regexp nil t)
      (funcall fun))))


(add-hook 'midje-mode-hook 'midje-colorize)
(defun midje-colorize ()
  (flet ((f (keywords face)
            (cons (concat "\\<\\("
                          (mapconcat 'symbol-name keywords "\\|")
                          "\\)\\>")
                  face)))
    (font-lock-add-keywords
     nil
     (list (f '(fact facts future-fact future-facts tabular provided)
              'font-lock-keyword-face)
           (f '(just contains has has-suffix has-prefix
                     truthy falsey anything exactly roughly throws)
              'font-lock-type-face)
           '("=>\\|=not=>" . font-lock-negation-char-face) ; arrows
           '("\\<\\.+[a-zA-z]+\\.+\\>" . 'font-lock-type-face))))) ; metaconstants


;; Interactive

(defun midje-next-fact ()
  (interactive)
  (re-search-forward midje-fact-regexp))

(defun midje-previous-fact ()
  (interactive)
  (re-search-backward midje-fact-regexp))

(defun midje-clear-comments ()
  "Midje uses comments to display test results. Delete
all such comments."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (let ((kill-whole-line t))
      (while (search-forward midje-comments nil t)
        (beginning-of-line)
        (kill-line)))))

(defun nrepl-check-fact-handler (buffer)
  (nrepl-make-response-handler buffer
                               (lambda (buffer str)
                                 (with-current-buffer buffer
                                   (if (string-equal str "true") (midje-display-reward))))
                               (lambda (buffer str)
                                 (with-current-buffer buffer
                                   (midje-insert-failure-message (format "%s" str))))
                               '()
                               '()))

(defun midje-check-fact-near-point ()
  "Used when `point' is on or just after a Midje fact.
Check that fact and also save it for use of
`midje-recheck-last-fact-checked'."
  (interactive)
  (midje-clear-comments)
  (setq last-checked-midje-fact-ns nrepl-buffer-ns)
  (let ((string (save-excursion
                  (mark-defun)
                  (buffer-substring-no-properties (mark) (point)))))
    (setq last-checked-midje-fact string)
    (midje-goto-above-fact)
    (nrepl-send-string string
                       (nrepl-check-fact-handler (current-buffer))
                       nrepl-buffer-ns)))

(defun midje-recheck-last-fact-checked ()
  "Used when `point` is on or just after a def* form.
Has the Clojure REPL compile that form, then rechecks
the last fact checked (by `midje-check-fact-near-point')."

  (interactive)
  (midje-clear-comments)
  (midje-goto-below-code-under-test)
  (nrepl-send-string last-checked-midje-fact
                     (nrepl-check-fact-handler (current-buffer))
                     last-checked-midje-fact-ns))

(defun midje-check-fact ()
  "If on or near a Midje fact, check it with
`midje-check-fact-near-point'. Otherwise, compile the
nearby Clojure form and recheck the last fact checked
(with `midje-recheck-last-fact-checked')."
  (interactive)
  (if (midje-on-fact?)
      (midje-check-fact-near-point)
    (midje-recheck-last-fact-checked)))

(defun midje-hide-all-facts ()
  (interactive)
  (midje-doto-facts #'hs-hide-block))

(defun midje-show-all-facts ()
  (interactive)
  (midje-doto-facts #'hs-show-block))


(defun midje-focus-on-this-fact ()
  (interactive)
  (midje-hide-all-facts)
  (hs-show-block))

(defun midje-unfinished ()
  (interactive)
  (if (midje-within-unfinished?)
      (midje-add-defn-after-unfinished (midje-remove-identifier-from-unfinished-list))
    (midje-add-identifier-to-unfinished-list (midje-identifier))))

(defvar midje-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-c ,") 'midje-check-fact)
    (define-key map (kbd "C-c .") 'midje-check-fact)
    (define-key map (kbd "C-c C-,") 'midje-check-fact-near-point)
    (define-key map (kbd "C-c C-.") 'midje-recheck-last-fact-checked)
    (define-key map (kbd "C-c k")   'midje-clear-comments)

    (define-key map (kbd "C-c f") 'midje-focus-on-this-fact)
    (define-key map (kbd "C-c h") 'midje-hide-all-facts)
    (define-key map (kbd "C-c s") 'midje-show-all-facts)

    (define-key map (kbd "C-c n") 'midje-next-fact)
    (define-key map (kbd "C-c p") 'midje-previous-fact)

    (define-key map (kbd "C-c u") 'midje-unfinished)

    map)
  "Keymap for Midje mode.")

;;;###autoload
(define-minor-mode midje-mode
  "A minor mode for running Midje tests when using cider.

\\{midje-mode-map}"
  nil " Midje" midje-mode-map
  (hs-minor-mode 1))

;;;###autoload
(progn
  (defun midje-mode-maybe-enable ()
    "Enable midje-mode if the current buffer contains a \"midje.\" string."
    (let ((regexp "midje\\."))
      (save-excursion
        (when (or (re-search-backward regexp nil t)
                  (re-search-forward regexp nil t))
          (midje-mode t)))))
  (add-hook 'clojure-mode-hook 'midje-mode-maybe-enable))

(eval-after-load 'clojure-mode
  '(define-clojure-indent
     (fact 'defun)
     (facts 'defun)
     (against-background 'defun)
     (provided 0)))

(provide 'midje-mode)
