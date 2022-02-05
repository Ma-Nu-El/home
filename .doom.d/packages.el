;; -*- no-byte-compile: t; -*-

(package! org-transclusion
  :recipe (:host github
           :repo "nobiot/org-transclusion"
           :branch "main"
           :files ("*.el")
           )
  )

(package! org-contrib
  :recipe (:host github
           :repo "emacsmirror/org-contrib")
  )
