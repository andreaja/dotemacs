;; disable toolbar (should be mac only, linux uses .Xresources)
(tool-bar-mode nil)

(setq ns-command-modifier (quote meta))
(setq mac-option-modifier nil)

;; Carbon Emacs, to get some libraries 
(load-library "autostart") 