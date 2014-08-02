Emacs minor mode to highlight mark(s).

Allows setting the number of marks to display, and the faces to display them.

Example installation:

1. Put this file in Emacs's load-path

2. add custom faces to init file
(require 'visible-mark)
(global-visible-mark-mode 1) ;; or add (visible-mark-mode) to specific hooks

3. Add customizations. The defaults are very minimal. They could also be set
via customize.

(defface visible-mark-active ;; put this before (require 'visible-mark)
  '((((type tty) (class mono)))
    (t (:background "magenta"))) "")
(setq visible-mark-max 2)
(setq visible-mark-faces `(visible-mark-face1 my-visible-mark-face2))


Additional useful functions like unpoping the mark are at
http://www.emacswiki.org/emacs/MarkCommands
and http://www.emacswiki.org/emacs/VisibleMark

Pre-git history:

2008-02-21  MATSUYAMA Tomohiro <t.matsuyama.pub@gmail.com>

     * visible-mark.el: Added function to inhibit trailing overlay.

2008-01-31  MATSUYAMA Tomohiro <t.matsuyama.pub@gmail.com>

     * visible-mark.el: Create formal emacs lisp file from
       http://www.emacswiki.org/cgi-bin/wiki/VisibleMark.
       Yann Hodique and Jorgen Schäfer are original authors.
       Added function to make multiple marks visible.


Known bugs

Observed in circe, when the buffer has a right margin, and there
is a mark at the beginning of a line, any text in the margin on that line
gets styled with the mark's face. May also happen for left margins, but
haven't tested yet.

Patches / pull requests welcome.
