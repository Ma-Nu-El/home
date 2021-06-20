;; -*- no-byte-compile: t; -*-

(package! org-transclusion
  :recipe (:host github
           :repo "nobiot/org-transclusion"
           :branch "main"
           :files ("*.el")
           )
  )

(package! org-sidebar
  :recipe (:host github
           :repo "alphapapa/org-sidebar"
           :branch "master"
           )
  )
