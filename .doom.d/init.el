;;; init.el -*- lexical-binding: t; -*-

(doom!

:completion
company           ; the ultimate code completion backend
(ivy +fuzzy)              ; a search engine for love and life

:ui
doom              ; what makes DOOM look the way it does
doom-dashboard    ; a nifty splash screen for Emacs
doom-quit         ; DOOM quit-message prompts when you quit Emacs

hl-todo           ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
;;(modeline +light)          ; snazzy, Atom-inspired modeline, plus API
modeline          ; snazzy, Atom-inspired modeline, plus API

nav-flash         ; blink cursor line after big motions
ophints           ; highlight the region an operation acts on
(popup +defaults)   ; tame sudden yet inevitable temporary windows
vi-tilde-fringe   ; fringe tildes to mark beyond EOB
(window-select +numbers)     ; visually switch windows
(treemacs +lsp)          ; a project drawer, like neotree but cooler
workspaces        ; tab emulation, persistence & separate workspaces

vc-gutter         ; vcs diff in the fringe

:editor
(evil +everywhere); come to the dark side, we have cookies

file-templates    ; auto-snippets for empty files
fold              ; (nigh) universal code folding
snippets          ; my elves. They type so I don't have to

multiple-cursors  ; editing in many places at once

:emacs
dired             ; making dired pretty [functional]
electric          ; smarter, keyword-based electric-indent
undo              ; persistent, smarter undo for your inevitable mistakes
vc                ; version-control and Emacs, sitting in a tree
ibuffer         ; interactive buffer management

:checkers
syntax            ; tasing you for every semicolon you forget
;; (spell +aspell)             ; tasing you for misspelling mispelling
;; grammar           ; tasing grammar mistake every you make

:tools
(debugger +lsp)          ; FIXME stepping through code, to help you add bugs
(eval +overlay)   ; run code, run (also, repls)
lookup            ; navigate your code and its documentation
lsp
pdf               ; pdf enhancements
magit             ; a git porcelain for Emacs
biblio

:lang

data              ; config/data formats

emacs-lisp        ; drown in parentheses

(ess)               ; emacs speaks statistics

json              ; At least it ain't XML
(java +lsp)

javascript        ; all(hope(abandon(ye(who(enter(here))))))

(latex +lsp)        ; writing papers in Emacs has never been so fun

ledger            ; an accounting system in Emacs

markdown          ; writing docs for people to ignore

ocaml             ; an objective camel
(org +gnuplot +pomodoro +pandoc) ; organize your plain life in plain text

;; ;; perl              ; write code no one else can comprehend [DEPRECATED]
(raku +lsp)

(php +lsp)               ; perl's insecure younger brother

plantuml          ; diagrams for confusing people more

(python +lsp)            ; beautiful is better than ugly

(sh +lsp)                ; she sells {ba,z,fi}sh shells on the C xor

(web +lsp)               ; the tubes
(yaml +lsp)              ; JSON, but readable

:email
;; (mu4e +org)

:app
calendar

:config
literate
(default +bindings +smartparens)

)
