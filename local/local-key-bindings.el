;; as per http://stackoverflow.com/a/683575/25328
;; Set up a minor mode with our keybindings so they take precedence

(defvar my-keys-minor-mode-map (make-keymap) "my-keys-minor-mode keymap.")

(define-key my-keys-minor-mode-map
  (kbd "C-c c") 'comment-or-uncomment-region)

(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  t " my-keys" 'my-keys-minor-mode-map)

(define-key my-keys-minor-mode-map [(control .) (b)] 'browse-url-at-point)

;; see local-functions.el
(define-key my-keys-minor-mode-map [(control x) (control r)] 'find-file-root)
(define-key my-keys-minor-mode-map [(control .) (<)] 'spotify-previous-track)
(define-key my-keys-minor-mode-map [(control .) (control ?,)] 'spotify-previous-track)
(define-key my-keys-minor-mode-map [(control .) (>)] 'spotify-next-track)
(define-key my-keys-minor-mode-map [(control .) (control .)] 'spotify-next-track)
(define-key my-keys-minor-mode-map [(control .) (p)] 'spotify-playpause)
(define-key my-keys-minor-mode-map [(control .) (control p)] 'spotify-playpause)
(define-key my-keys-minor-mode-map [(control .) (control c)] 'spotify-now-playing)
(define-key my-keys-minor-mode-map [(control .) (c)] 'spotify-now-playing)

(define-key my-keys-minor-mode-map [(meta o)] 'other-window)

(define-key my-keys-minor-mode-map [(control .) (i)] 'indent-region)

(define-key my-keys-minor-mode-map [(control z)] 'repeat)

;; Handy key definition
(define-key my-keys-minor-mode-map (kbd "C-M-q") 'unfill-paragraph)

(js2r-add-keybindings-with-prefix "C-c C-m")

