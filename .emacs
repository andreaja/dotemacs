;; .emacs (vaguely stolen from Steve Yegge)

(defvar emacs-root "/home/aja/")
;; something wrong here, fix it later
;(labels ((add-path (p)
;	 (add-to-list 'load-path
;			(concat emacs-root p))))
;   (add-path "emacs/site-lisp/") ;; elisp stuff I find on the 'net
;)

;; giss a shell dear

(shell)

;; disable splash 
(setq inhibit-startup-message t)


;; emacs-rails
;; http://dima-exe.ru/rails-on-emacs


(setq load-path (cons "~/emacs/site-lisp" load-path))
(require 'inf-ruby)
(require 'snippet)
(require 'find-recursive)
(setq load-path (cons "~/emacs/site-lisp/emacs-rails" load-path))
(require 'rails)

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



;; Sudo shell for tramp, use C-x C-r to sudo find-file
;; refactor this out obivously
;; from here: http://www.emacswiki.org/cgi-bin/wiki/TrampMode

(defvar find-file-root-prefix (if (featurep 'xemacs) "/[sudo/root@localhost]" "/sudo:root@localhost:" )
  "*The filename prefix used to open a file with `find-file-root'.")

(defvar find-file-root-history nil
  "History list for files found using `find-file-root'.")

(defvar find-file-root-hook nil
  "Normal hook for functions to run after finding a \"root\" file.")

(defun find-file-root ()
  "*Open a file as the root user.
   Prepends `find-file-root-prefix' to the selected file name so that it
   maybe accessed via the corresponding tramp method."

  (interactive)
  (require 'tramp)
  (let* ( ;; We bind the variable `file-name-history' locally so we can
   	 ;; use a separate history list for "root" files.
   	 (file-name-history find-file-root-history)
   	 (name (or buffer-file-name default-directory))
   	 (tramp (and (tramp-tramp-file-p name)
   		     (tramp-dissect-file-name name)))
   	 path dir file)

    ;; If called from a "root" file, we need to fix up the path.
    (when tramp
      (setq path (tramp-file-name-path tramp)
   	    dir (file-name-directory path)))

    (when (setq file (read-file-name "Find file (UID = 0): " dir path))
      (find-file (concat find-file-root-prefix file))
      ;; If this all succeeded save our new history list.
      (setq find-file-root-history file-name-history)
      ;; allow some user customization
      (run-hooks 'find-file-root-hook))))

(global-set-key [(control x) (control r)] 'find-file-root)

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


;; this no worky
;; (defun my-js-mode-hook ()
;;   (require 'cperl-mode)
;;   (setq tab-width 2
;;         indent-tabs-mode nil
;;         c-basic-offset 2))

;; (add-hook 'js-mode-hook 'my-js-mode-hook)


 (setq load-path (cons (expand-file-name "/usr/share/doc/git-core/contrib/emacs") load-path))
 (require 'vc-git)
 (when (featurep 'vc-git) (add-to-list 'vc-handled-backends 'git))
 (require 'git)
 (autoload 'git-blame-mode "git-blame"
           "Minor mode for incremental blame for Git." t)


(require 'anything)

(setq load-path (cons "~/emacs/site-lisp/distel" load-path))
(require 'distel)
(distel-setup)

(setq load-path (cons "~/emacs/site-lisp/scala" load-path))
;(require 'scala-mode)
;
(require 'scala-mode-auto)
;(require 'inferior-scala-mode)


(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.32")
 '(ecb-tip-of-the-day nil)
 )
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )


;;(add-hook 'write-file-hooks 'nuke-trailing-whitespace)


(setq exec-path (cons "/home/aja/var/scala/bin/" exec-path))

(require 'scala-mode-auto)


;; (defvar scala-build-commad nil)
;; (make-variable-buffer-local 'scala-build-command)

;; (add-hook 'scala-mode-hook
;;           (lambda ()
;; 	    (flymake-mode-on)
;; 	    ))

;; (defun flymake-scala-init ()
;;   (let* ((text-of-first-line (buffer-substring-no-properties (point-min) (min 20 (point-max)))))
;;     (progn
;;       (remove-hook 'after-save-hook 'flymake-after-save-hook t)
;;       (save-buffer)
;;       (add-hook 'after-save-hook 'flymake-after-save-hook nil t)
;;       (if (string-match "^//script" text-of-first-line)
;; 	  (list "fsc" (list "-Xscript" "MainScript" "-d" "/tmp" buffer-file-name))
;; 	(or scala-build-command (list "fsc" (list "-d" "/tmp" buffer-file-name))))
;;       )))

;; (push '(".+\\.scala$" flymake-scala-init) flymake-allowed-file-name-masks)
;; (push '("^\\(.*\\):\\([0-9]+\\): error: \\(.*\\)$" 1 2 nil 3) flymake-err-line-patterns)

;; (set (make-local-variable 'indent-line-function) 'scala-indent-line)

;; (defun scala-indent-line ()
;;   "Indent current line of Scala code."
;;   (interactive)
;;   (indent-line-to (max 0 (scala-calculate-indentation))))

;; (defun scala-calculate-indentation ()
;;   "Return the column to which the current line should be indented."
;;   (save-excursion
;;     (scala-maybe-skip-leading-close-delim)
;;     (let ((pos (point)))
;;       (beginning-of-line)
;;       (if (not (search-backward-regexp "[^\n\t\r ]" 1 0))
;; 	  0
;; 	(progn
;; 	  (scala-maybe-skip-leading-close-delim)
;; 	  (+ (current-indentation) (* 2 (scala-count-scope-depth (point) pos))))))))

;; (defun scala-maybe-skip-leading-close-delim ()
;;   (beginning-of-line)
;;   (forward-to-indentation 0)
;;   (if (looking-at "\\s)")
;;       (forward-char)
;;     (beginning-of-line)))

;; (defun scala-face-at-point (pos)
;;   "Return face descriptor for char at point."
;;   (plist-get (text-properties-at pos) 'face))

;; (defun scala-count-scope-depth (rstart rend)
;;   "Return difference between open and close scope delimeters."
;;   (save-excursion
;;     (goto-char rstart)
;;     (let ((open-count 0)
;; 	  (close-count 0)
;; 	  opoint)
;;       (while (and (< (point) rend)
;; 		  (progn (setq opoint (point))
;; 			 (re-search-forward "\\s)\\|\\s(" rend t)))
;; 	(if (= opoint (point))
;; 	    (forward-char 1)
;; 	  (cond

;; 	   ;; Use font-lock-mode to ignore strings and comments
;; 	   ((scala-face-at-point (- (point) 1))) 

;; 	   ((looking-back "\\s)")
;; 	    (incf close-count))
;; 	   ((looking-back "\\s(")
;; 	    (incf open-count))
;; 	   )))
;;       (- open-count close-count))))

 
;;(provide 'scala-extensions)

;;(require 'scala-electric)
;;(add-hook 'scala-mode-hook '(lambda() (scala-electric-mode)))