;;; init.el -*- lexical-binding: t; -*-

(doom!

:completion
company           ; the ultimate code completion backend
ivy               ; a search engine for love and life

:ui
doom              ; what makes DOOM look the way it does
doom-dashboard    ; a nifty splash screen for Emacs
doom-quit         ; DOOM quit-message prompts when you quit Emacs
fill-column       ; a `fill-column' indicator
hl-todo           ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
(modeline +light)          ; snazzy, Atom-inspired modeline, plus API

nav-flash         ; blink cursor line after big motions
ophints           ; highlight the region an operation acts on
(popup +defaults)   ; tame sudden yet inevitable temporary windows
vi-tilde-fringe   ; fringe tildes to mark beyond EOB

:editor
(evil +everywhere); come to the dark side, we have cookies
file-templates    ; auto-snippets for empty files
fold              ; (nigh) universal code folding
snippets          ; my elves. They type so I don't have to

:emacs
dired             ; making dired pretty [functional]
electric          ; smarter, keyword-based electric-indent
undo              ; persistent, smarter undo for your inevitable mistakes
vc                ; version-control and Emacs, sitting in a tree

:checkers
syntax              ; tasing you for every semicolon you forget
spell             ; tasing you for misspelling mispelling
grammar           ; tasing grammar mistake every you make

:tools
(debugger +lsp)          ; FIXME stepping through code, to help you add bugs
(eval +overlay)     ; run code, run (also, repls)
lookup              ; navigate your code and its documentation
lsp
pdf               ; pdf enhancements

:lang

emacs-lisp        ; drown in parentheses

(java +lsp)         ; Added by Ma Nu from

latex             ; writing papers in Emacs has never been so fun

markdown          ; writing docs for people to ignore

(org +roam)               ; organize your plain life in plain text

sh                ; she sells {ba,z,fi}sh shells on the C xor

:email
(mu4e +gmail)

:app
calendar

:config
literate
(default +bindings +smartparens)

)
