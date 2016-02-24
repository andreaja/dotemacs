(setq inhibit-startup-message t)
(tooltip-mode -1)
(show-paren-mode t)
(tool-bar-mode 0)

;; Prettify
(setq prettify-symbols-unprettify-at-point 'right-edge)
(global-prettify-symbols-mode 1)

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

;; Flag trailing white
(setq-default show-trailing-whitespace t)


;; Invisible mode-line, set up this after solarized so we can override the mode-line height
(setq column-number-mode t)

(setq frame-title-format '("%e"
                                        ;mode-line-front-space
                                        ;mode-line-mule-info
                                        ;mode-line-client
                           mode-line-modified
                                        ;mode-line-remote
                                        ;mode-line-frame-identification
                           mode-line-buffer-identification
                           " "
                                        ;"%p of %I "
                           (:eval (format "L%d" (line-number-at-pos)))
                                        ;mode-line-position
                                        ;(vc-mode vc-mode)
                           " " mode-line-modes mode-line-misc-info mode-line-end-spaces))

(defun invisible-mode-line (base02)
  (set-face-attribute 'mode-line nil
                      :overline nil
                      :underline nil
                      :height 0.1)
  (set-face-attribute 'mode-line-inactive nil
                      :overline nil
                      :underline nil
                      :background base02
                      :height 0.1)
  (setq-default mode-line-format ""))

;; Solarized setting
;; Don't change size of org-mode headlines (but keep other size-changes)
(setq solarized-scale-org-headlines nil)

(defun theme-dark ()
  (interactive)
  (load-theme 'solarized-dark t)
  (invisible-mode-line "#073642") ;; dark base02
  (set-face-background 'trailing-whitespace "#586e75") ;; base01 (emphasized content)
  )

(defun theme-light ()
  (interactive)
  (load-theme 'solarized-light t)
  (invisible-mode-line "#eee8d5") ;; light base02
  (set-face-background 'trailing-whitespace "#93a1a1") ;; base01 (emphasized content)
  )

;; default theme
(theme-dark)

;; diminish

                                        ;(require 'diminish)
(eval-after-load "yasnippet" '(diminish 'yas-minor-mode))
(eval-after-load "paredit" '(diminish 'paredit-mode))
(eval-after-load "rainbow-mode" '(diminish 'rainbow-mode))
(eval-after-load "projectile" '(diminish 'projectile-mode))
(eval-after-load "with-editor" '(diminish 'with-editor-mode))
(eval-after-load "aggressive-indent" '(diminish 'aggressive-indent-mode))
(eval-after-load "ggtags" '(diminish 'ggtags-mode))
(eval-after-load "flycheck" '(diminish 'flycheck-mode))
(eval-after-load "hungry-delete" '(diminish 'hungry-delete-mode))
(eval-after-load "abbrev" '(diminish 'abbrev-mode))
(eval-after-load "autorevert" '(diminish 'auto-revert-mode))
(eval-after-load "subword" '(diminish 'subword-mode))
(diminish 'auto-fill-function)

;; From http://whattheemacsd.com/appearance.el-01.html
(defmacro rename-modeline (package-name mode new-name)
  `(eval-after-load ,package-name
     '(defadvice ,mode (after rename-modeline activate)
        (setq mode-name ,new-name))))

(rename-modeline "js2-mode" js2-mode "JS2")
(rename-modeline "cc-mode" java-mode "Java")
;; https://gist.github.com/sellout/18fabd242d7ab57c5094
(rename-modeline "perl-mode" perl-mode "🐪")
(rename-modeline "python-mode" python-mode "🐍")
(rename-modeline "ruby-mode" ruby-mode "💎")
(rename-modeline "elisp-mode" emacs-lisp-mode "👾")

;; https://gist.github.com/takaxp/1626603
(defvar my-narrow-display " ∥")
(setq mode-line-modes
      (mapcar (lambda (entry)
		(if (and (stringp entry)
			 (string= entry "%n"))
		    '(:eval (if (and (= 1 (point-min))
                                     (= (1+ (buffer-size)) (point-max))) ""
                              my-narrow-display)) entry))
	      mode-line-modes))

