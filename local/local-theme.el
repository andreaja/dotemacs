(tooltip-mode -1)

;; Work around http://debbugs.gnu.org/cgi/bugreport.cgi?bug=8402
(setq ns-use-srgb-colorspace t)

;; Emoji support
(setenv "LANG" "en_GB.UTF-8")

;; font for all unicode characters
(set-fontset-font t 'unicode "Apple Color Emoji" nil 'prepend)


;; Quick emacs version of syntactic line compression, found on reddit
;; https://gist.github.com/robtillotson/5d162f9674ad9c207d44
(make-face 'mundane-line-face)
(set-face-attribute 'mundane-line-face nil :height 0.5)

(defun add-mundane-line-font-lock ()
  (setq font-lock-multiline t)
  (font-lock-add-keywords nil '(("^[ \t;`']*\n" 0 'mundane-line-face prepend))))

;;; Work around incredibly annoying bug in interaction between
;;; next-line and mundane-line-face.

;;; Symptom: every time a window isn't pixel perfectly aligned with
;;; the last lines, vscroll is triggered instead of moving the cursor
;;; when calling next-line
(setq auto-window-vscroll nil)

(add-hook 'prog-mode-hook 'add-mundane-line-font-lock)

;; Get rid of as much chrome as humanly possible
(set-scroll-bar-mode nil)
(tool-bar-mode 0)


;; Solarized
;; Don't change size of org-mode headlines (but keep other size-changes)
(setq solarized-scale-org-headlines nil)


(load-theme 'solarized-dark t)


;; Invisible mode-line, set up this after solarized so we can override the mode-line height
(setq column-number-mode t)

(setq frame-title-format '("%e" mode-line-front-space mode-line-mule-info mode-line-client mode-line-modified mode-line-remote mode-line-frame-identification mode-line-buffer-identification " "
                           "%p of %I "(:eval (format "L%d" (line-number-at-pos)))
                                        ;mode-line-position
                           (vc-mode vc-mode)
                           "  " mode-line-modes mode-line-misc-info mode-line-end-spaces))

(set-face-attribute 'mode-line nil
                    :overline nil
                    :underline nil
                    :height 0.1)
(set-face-attribute 'mode-line-inactive nil
                    :overline nil
                    :underline nil
                    :background "#073642"
                    :height 0.1)

(setq-default mode-line-format "")

;; Flag trailing white
(show-paren-mode t)
(setq-default show-trailing-whitespace t)
(set-face-background 'trailing-whitespace "#586e75")


