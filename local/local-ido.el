(require 'ido)

(setq ido-enable-flex-matching t) ; fuzzy matching is a must have

(setq ido-execute-command-cache nil
      ido-create-new-buffer 'always
      ido-use-filename-at-point 'guess)
(ido-mode t)
