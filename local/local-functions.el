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
"))

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

(defun spotify-current-position ()
  "DOCSTRING"
  (do-applescript "
    tell application \"Spotify\"
        get player position as integer
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
