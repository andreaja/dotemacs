ELISP := $(HOME)/.emacs.d
EMACS := emacs

COMPILE_DIRS := "$(ELISP)/elpa" "$(ELISP)/local"

# Mirror the load-path from init.el and init/loadenv.el, so local/ compiles
# against the same macros and requires it sees at runtime.
LOAD_PATH := (dolist (d (list "$(ELISP)/init" "$(ELISP)/local" "$(ELISP)/site-lisp/other" "$(ELISP)/site-lisp/hl-tags-mode")) (add-to-list (quote load-path) d))

.PHONY: clean compile all

all: compile

clean:
	find . -name "*.elc" -delete

# The 0 is load-bearing: without it byte-recompile-directory skips any .el
# that has no .elc yet, so freshly installed packages stay interpreted.
compile:
	$(EMACS) -batch --eval '(progn (package-initialize) $(LOAD_PATH) (dolist (d (list $(COMPILE_DIRS))) (byte-recompile-directory d 0)))'

