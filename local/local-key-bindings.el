;; as per http://stackoverflow.com/a/683575/25328
;; Set up a minor mode with our keybindings so they take precedence

(defvar my-keys-minor-mode-map (make-keymap) "my-keys-minor-mode keymap.")

(define-key my-keys-minor-mode-map
  (kbd "C-c c") 'comment-or-uncomment-region)

(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  t " my-keys" 'my-keys-minor-mode-map)

(define-key my-keys-minor-mode-map [(control .) (b)] 'browse-current-buffer)
(define-key my-keys-minor-mode-map [(control .) (control b)] 'browse-current-buffer)
(define-key my-keys-minor-mode-map [(control .) (control l)] 'post-current-kill-to-slack)

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

(define-key my-keys-minor-mode-map [(control .) (i)] 'indent-region-or-buffer)

(define-key my-keys-minor-mode-map [(control z)] 'repeat)

;; smex
(define-key my-keys-minor-mode-map [(meta x)] 'smex)
(define-key my-keys-minor-mode-map [(meta shift x) ()] 'smex-major-mode-commands)
;; This is your old M-x.
(define-key my-keys-minor-mode-map [(control c) (control c) (meta x)] 'execute-extended-command)


;; Handy key definition
(define-key my-keys-minor-mode-map (kbd "C-M-q") 'unfill-paragraph)

(js2r-add-keybindings-with-prefix "C-c C-m")

(define-key flycheck-mode-map [(meta n)] 'flycheck-next-error)
(define-key flycheck-mode-map [(meta p)] 'flycheck-previous-error)

(define-key projectile-mode-map [(control c) (p) (g)] 'projectile-grep)

(define-key my-keys-minor-mode-map [(meta \`)] 'other-frame)

(define-key my-keys-minor-mode-map [(control .) (control m)] 'magit-status)
(define-key my-keys-minor-mode-map [(control .) (m)] 'magit-status)

(define-key my-keys-minor-mode-map [(control .) (control t)] 'org-todo)
(define-key my-keys-minor-mode-map [(control .) (control a)] 'org-agenda)
(define-key my-keys-minor-mode-map [(control .) (t)] 'org-todo)

(define-key my-keys-minor-mode-map [(control meta n)] 'smartscan-symbol-go-forward)

(define-key my-keys-minor-mode-map [(control meta p)] 'smartscan-symbol-go-backward)
(define-key my-keys-minor-mode-map [(meta r)] 'smartscan-symbol-replace)
(define-key my-keys-minor-mode-map [(control meta \\)] 'indent-region-or-buffer)
(define-key my-keys-minor-mode-map [(control meta \ )] 'er/expand-region)

(define-key my-keys-minor-mode-map [(control x) (control k)] 'kill-current-buffer)
(define-key my-keys-minor-mode-map [(control .) (control s)] 'insert-shebang)

(define-key my-keys-minor-mode-map [(control .) (control i)] 'ido-imenu)

(define-key my-keys-minor-mode-map [(meta h)] 'ns-do-hide-emacs)

(define-key my-keys-minor-mode-map [remap move-end-of-line] 'end-of-code-or-end-of-next-line)


(define-key my-keys-minor-mode-map [(control .) (control n)] 'org-capture)
(define-key my-keys-minor-mode-map [(control .) (n)] 'org-capture)


;; example of binding keys only when html-mode is active
;; http://ergoemacs.org/emacs/emacs_set_keys_for_major_mode.html

(defun my-html-mode-keys ()
  "Modify keymaps used by `html-mode'."
  (local-set-key [(control c) (control f)] 'sgml-close-tag)
  )

;; add to hook
(add-hook 'html-mode-hook 'my-html-mode-keys)


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

(define-key my-keys-minor-mode-map [(meta y)] 'yank-pop-dwim)







