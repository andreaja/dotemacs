ELISP := $(HOME)/.emacs.d
EMACS := emacs

.PHONY: clean compile all

all: compile

clean:
	find . -name "*.elc" -delete

compile:
	$(EMACS) -batch -f batch-byte-recompile-directory $(ELISP)

