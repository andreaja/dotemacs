;;; malabar-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads nil "malabar-ede-gradle" "malabar-ede-gradle.el"
;;;;;;  (21936 50332 0 0))
;;; Generated autoloads from malabar-ede-gradle.el

(eieio-defclass-autoload 'ede-malabar-gradle-project '(ede-maven2-project) "malabar-ede-gradle" "Project Type for Gradle based Java projects.")

;;;***

;;;### (autoloads nil "malabar-ede-maven" "malabar-ede-maven.el"
;;;;;;  (21936 50332 0 0))
;;; Generated autoloads from malabar-ede-maven.el

(eieio-defclass-autoload 'malabar-ede-maven2-project '(ede-maven2-project) "malabar-ede-maven" "Project Type for Maven2 based Java projects.")

(autoload 'malabar-ede-maven2-load "malabar-ede-maven" "\
Return a Maven Project object if there is a match.
 Return nil if there isn't one.
 Argument DIR is the directory it is created for.
 ROOTPROJ is nil, since there is only one project.

\(fn DIR &optional ROOTPROJ)" nil nil)

;;;***

;;;### (autoloads nil "malabar-mode" "malabar-mode.el" (21936 50332
;;;;;;  0 0))
;;; Generated autoloads from malabar-mode.el

(autoload 'malabar-http-compile-file "malabar-mode" "\
Compile the current buffer.  If there are errors open them up into a list-buffer

\(fn &optional BUFFER)" t nil)

(autoload 'malabar-mode "malabar-mode" "\
Support and integeration for JVM languages

When called interactively, toggle `malabar-mode'.  With prefix
ARG, enable `malabar-mode' if ARG is positive, otherwise disable
it.

When called from Lisp, enable `malabar-mode' if ARG is omitted,
nil or positive.  If ARG is `toggle', toggle `malabar-mode'.
Otherwise behave as if called interactively.

\\{malabar-mode-map}

\(fn &optional ARG)" t nil)

(autoload 'malabar-java-mode "malabar-mode" "\
Java specfic minor mode for JVM languages.

When called interactively, toggle `malabar-java-mode'.  With prefix
ARG, enable `malabar-java-mode' if ARG is positive, otherwise disable
it.

When called from Lisp, enable `malabar-java-mode' if ARG is omitted,
nil or positive.  If ARG is `toggle', toggle `malabar-java-mode'.
Otherwise behave as if called interactively.

\\{malabar-mode-map}

\(fn &optional ARG)" t nil)

(autoload 'malabar-groovy-mode "malabar-mode" "\
Groovy specfic minor mode for JVM languages.

When called interactively, toggle `malabar-groovy-mode'.  With prefix
ARG, enable `malabar-groovy-mode' if ARG is positive, otherwise disable
it.

When called from Lisp, enable `malabar-groovy-mode' if ARG is omitted,
nil or positive.  If ARG is `toggle', toggle `malabar-groovy-mode'.
Otherwise behave as if called interactively.

\\{malabar-mode-map}

\(fn &optional ARG)" t nil)

(autoload 'activate-malabar-mode "malabar-mode" "\
Add hooks to the java and groovy modes to activate malabar mode.  Good for calling in .emacs

\(fn)" t nil)

;;;***

;;;### (autoloads nil "malabar-project" "malabar-project.el" (21936
;;;;;;  50332 0 0))
;;; Generated autoloads from malabar-project.el

(autoload 'malabar-project-resources "malabar-project" "\
SCOPE is either 'test or 'runtime

\(fn PROJECT-INFO SCOPE)" t nil)

(autoload 'malabar-project-sources "malabar-project" "\
SCOPE is either 'test or 'runtime

\(fn PROJECT-INFO SCOPE)" t nil)

(autoload 'malabar-install-project "malabar-project" "\
Runs 'mvn install' on the current project.  With prefix
argument, cleans the project first ('mvn clean install').

\(fn CLEAN-P)" t nil)

(autoload 'malabar-package-project "malabar-project" "\
Runs 'mvn package' on the current project.  With prefix
argument, cleans the project first ('mvn clean package').

\(fn CLEAN-P)" t nil)

(autoload 'malabar-run-maven-command "malabar-project" "\
Prompts for and executes an (almost) arbitrary Maven command line.
Honors profile activation, property definitions and lifecycle
phases/goals.  E.g.: ``-DskipTests=true -Pdev-mode install`` will
run the install lifecycle with the dev-mode profile active,
skipping tests.

\(fn COMMAND-LINE)" t nil)

;;;***

;;;### (autoloads nil "malabar-http" "malabar-http.el" (21936 50332
;;;;;;  0 0))
;;; Generated autoloads from malabar-http.el

(autoload 'malabar-http-call "malabar-http" "\
SERVICE is a known service to the malabat server 

   ARGS-PLIST is a list of '(key val key val ...). If pm is not
  in the list, is is pulled from buffer.  Skip entries with a nil key or value

  ARRAY-TYPE is for the JSON reader and can be 'list or 'vector.  Default to vector.

  OBJECT-TYPE is for the JSON reader and can be `alist', `plist',
  or `hash-table'.  Default to `alist'.

  READTABLE is the JSON readtable, default to `json-reatable'.

\(fn SERVICE ARGS-PLIST &optional BUFFER ARRAY-TYPE OBJECT-TYPE READTABLE)" nil nil)

;;;***

;;;### (autoloads nil nil ("malabar-abbrevs.el" "malabar-import.el"
;;;;;;  "malabar-mode-pkg.el" "malabar-reflection.el" "malabar-semanticdb.el"
;;;;;;  "malabar-util.el" "malabar-variables.el") (21936 50332 743394
;;;;;;  0))

;;;***

(provide 'malabar-mode-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; malabar-mode-autoloads.el ends here
