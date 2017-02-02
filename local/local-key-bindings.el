;; as per http://stackoverflow.com/a/683575/25328
;; Set up a minor mode with our keybindings so they take precedence

(defvar my-keys-minor-mode-map (make-keymap) "my-keys-minor-mode keymap.")

(define-key my-keys-minor-mode-map
  (kbd "C-c c") 'comment-or-uncomment-region)

(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  t "" 'my-keys-minor-mode-map)

(define-key my-keys-minor-mode-map [(control .) (b)] 'browse-dwim)
(define-key my-keys-minor-mode-map [(control .) (control b)] 'browse-dwim)

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

(setq avy-keys
      '(?h ?t ?n ?s ?g ?c ?r ?l))
(setq aw-keys '(?h ?t ?n ?s ?g ?c ?r))

(define-key my-keys-minor-mode-map [(meta o)] 'ace-window)
(define-key my-keys-minor-mode-map [(meta s)] 'avy-goto-word-1)


(define-key my-keys-minor-mode-map [(control z)] 'repeat)

;; smex
(define-key my-keys-minor-mode-map [(meta x)] 'smex)
(define-key my-keys-minor-mode-map [(meta shift x) ()] 'smex-major-mode-commands)
;; This is your old M-x.
(define-key my-keys-minor-mode-map [(control .) (meta x)] 'execute-extended-command)

(js2r-add-keybindings-with-prefix "C-c C-m")

(define-key projectile-mode-map [(control c) (p) (g)] 'projectile-grep)

(define-key my-keys-minor-mode-map [(meta \`)] 'other-frame)

(define-key my-keys-minor-mode-map [(control .) (control m)] 'magit-status)
(define-key my-keys-minor-mode-map [(control .) (m)] 'magit-status)

(define-key my-keys-minor-mode-map [(control .) (control t)] 'org-todo)
(define-key my-keys-minor-mode-map [(control .) (control a)] 'org-agenda)
(define-key my-keys-minor-mode-map [(control .) (t)] 'org-todo)

(define-key flycheck-mode-map [(control meta n)] 'flycheck-next-error)
(define-key flycheck-mode-map [(control meta p)] 'flycheck-previous-error)
(define-key my-keys-minor-mode-map [(meta n)] 'smartscan-symbol-go-forward)
(define-key my-keys-minor-mode-map [(meta p)] 'smartscan-symbol-go-backward)
(define-key my-keys-minor-mode-map [(meta r)] 'smartscan-symbol-replace)

(define-key my-keys-minor-mode-map [(control meta \ )] 'er/expand-region)

(define-key my-keys-minor-mode-map [(control x) (control k)] 'kill-current-buffer)
(define-key my-keys-minor-mode-map [(control .) (control s)] 'insert-shebang)

(define-key my-keys-minor-mode-map [(control .) (control i)] 'idomenu)

(define-key my-keys-minor-mode-map [(meta h)] 'ns-do-hide-emacs)

(define-key my-keys-minor-mode-map [(control .) (control n)] 'org-capture)
(define-key my-keys-minor-mode-map [(control .) (n)] 'org-capture)

(add-hook 'org-mode-hook
          (lambda ()
            (define-key org-mode-map [remap browse-url-at-point] 'org-open-at-point)
            (define-key org-mode-map (kbd "C-c C-4") 'org-archive-subtree)
            (define-key org-mode-map [S-left]
              (lambda () (interactive) (message "Use org-todo instead")))
            (define-key org-mode-map [S-right]
              (lambda () (interactive) (message "Use org-todo instead")))))

(add-hook 'org-agenda-mode-hook
          (lambda ()
            (define-key org-agenda-mode-map [remap org-agenda-switch-to] 'org-agenda-goto)))








