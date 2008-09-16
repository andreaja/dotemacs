;; emacs-rails
;; http://dima-exe.ru/rails-on-emacs
(require 'inf-ruby)
(require 'snippet)
(require 'find-recursive)
(require 'rails)

;; Add some ruby mode hooks
;; from this guy: http://github.com/nkpart/dotfiles/tree/master/.emacs

(dolist (mode-cons '(("\\.rake$" . ruby-mode)
                     ("rakefile$" . ruby-mode)
     ("buildfile$" . ruby-mode)
     ("Buildfile$" . ruby-mode)
                     ("Rakefile$" . ruby-mode)))
  (add-to-list ' auto-mode-alist mode-cons))

