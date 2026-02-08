(setq inhibit-startup-message t)
(tooltip-mode -1)
(show-paren-mode t)

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

;; get rid of the title-bar
(setq default-frame-alist '((undecorated . t)))

;; Get rid of as much chrome as humanly possible
(set-scroll-bar-mode nil)
(tool-bar-mode 0)

;; Flag trailing white
(setq-default show-trailing-whitespace t)


;; Invisible mode-line, set up this after solarized so we can override the mode-line height
(setq column-number-mode t)

(defvar window-mode-line-stuff '("%e"
                                        ;mode-line-front-space
                                        ;mode-line-mule-info
                                        ;mode-line-client
                                 mode-line-modified
                                        ;mode-line-remote
                                        ;mode-line-frame-identification
                                 mode-line-buffer-identification
                                 " "
                                        ;"%p of %I "
                                 (:eval (format "L%d" (string-to-number (format-mode-line "%l"))))
                                 " "
                                 (:eval (format "C%d" (string-to-number (format-mode-line "%c"))))
                                        ;mode-line-position
                                        ;(vc-mode vc-mode)
                                 " " mode-line-modes mode-line-misc-info mode-line-end-spaces))

(setq frame-title-format window-mode-line-stuff)

(defun disply-window-mode-line-in-echo ()
  (interactive)
  (message "%s" (format-mode-line window-mode-line-stuff)))

(add-function :after (symbol-function #'recenter-top-bottom) #'disply-window-mode-line-in-echo)

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

(defun apply-custom-org-heading-styles ()
  "Apply custom font and height to org headings using Solarized palette colors.
   Uses warm-to-cool color progression: Red (warmest) → Magenta (coolest)."
  (require 'solarized-palettes)

  (let* ((variable-tuple
          (cond ((x-list-fonts "ETBembo")         '(:font "ETBembo"))
                ((x-list-fonts "Source Sans Pro") '(:font "Source Sans Pro"))
                ((x-list-fonts "Lucida Grande")   '(:font "Lucida Grande"))
                ((x-list-fonts "Verdana")         '(:font "Verdana"))
                ((x-family-fonts "Sans Serif")    '(:family "Sans Serif"))
                (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro."))))
         (base-font-color (face-foreground 'default nil 'default))
         (headline        '(:inherit default :weight bold))
         ;; Detect current theme variant
         (current-theme (car custom-enabled-themes))
         (is-dark (or (eq current-theme 'solarized-dark)
                      (eq current-theme 'solarized-dark-high-contrast)))
         ;; Get the appropriate palette
         (palette (if is-dark
                      solarized-dark-high-contrast-palette-alist
                    solarized-light-high-contrast-palette-alist))
         ;; Extract all 8 accent colors from palette (warm to cool)
         (red-color     (cdr (assoc 'red palette)))
         (orange-color  (cdr (assoc 'orange palette)))
         (yellow-color  (cdr (assoc 'yellow palette)))
         (green-color   (cdr (assoc 'green palette)))
         (cyan-color    (cdr (assoc 'cyan palette)))
         (blue-color    (cdr (assoc 'blue palette)))
         (violet-color  (cdr (assoc 'violet palette)))
         (magenta-color (cdr (assoc 'magenta palette))))

    (custom-theme-set-faces
     'user
     ;; Warm to Cool: Red → Orange → Yellow → Green → Cyan → Blue → Violet → Magenta
     `(org-level-8 ((t (,@headline ,@variable-tuple :foreground ,magenta-color))))
     `(org-level-7 ((t (,@headline ,@variable-tuple :foreground ,violet-color))))
     `(org-level-6 ((t (,@headline ,@variable-tuple :foreground ,blue-color))))
     `(org-level-5 ((t (,@headline ,@variable-tuple :foreground ,cyan-color :height 1.01))))
     `(org-level-4 ((t (,@headline ,@variable-tuple :foreground ,green-color :height 1.02))))
     `(org-level-3 ((t (,@headline ,@variable-tuple :foreground ,yellow-color :height 1.05))))
     `(org-level-2 ((t (,@headline ,@variable-tuple :foreground ,orange-color :height 1.1))))
     `(org-level-1 ((t (,@headline ,@variable-tuple :foreground ,red-color :height 1))))
     `(org-document-title ((t (,@headline ,@variable-tuple :foreground ,red-color :height 2.0 :underline nil)))))))


;; Solarized setting
;; Don't change size of org-mode headlines (but keep other size-changes)
(setq solarized-scale-org-headlines nil)

(defun theme-dark ()
  (interactive)
  (load-theme 'solarized-dark-high-contrast t)
  (invisible-mode-line "#01323d") ;; dark base02
  (set-face-background 'trailing-whitespace "#62787f") ;; base01 (emphasized content)
  (apply-custom-org-heading-styles))  ; Apply after theme loads

(defun theme-light ()
  (interactive)
  (load-theme 'solarized-light-high-contrast t)
  (invisible-mode-line "#002b37") ;; light base02
  (set-face-background 'trailing-whitespace "#5d737a") ;; base01 (emphasized content)
  (apply-custom-org-heading-styles))  ; Apply after theme loads

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

(defun org-mode-prettify-symbols ()
  (setq prettify-symbols-alist
        '(("->" . ?→)
          ("=>" . ?⇒)
          ("lambda" . ?λ)
          ("<=" . ?≤)
          (">=" . ?≥)))
  (prettify-symbols-mode 1))

(add-hook 'org-mode-hook #'org-mode-prettify-symbols)

