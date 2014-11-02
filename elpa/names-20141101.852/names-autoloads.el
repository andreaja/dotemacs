;;; names-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "names" "names.el" (21590 19927 0 0))
;;; Generated autoloads from names.el

(defvar names--inside-make-autoload nil "\
Used in `make-autoload' to indicate we're making autoloads.")

(autoload 'define-namespace "names" "\
Inside the namespace NAME, execute BODY.
NAME can be any symbol (not quoted), but it's highly recommended
to use some form of separator (such as :, /, or -).

This has two main effects:

1. Any definitions inside BODY will have NAME prepended to the
symbol given. Ex:
    (define-namespace foo:
    (defvar bar 1 \"docs\")
    )
expands to
    (defvar foo:bar 1 \"docs\")


2. Any function calls and variable names get NAME prepended to
them if possible. Ex:
    (define-namespace foo:
    (message \"%s\" my-var)
    )
expands to
    (foo:message \"%s\" foo:my-var)
but only if `foo:message' has a function definition. Similarly,
`my-var' becomes `foo:my-var', but only if `foo:my-var' has
a variable definition.

If `foo:message' is not a defined function, the above would
expand instead to
    (message \"%s\" foo:my-var)

===============================

AUTOLOAD

In order for `define-namespace' to work with ;;;###autoload
comments just replace all instances of ;;;###autoload inside your
`define-namespace' with `:autoload', and then add an ;;;###autoload
comment just above your `define-namespace'.

===============================

KEYWORDS

Immediately after NAME you may add keywords which customize the
behaviour of `define-namespace'. For a description of these keywords, see
the manual on
http://github.com/Bruce-Connor/names

\(fn NAME [KEYWORDS] BODY)" nil t)

(put 'define-namespace 'lisp-indent-function '(lambda (&rest x) 0))

(defadvice make-autoload (before names-before-make-autoload-advice (form file &optional expansion) activate) "\
Make sure `make-autoload' understands `define-namespace'.
Use the `names--inside-make-autoload' variable to indicate to
`define-namespace' that we're generating autoloads." (setq names--inside-make-autoload t) (when (eq (car-safe form) (quote define-namespace)) (ad-set-arg 0 (macroexpand form)) (ad-set-arg 2 (quote expansion))) (setq names--inside-make-autoload nil))

;;;***

;;;### (autoloads nil nil ("names-dev.el" "names-pkg.el") (21590
;;;;;;  19927 133893 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; names-autoloads.el ends here
