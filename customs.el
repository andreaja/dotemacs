;; custom key bindings and commands

(load "load-tramp")

(setq custom-file "~/emacs/settings.el")
(load custom-file 'noerror)

;; disable splash 
(setq inhibit-startup-message t)

;;(setq xml-based-modes (cons 'nxml-mode xml-based-modes))
(fset 'xml-mode 'nxml-mode)

;; maxframe
(require 'maxframe)
(add-hook 'window-setup-hook 'maximize-frame t)

;; iswitchb mode 
(iswitchb-mode 1)

;; display column numbers 
(setq column-number-mode t)

(mouse-avoidance-mode 'animate)

;; gist
(require 'gist)

;; stop leaving backup~ turds scattered everywhere
(setq backup-directory-alist '(("." . "~/.emacs-backups")))

;; stop forcing me to spell out "yes"
(fset 'yes-or-no-p 'y-or-n-p) 

;; 
(setq-default indent-tabs-mode nil)


;; rebind return to whatever C-j is
(mapcar
 (lambda (mode)
   (let ((mode-hook (intern (concat (symbol-name mode) "-hook")))
	 (mode-map  (intern (concat (symbol-name mode) "-map"))))
     (add-hook mode-hook
	       `(lambda nil
		  (local-set-key (kbd "RET")
				 (or (lookup-key ,mode-map "\C-j")
				     (lookup-key global-map "\C-j")))))))
 '(ada-mode c-mode c++-mode cperl-mode emacs-lisp-mode java-mode html-mode
	    lisp-mode php-mode ruby-mode sh-mode sgml-mode python-mode))


(defun revert-all-buffers()
  "Refreshs all open buffers from their respective files"
  (interactive)
  (let* ((list (buffer-list))
	 (buffer (car list)))
    (while buffer
      (if (string-match "\\*" (buffer-name buffer))
	  (progn
	    (setq list (cdr list))
	    (setq buffer (car list)))
	(progn
	  (set-buffer buffer)
	  (revert-buffer t t t)
	  (setq list (cdr list))
	  (setq buffer (car list))))))
  (message "Refreshing open files"))


;; from http://my.opera.com/AxxL/blog/2007/09/23/emacs-query-replace-in-open-buffers
;; Query Replace in open Buffers
(defun query-replace-in-open-buffers (arg1 arg2)
  "query-replace in open files"
  (interactive "sQuery Replace in open Buffers: \nsquery with: ")
  (mapcar
   (lambda (x)
     (find-file x)
     (save-excursion
       (beginning-of-buffer)
       (query-replace arg1 arg2)))
   (delq
    nil
    (mapcar
     (lambda (x)
       (buffer-file-name x))
     (buffer-list)))))

