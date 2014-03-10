(global-set-key [C-tab] 'other-window)
(global-set-key (kbd "C-c c") 'comment-or-uncomment-region)
(global-set-key (kbd "C-c u") 'uncomment-region)

(global-set-key [(control .) (b)] 'browse-url-at-point)

;; see local-functions.el
(global-set-key [(control x) (control r)] 'find-file-root)
(global-set-key [(control .) (<)] 'spotify-previous-track)
(global-set-key [(control .) (control ?,)] 'spotify-previous-track)
(global-set-key [(control .) (>)] 'spotify-next-track)
(global-set-key [(control .) (control .)] 'spotify-next-track)
(global-set-key [(control .) (p)] 'spotify-playpause)
(global-set-key [(control .) (control p)] 'spotify-playpause)
(global-set-key [(control .) (control c)] 'spotify-now-playing)
(global-set-key [(control .) (c)] 'spotify-now-playing)

(global-set-key [(meta o)] 'other-window)


(global-set-key [(control .) (i)] 'indent-region)

;; local keybindings
(add-hook 'clojure-mode-hook
 (lambda ()
 (local-set-key (kbd "C-c C-j") 'clojure-jack-in)
 (local-set-key (kbd "C-c j") 'clojure-jack-in)
 )
)


;; Handy key definition
(global-set-key (kbd "C-M-q") 'unfill-paragraph)
