;; Sudo shell for tramp, use C-x C-r to sudo find-file
;; refactor this out obivously
;; from here: http://www.emacswiki.org/cgi-bin/wiki/TrampMode
(defvar find-file-root-prefix (if (featurep 'xemacs) "/[sudo/root@localhost]" "/sudo:root@localhost:" )
  "*The filename prefix used to open a file with `find-file-root'.")

(defvar find-file-root-history nil
  "History list for files found using `find-file-root'.")

(defvar find-file-root-hook nil
  "Normal hook for functions to run after finding a \"root\" file.")

(defun find-file-root ()
  "*Open a file as the root user.
   Prepends `find-file-root-prefix' to the selected file name so that it
   maybe accessed via the corresponding tramp method."
  (interactive)
  (require 'tramp)
  (let* ( ;; We bind the variable `file-name-history' locally so we can
   	 ;; use a separate history list for "root" files.
   	 (file-name-history find-file-root-history)
   	 (name (or buffer-file-name default-directory))
   	 (tramp (and (tramp-tramp-file-p name)
   		     (tramp-dissect-file-name name)))
   	 path dir file)

    ;; If called from a "root" file, we need to fix up the path.
    (when tramp
      (setq path (tramp-file-name-path tramp)
   	    dir (file-name-directory path)))

    (when (setq file (read-file-name "Find file (UID = 0): " dir path))
      (find-file (concat find-file-root-prefix file))
      ;; If this all succeeded save our new history list.
      (setq find-file-root-history file-name-history)
      ;; allow some user customization
      (run-hooks 'find-file-root-hook))))


;; Launch a static web server in the current project root
(defun http-server-in-project ()
  (interactive)
  (let
      ((port (+ 1024 (random 30000))))
    (elnode-make-webserver (projectile-project-root) port)
    port))

;; Launch a static web server in the current project root
;; and browse to the file currently open
(defun browse-current-buffer ()
  (interactive)
  (let ((port (http-server-in-project))
        (relative-path  (file-relative-name (file-truename (buffer-file-name (current-buffer))) (projectile-project-root))))
    (browse-url (format "http://localhost:%d/%s" port relative-path))))

(require 'url-util)
(defun browse-dwim ()
  (interactive)
  (let ((url (url-get-url-at-point)))
    (if (s-blank? url)
        (browse-current-buffer)
      (browse-url url))))

(defun spotify-player-state ()
  "DOCSTRING"
  (do-applescript
   "tell application \"Spotify\"
        get player state as string
    end tell"
   ))

(defun spotify-playpause ()
  "plays or pauses Spotify (if running)"
  (interactive)
  (message (do-applescript "
tell application \"System Events\"
	set MyList to (name of every process)
end tell
if (MyList contains \"Spotify\") is false then
  open location \"spotify:user:andreaja:playlist:1bLf5DCoItO8RfXD1pxaWi\"
end if
tell application \"Spotify\"
    playpause
    get player state as string
end tell
")
           ))

(defun spotify-next-track ()
  "Tells spotify to advance play to the next track"
  (interactive)
  (do-applescript "
tell application \"System Events\"
	set MyList to (name of every process)
end tell
if (MyList contains \"Spotify\") is true then
	tell application \"Spotify\" to next track
end if
")
   (spotify-now-playing))

(defun spotify-previous-track ()
  "Tells spotify to revert play to the previous track"
  (interactive)
  (do-applescript "
tell application \"System Events\"
	set MyList to (name of every process)
end tell
if (MyList contains \"Spotify\") is true then
	tell application \"Spotify\" to previous track
end if
"))

(defun spotify-current-track ()
  "DOCSTRING"
  (do-applescript "
    tell application \"Spotify\"
	get properties
	set MyPos to player position as integer
	tell current track
		artist & \" - \" & name
        end tell
    end tell"))

(defun spotify-current-track-length ()
  "DOCSTRING"
  (do-applescript "
    tell application \"Spotify\"
	tell current track
            duration
        end tell
    end tell"))

(defun spotify-now-playing ()
  "DOCSTRING"
  (interactive)
  (let ((pos (spotify-current-position))
        (len (spotify-current-track-length)))
    (message (format "Now playing: %s (%02d:%02d/%02d:%02d)"
                     (spotify-current-track)
                     (/ pos 60)
                     (% pos 60)
                     (/ len 60)
                     (% len 60)))))

(defun spotify-current-position ()
  "DOCSTRING"
  (do-applescript "
    tell application \"Spotify\"
        get player position as integer
    end tell"))

;; From: http://stackoverflow.com/questions/12492/pretty-printing-xml-files-on-emacs
(defun andreaja/pretty-print-xml-region (begin end)
  "Pretty format XML markup in region. You need to have nxml-mode
http://www.emacswiki.org/cgi-bin/wiki/NxmlMode installed to do
this.  The function inserts linebreaks to separate tags that have
nothing but whitespace between them.  It then indents the markup
by using nxml's indentation rules."
  (interactive "r")
  (save-excursion
    (goto-char begin)
    (while (search-forward-regexp "\>[ \\t]*\<" nil t)
      (backward-char) (insert "\n"))
    (indent-region begin end))
  (message "Ah, much better!"))

;;http://endlessparentheses.com/super-smart-capitalization.html

(defun endless/convert-punctuation (rg rp)
  "Look for regexp RG around point, and replace with RP.
Only applies to text-mode."
  (let ((f "\\(%s\\)\\(%s\\)")
        (space "?:[[:blank:]\n\r]*"))
    ;; We obviously don't want to do this in prog-mode.
    (if (and (derived-mode-p 'text-mode)
             (or (looking-at (format f space rg))
                 (looking-back (format f rg space))))
        (replace-match rp nil nil nil 1))))

(defun endless/capitalize ()
  "Capitalize region or word.
Also converts commas to full stops, and kills
extraneous space at beginning of line."
  (interactive)
  (endless/convert-punctuation "," ".")
  (if (use-region-p)
      (call-interactively 'capitalize-region)
    ;; A single space at the start of a line:
    (when (looking-at "^\\s-\\b")
      ;; get rid of it!
      (delete-char 1))
    (call-interactively 'subword-capitalize)))

(defun endless/downcase ()
  "Downcase region or word.
Also converts full stops to commas."
  (interactive)
  (endless/convert-punctuation "\\." ",")
  (if (use-region-p)
      (call-interactively 'downcase-region)
    (call-interactively 'subword-downcase)))

(defun endless/upcase ()
  "Upcase region or word."
  (interactive)
  (if (use-region-p)
      (call-interactively 'upcase-region)
    (call-interactively 'subword-upcase)))

;; sensible version of this: http://stackoverflow.com/a/5340797/25328
(defun reload-my-keys ()
  "Ensures my-keys-mode is last in minor-mode-map so it takes precedence"
  (interactive)
  (if (not (eq (car (car minor-mode-map-alist)) 'my-keys-minor-mode))
      (let ((mykeys (assq 'my-keys-minor-mode minor-mode-map-alist)))
        (assq-delete-all 'my-keys-minor-mode minor-mode-map-alist)
        (add-to-list 'minor-mode-map-alist mykeys))))

(defun kill-current-buffer ()
  "Kills the current buffer"
  (interactive)
  (kill-buffer (current-buffer)))

;; From http://ergoemacs.org/emacs/elisp_read_file_content.html
(defun read-lines (filePath)
  "Return a list of lines of a file at filePath."
  (with-temp-buffer
    (insert-file-contents filePath)
    (split-string (buffer-string) "\n" t)))

;; http://mbork.pl/2017-02-26_other-window-or-switch-buffer
(defun ace-window-or-switch-buffer ()
  "Call `ace-window' if more than one window is visible, switch
to next buffer otherwise."
  (interactive)
  (if (one-window-p)
      (switch-to-buffer nil)
    (ace-window 1)))


;; http://emacsredux.com/blog/2013/05/22/smarter-navigation-to-the-beginning-of-a-line/
(defun smarter-move-beginning-of-line (arg)
  "Move point back to indentation of beginning of line.

Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line.
Effectively toggle between the first non-whitespace character and
the beginning of the line.

If ARG is not nil or 1, move forward ARG - 1 lines first.  If
point reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))

  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))
