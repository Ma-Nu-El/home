;; -*- no-byte-compile: t; -*-

(package! org-transclusion
  :recipe (:host github
           :repo "nobiot/org-transclusion"
           :branch "main"
           :files ("*.el")
           )
  )

(package! ob-ledger :recipe (:local-repo "lisp/ob-ledger"))

(package! org-glossary
  :recipe (:host github
           :repo "gizmomogwai/org-kanban"
           )
)

(package! org-ai
  :recipe (:host github
           :repo "rksm/org-ai"
           :files ("*.el" "README.md" "snippets")))

(package! org-web-tools
  :recipe (:host github
           :repo "alphapapa/org-web-tools"
           :branch "master"
           )
)
