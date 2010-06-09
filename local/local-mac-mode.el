(setq ns-command-modifier (quote meta))
(setq mac-option-modifier nil)


(defun maximize-frame () 
  (interactive)
  (set-frame-position (selected-frame) 0 0)
  (set-frame-size (selected-frame) 1000 1000))
