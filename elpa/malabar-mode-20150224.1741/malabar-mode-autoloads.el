;;; malabar-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads nil "malabar-ede-maven" "malabar-ede-maven.el"
;;;;;;  (21756 19190 0 0))
;;; Generated autoloads from malabar-ede-maven.el

(eieio-defclass-autoload 'ede-malabar-maven2-project '(ede-maven2-project) "malabar-ede-maven" "Project Type for Maven2 based Java projects.")

;;;***

;;;### (autoloads nil "malabar-mode" "malabar-mode.el" (21756 19190
;;;;;;  0 0))
;;; Generated autoloads from malabar-mode.el

(autoload 'malabar-compile-file "malabar-mode" "\
Compile the current buffer.  If there are errors open them up into a list-buffer

\(fn &optional BUFFER)" t nil)

(autoload 'malabar-mode "malabar-mode" "\
Support and integeration for JVM languages

\(fn &optional ARG)" t nil)

(autoload 'malabar-java-mode "malabar-mode" "\
Java specfic minor mode for JVM languages

\(fn &optional ARG)" t nil)

(autoload 'malabar-groovy-mode "malabar-mode" "\
Groovy specfic minor mode for JVM languages

\(fn &optional ARG)" t nil)

(autoload 'activate-malabar-mode "malabar-mode" "\
Add hooks to the java and groovy modes to activate malabar mode.  Good for calling in .emacs

\(fn)" t nil)

;;;***

;;;### (autoloads nil "malabar-project" "malabar-project.el" (21756
;;;;;;  19190 0 0))
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

;;;### (autoloads nil "malabar-service" "malabar-service.el" (21756
;;;;;;  19190 0 0))
;;; Generated autoloads from malabar-service.el

(autoload 'malabar-service-call "malabar-service" "\
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
;;;;;;  "malabar-util.el" "malabar-variables.el") (21756 19190 515601
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
