(setq ns-command-modifier (quote meta))
(setq mac-option-modifier nil)
(setq locate-command "mdfind")

(defun andreaja/half-screen ()
  "set frame size to half the macbook air screen"
  (interactive)
  (set-frame-size (selected-frame) 731 915 t))


