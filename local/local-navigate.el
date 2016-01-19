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
