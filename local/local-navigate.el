(defun exchange-point-and-mark-no-activate ()
  "Identical to \\[exchange-point-and-mark] but will not activate the region."
  (interactive)
  (exchange-point-and-mark)
  (deactivate-mark nil))
(define-key global-map [remap exchange-point-and-mark] 'exchange-point-and-mark-no-activate)



(defun end-of-code-or-end-of-next-line ()
  "Move to the end of the line. If already there, move to the end of next line"
  (interactive)
  (if (not (eolp))
      (end-of-line)
    (forward-line)
    (end-of-line)))
(define-key my-keys-minor-mode-map [remap move-end-of-line] 'end-of-code-or-end-of-next-line)

(defun org-visual-line-beginning-of-line-or-previous ()
  "Move to first non-whitespace character of visual line. If already there, move to first non-whitespace of previous visual line.
This function is designed for org-mode with visual-line-mode enabled."
  (interactive)
  (if (and (eq major-mode 'org-mode) visual-line-mode)
      (let* ((current-pos (point))
             (visual-line-start (save-excursion (beginning-of-visual-line) (point)))
             (first-non-ws (save-excursion
                             (beginning-of-visual-line)
                             (skip-chars-forward " \t")
                             (point))))
        (if (= current-pos first-non-ws)
            ;; Already at first non-whitespace of visual line, move to previous visual line
            (progn
              (beginning-of-visual-line 0)  ; Move to beginning of previous visual line
              (if (bobp)
                  (message "Beginning of buffer")
                ;; Move to first non-whitespace of this visual line
                (skip-chars-forward " \t")))
          ;; Not at first non-whitespace, move there
          (beginning-of-visual-line)
          (skip-chars-forward " \t")))
    ;; Not in org-mode with visual-line-mode, use default behavior
    (smarter-move-beginning-of-line 1)))

(defun org-visual-line-end-of-line-or-next ()
  "Move to end of visual line. If already there, move to end of next visual line.
This function is designed for org-mode with visual-line-mode enabled."
  (interactive)
  (if (and (eq major-mode 'org-mode) visual-line-mode)
      (let* ((current-pos (point))
             (visual-line-end (save-excursion (end-of-visual-line 1) (point))))
        (if (= current-pos visual-line-end)
            ;; Already at end of visual line, move to next visual line
            (progn
              (end-of-visual-line 2)  ; Move to end of next visual line
              (when (eobp)
                (message "End of buffer")))
          ;; Not at end of visual line, move to end
          (end-of-visual-line 1)))
    ;; Not in org-mode with visual-line-mode, use default behavior
    (end-of-code-or-end-of-next-line)))
