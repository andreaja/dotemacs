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

(defun get-variable-pitch-font ()
  "Return the appropriate variable-pitch font specification."
  (cond ((x-list-fonts "ETBembo")         '(:font "ETBembo"))
        ((x-list-fonts "Source Sans Pro") '(:font "Source Sans Pro"))
        ((x-list-fonts "Lucida Grande")   '(:font "Lucida Grande"))
        ((x-list-fonts "Verdana")         '(:font "Verdana"))
        ((x-family-fonts "Sans Serif")    '(:family "Sans Serif"))
        (t (warn "Cannot find a Sans Serif Font.") '(:family "Sans Serif"))))

(defun get-fixed-pitch-font ()
  "Return the appropriate fixed-pitch/monospace font specification."
  (cond ((x-list-fonts "SF Mono")       '(:font "SF Mono"))
        ((x-list-fonts "Menlo")         '(:font "Menlo"))
        ((x-list-fonts "Monaco")        '(:font "Monaco"))
        ((x-list-fonts "Courier New")   '(:font "Courier New"))
        ((x-family-fonts "Monospace")   '(:family "Monospace"))
        (t (warn "Cannot find a Monospace Font.") '(:family "Monospace"))))

(defun apply-custom-org-heading-fonts ()
  "Apply custom font family and heights to org headings."
  (let* ((variable-tuple (get-variable-pitch-font)))
    (custom-theme-set-faces
     'user
     `(org-level-8 ((t (,@variable-tuple :height 1.0))))
     `(org-level-7 ((t (,@variable-tuple :height 1.0))))
     `(org-level-6 ((t (,@variable-tuple :height 1.1))))
     `(org-level-5 ((t (,@variable-tuple :height 1.1))))
     `(org-level-4 ((t (,@variable-tuple :height 1.15))))
     `(org-level-3 ((t (,@variable-tuple :height 1.2))))
     `(org-level-2 ((t (,@variable-tuple :height 1.3))))
     `(org-level-1 ((t (,@variable-tuple :height 1.4))))
     `(org-document-title ((t (,@variable-tuple :height 2.0 :underline nil)))))))

(defun apply-custom-org-heading-colors ()
  "Apply custom color progression to org headings using Solarized palette colors.
   Uses warm-to-cool color progression: Red (warmest) → Magenta (coolest)."
  (require 'solarized-palettes)

  (let* ((headline '(:inherit default :weight bold))
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
     `(org-level-8 ((t (,@headline :foreground ,magenta-color))))
     `(org-level-7 ((t (,@headline :foreground ,violet-color))))
     `(org-level-6 ((t (,@headline :foreground ,blue-color))))
     `(org-level-5 ((t (,@headline :foreground ,cyan-color))))
     `(org-level-4 ((t (,@headline :foreground ,green-color))))
     `(org-level-3 ((t (,@headline :foreground ,yellow-color))))
     `(org-level-2 ((t (,@headline :foreground ,orange-color))))
     `(org-level-1 ((t (,@headline :foreground ,red-color))))
     `(org-document-title ((t (,@headline :foreground ,red-color)))))))

(defun apply-base-pitch-faces ()
  "Configure the base fixed-pitch and variable-pitch faces."
  (let ((mono-font (get-fixed-pitch-font))
        (variable-font (get-variable-pitch-font)))
    (set-face-attribute 'fixed-pitch nil :family (plist-get mono-font :font))
    (set-face-attribute 'variable-pitch nil :family (plist-get variable-font :font))))

(defun apply-org-mixed-pitch-faces ()
  "Configure org-mode faces to use fixed-pitch for technical elements."
  (custom-theme-set-faces
   'user
   ;; Code and verbatim blocks
   '(org-block ((t (:inherit fixed-pitch))))
   '(org-block-begin-line ((t (:inherit fixed-pitch))))
   '(org-block-end-line ((t (:inherit fixed-pitch))))
   '(org-code ((t (:inherit (fixed-pitch org-code)))))
   '(org-verbatim ((t (:inherit (fixed-pitch org-verbatim)))))

   ;; Tables and formulas (critical for alignment)
   '(org-table ((t (:inherit fixed-pitch))))
   '(org-formula ((t (:inherit (fixed-pitch org-formula)))))

   ;; Metadata and keywords
   '(org-meta-line ((t (:inherit (fixed-pitch org-meta-line)))))
   '(org-document-info-keyword ((t (:inherit (fixed-pitch org-document-info-keyword)))))
   '(org-special-keyword ((t (:inherit (fixed-pitch org-special-keyword)))))
   '(org-property-value ((t (:inherit fixed-pitch))))

   ;; Dates and tags
   '(org-date ((t (:inherit (fixed-pitch org-date)))))
   '(org-tag ((t (:inherit (fixed-pitch org-tag)))))

   ;; Checkboxes and structural elements
   '(org-checkbox ((t (:inherit (fixed-pitch org-checkbox)))))
   '(org-drawer ((t (:inherit fixed-pitch))))
   '(org-indent ((t (:inherit fixed-pitch))))))

;; Solarized setting
;; Don't change size of org-mode headlines (but keep other size-changes)
(setq solarized-scale-org-headlines nil)

(defun theme-dark ()
  (interactive)
  (load-theme 'solarized-dark-high-contrast t)
  (invisible-mode-line "#01323d") ;; dark base02
  (set-face-background 'trailing-whitespace "#62787f") ;; base01 (emphasized content)
  (apply-base-pitch-faces)            ; Set up base faces
  (apply-custom-org-heading-fonts)    ; Apply font configuration
  (apply-custom-org-heading-colors)   ; Apply color configuration
  (apply-org-mixed-pitch-faces))      ; Apply mixed-pitch faces

(defun theme-light ()
  (interactive)
  (load-theme 'solarized-light-high-contrast t)
  (invisible-mode-line "#002b37") ;; light base02
  (set-face-background 'trailing-whitespace "#5d737a") ;; base01 (emphasized content)
  (apply-base-pitch-faces)            ; Set up base faces
  (apply-custom-org-heading-fonts)    ; Apply font configuration
  (apply-custom-org-heading-colors)   ; Apply color configuration
  (apply-org-mixed-pitch-faces))      ; Apply mixed-pitch faces

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

