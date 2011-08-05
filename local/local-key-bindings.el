(global-set-key [C-tab] 'other-window)
(global-set-key (kbd "C-c c") 'comment-region)
(global-set-key (kbd "C-c u") 'uncomment-region)

(global-set-key [(control .) (b)] 'browse-url-at-point)

;; see local-functions.el
(global-set-key [(control x) (control r)] 'find-file-root)
(global-set-key [(control .) (<)] 'spotify-previous-track)
(global-set-key [(control .) "C-,"] 'spotify-previous-track)
(global-set-key [(control .) (>)] 'spotify-next-track)
(global-set-key [(control .) (control .)] 'spotify-next-track)
(global-set-key [(control .) (p)] 'spotify-playpause)
(global-set-key [(control .) (control p)] 'spotify-playpause)
(global-set-key [(control .) (control c)] 'spotify-now-playing)
(global-set-key [(control .) (c)] 'spotify-now-playing)


