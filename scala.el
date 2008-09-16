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





;; Stolen from: http://paste.lisp.org/display/54999
;; not working 
;; ;; Flymake integration copied and heavily modified from:
;; ;; http://snippets.dzone.com/posts/show/5013
;; (require 'compile)
;; (require 'flymake)

;; ;; flymake
;; (defun my-flymake-show-next-error()
;;   (interactive)
;;   (flymake-goto-next-error)
;;   (flymake-display-err-menu-for-current-line))

;; (local-set-key "\C-c\C-v" 'my-flymake-show-next-error)

;; (add-hook 'scala-mode-hook
;;           (lambda () (flymake-mode-on)))

;; ;; From the current directory, traverse down until you find a Makefile
;; (defun find-makefile ()
;;   (let ((fn buffer-file-name))
;;     (let ((dir (file-name-directory fn)))
;;       (while (and (not (file-exists-p (concat dir "/Makefile")))
;;                   (not (equal dir (file-truename (concat dir "/..")))))
;;         (setf dir (file-truename (concat dir "/.."))))
;;       (if (not (file-exists-p (concat dir "/Makefile")))
;;           (message "No Makefile found")
;;         dir))))

;; (defun flymake-scala-init ()
;;   (progn
;;     (remove-hook 'after-save-hook 'flymake-after-save-hook t)
;;     (save-buffer)
;;     (add-hook 'after-save-hook 'flymake-after-save-hook nil t)
;;     (list "make" (list "-C" (find-makefile) "install"))))

;; (push '(".+\\.scala$" flymake-scala-init) flymake-allowed-file-name-masks)
