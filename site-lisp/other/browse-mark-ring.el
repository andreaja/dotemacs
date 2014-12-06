;;; browse-mark-ring.el --- browse mark ring
;; Copyright (C) 2004  Free Software Foundation, Inc.

;; Author: ChunYe Wang <CharlesWang@peoplemail.com.cn>
;; Keywords: 

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:
;; From https://github.com/Wu-Bo/.emacs.d/blob/master/browse-mark-ring.el

;; install: 
;; 
;; Place this file somewhere in your `load-path', and add:

;; (require 'wcy-browse-mark-ring)
;; M-x wcy-browse-mark-ring 
;; 
;;


;;; Code:

(defun browse-mark-ring ()
  (interactive)
  (with-output-to-temp-buffer "*Browse Mark Ring*"
    (save-excursion
      (set-buffer standard-output)
      (browse-mark-ring-mode))))

(defvar browse-mark-ring-current-marks nil)
(defvar browse-mark-ring-map ())

(if browse-mark-ring-map
    ()
  (setq browse-mark-ring-map (make-sparse-keymap))
  (define-key browse-mark-ring-map (kbd "<RET>") 'browse-mark-ring-goto)
  (define-key browse-mark-ring-map (kbd "n") 'browse-mark-ring-next-line)
  (define-key browse-mark-ring-map (kbd "p") 'browse-mark-ring-previous-line)
  (define-key browse-mark-ring-map (kbd "N") 'browse-mark-ring-next-buffer)
  (define-key browse-mark-ring-map (kbd "P") 'browse-mark-ring-previous-buffer)
  (define-key browse-mark-ring-map "q" 'browse-mark-ring-quit))

(defun browse-mark-ring-get-current-mark()
  (or browse-mark-ring-current-marks (error "not in browse mark ring mode"))
  (beginning-of-line)
  (let ((i (count-lines (point-min) (point))))
    (message "i is %d" i)
    (let ((m (elt browse-mark-ring-current-marks  i)))
      (if (null (marker-buffer m))
          (error "buffer has gone.")
        m))))
  
(defun browse-mark-ring-goto ()
  (interactive)
  (let ((m (browse-mark-ring-get-current-mark)))
    (pop-to-buffer (marker-buffer m))
    (goto-char m)))

(defun browse-mark-ring-next-line ()
  (interactive)
  (or browse-mark-ring-current-marks (error "not in browse mark ring mode"))
  (forward-line 1)
  (beginning-of-line))

(defun browse-mark-ring-previous-line ()
  (interactive)
  (or browse-mark-ring-current-marks (error "not in browse mark ring mode"))
  (forward-line -1)
  (beginning-of-line))

(defun browse-mark-ring-next-buffer (arg)
  (interactive "p")
  (if (>= arg 0) (setq arg 1)
    (setq arg -1))
  (beginning-of-line)
  (let* ((i (count-lines (point-min) (point)))
         (m (elt browse-mark-ring-current-marks i))
         (buffer (marker-buffer m))
         (d (catch 'loop 
              (while (and (>= i 0)
                      (< i (length browse-mark-ring-current-marks)))
                (if (eq buffer (marker-buffer (elt browse-mark-ring-current-marks i)))
                    (setq i (+ i arg))
                  (throw 'loop i)))
              'notfound)))
    (if (eq d 'notfound)
        (message "No more buffer")
      (goto-line (1+ d)))))

(defun browse-mark-ring-previous-buffer (arg)
  (interactive "p")
  (browse-mark-ring-next-buffer (* -1 arg)))


(defun browse-mark-ring-quit()
  (interactive)
  (if browse-mark-ring-current-marks
      (kill-buffer nil)
    (error "not in browse mark ring mode")))



(defun browse-mark-ring-get-buffer-line( m )
  (with-current-buffer (marker-buffer  m)
    (save-excursion
      (goto-char m)
      (let* ((beg (progn (beginning-of-line) (point)))
             (end (progn (end-of-line) (point))))
        (format "%12s %4d: %s"  
                (buffer-name (current-buffer))
                (count-lines (point-min) (marker-position m)) 
                (buffer-substring beg end))))))

(defun browse-mark-ring-mode()
  "My first mode"
  (kill-all-local-variables)
  (use-local-map browse-mark-ring-map)
  (setq major-mode 'browse-mark-ring)
  (setq mode-name "*Browse Mark Ring Mode*")
  (make-local-variable 'browse-mark-ring-current-marks)
  (make-local-variable 'next-line-add-newlines )
  (setq next-line-add-newlines nil)
  (let (buffers)
    (mapc (lambda (m) 
            (let ((buffer (marker-buffer m)))
              (and buffer
                   (add-to-list 'buffers buffer))))
          global-mark-ring)
    (mapc (lambda (buffer)
            (setq browse-mark-ring-current-marks 
                  (append browse-mark-ring-current-marks 
                          (with-current-buffer buffer mark-ring))))
          buffers))
  (erase-buffer)
  (let ((lines  (mapcar 'browse-mark-ring-get-buffer-line browse-mark-ring-current-marks)))
    (insert (mapconcat 'identity lines "\n")))
                
  (setq buffer-read-only t)
  nil)

(provide 'browse-mark-ring)
 ;;; browse-mark-ring.el ends here
