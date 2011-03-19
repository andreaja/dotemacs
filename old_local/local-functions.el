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


;; http://atomized.org/2008/12/emacs-create-directory-before-saving/
(add-hook 'before-save-hook
          '(lambda ()
             (or (file-exists-p (file-name-directory buffer-file-name))
                 (make-directory (file-name-directory buffer-file-name) t))))

;; http://amitp.blogspot.com/2008/05/emacs-full-screen-on-mac-os-x.html
(defun mac-toggle-max-window ()
  (interactive)
  (set-frame-parameter nil 'fullscreen (if (frame-parameter nil 'fullscreen)
                                           nil
                                           'fullboth)))

;; http://www.emacswiki.org/emacs/FullScreen
;; works on linux, not on mac?
;; todo: refactor this and mac-toggle-max-window to bind to fullscreen depending on system
(defun fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen
                       (if (frame-parameter nil 'fullscreen) nil 'fullboth)))

;;(global-set-key [f11] 'fullscreen)
