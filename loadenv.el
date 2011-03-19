(setq custom-file "~/.emacs.d/settings.el")
(load custom-file 'noerror)

(add-to-list 'load-path "~/.emacs.d/local")

(load "local-minor-modes")

(if (eq system-type 'darwin)
    (load "local-mac-mode"))

