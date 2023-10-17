;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Manuel Fuica Morales"
      ;; user-mail-address "m.fuica01@ufromail.cl"
      )

(setq mu4e-maildir "~/Maildir")
(setq mu4e-attachment-dir (expand-file-name "~/myDrive/mailAttachments"))

(setq message-send-mail-function 'smtpmail-send-it
      starttls-use-gnutls t
      smtpmail-starttls-credentials
      '(("smtp.gmail.com" 587 nil nil))
      smtpmail-auth-credentials
      (expand-file-name "~/.authinfo.gpg")
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587
      smtpmail-debug-info t
      ;; auth-sources '(password-store)
      auth-source-debug t
      )

(setq doom-theme 'doom-gruvbox)

(setq org-directory "~/FilenSync/org/")

(setq org-agenda-files "~/agenda-files.txt")

(setq display-line-numbers-type nil)

(setq mouse-wheel-tilt-scroll t)

;; BEGIN AFTER ORG
(after! org

(add-to-list 'org-export-backends 'org)

(setq org-adapt-indentation nil)

(setq org-fontify-quote-and-verse-blocks nil
      org-fontify-whole-heading-line nil
      org-hide-leading-stars nil
      org-startup-indented nil
      )

(setq org-startup-folded nil)

;; https://github.com/pokeefe/Settings/blob/master/emacs-settings/.emacs.d/modules/init-org.el
;; Effort and global properties
(setq org-global-properties '(
                              ("Effort_ALL". "0 0:01 0:03 0:05 0:10 0:15 0:20 0:30 0:45 1:00 1:30 2:00")
                              )
      )

(setq org-columns-default-format '"%30ITEM(Item) %6Effort(Estim){:} %6CLOCKSUM(Actual)")

(setq org-log-into-drawer "LOGBOOK")
(setq org-clock-into-drawer "CLOCKBOOK")

(setq org-agenda-span 3) ; show today only by default; it's quicker
(setq org-agenda-start-day "-0d") ; start on current day,
                                        ; useful when exporting html 28-day version.
(setq org-agenda-start-on-weekday nil)

(setq org-agenda-custom-commands
      '(
        ;; ( "1" "Last 3 days."
        ;;   ((agenda ""))
        ;;   ;; ((org-agenda-tag-filter-preset '("-habit")))
        ;;   ;; ("~/org/agenda-today.html") ;; enables html export of this agenda view
        ;;           ((org-agenda-span 3))
        ;;           ((org-agenda-start-day "-2"))
        ;;   )
        ;; ( "3" "Next 3 days."
        ;;   ;; Made to be exported to html
        ;;   ((agenda ""))
        ;;            ((org-agenda-span 3))
        ;;            ((org-agenda-start-day "+1"))
        ;;   ;; The bigger the agenda span, the longer the process
        ;;   )
        ;; ( "2" "Last and next 3 days."
        ;;   ;; Made to be exported to html
        ;;   ((agenda ""))
        ;;            ((org-agenda-span 7))
        ;;            ((org-agenda-start-day "-2"))
        ;;   )
        ;; ( "8" "Next 8 days, don't show today."
        ;;   ;; Made to be exported to html
        ;;   ((agenda ""))
        ;;            ((org-agenda-span 8))
        ;;            ((org-agenda-start-day "+1d"))
        ;;   )
        ;; ( "4" "Next 14 days, don't show today."
        ;;   ;; Made to be exported to html
        ;;   ((agenda ""))
        ;;            ((org-agenda-span 14))
        ;;            ((org-agenda-start-day "+1d"))
        ;;   )
        ;; ( "0" "Next 28 days, don't show today."
        ;;   ;; Made to be exported to html
        ;;   ((agenda ""))
        ;;            ((org-agenda-span 28))
        ;;            ((org-agenda-start-day "+1d"))
        ;;   )
        ( "H" "Only 'habit' tag"
          ((agenda ""))
          ((org-agenda-tag-filter-preset '("+habit"))))
        ( "h" "Exclude 'habit' tag"
          ((agenda ""))
          ((org-agenda-tag-filter-preset '("-habit"))))
        ;; ( "n" "Only 'today' tag."
        ;;   ((agenda ""))
        ;;   ((org-agenda-tag-filter-preset '("+today"))))
        ( "O" "Only 'oneoff' tag."
          ((agenda ""))
          ((org-agenda-tag-filter-preset '("+oneoff"))))
        ( "R" "Only 'recurring' tag."
          ((agenda ""))
          ((org-agenda-tag-filter-preset '("+recurring"))))
        ( "u" "Exclude 'university' tag."
          ((agenda ""))
          ((org-agenda-tag-filter-preset '("-university"))))
        ( "U" "Only 'university' tag."
          ((agenda ""))
          ((org-agenda-tag-filter-preset '("+university"))))
        ( "l" "All 'university' except 'lecture' and 'assistantship'."
          ((agenda ""))
          ((org-agenda-tag-filter-preset '("+university" "-lecture" "-assistantship"))))
        ( "L" "Only lectures and assistantships."
          ((agenda ""))
          ((org-agenda-tag-filter-preset '("+lecture" "+assistantship"))))
        ( "c" "Only 'contacts' tag."
          ((agenda ""))
          ((org-agenda-tag-filter-preset '("+contacts"))))
        ( "b" "Only 'birthday' tag."
          ((agenda ""))
          ((org-agenda-tag-filter-preset '("+birthday"))))
        ( "k" "Exclude 'music' tag."
          ((agenda ""))
          ((org-agenda-tag-filter-preset '("-music"))))
        ( "K" "Only 'music' tag."
          ((agenda ""))
          ((org-agenda-tag-filter-preset '("+music"))))
        )
      )

(setq org-agenda-prefix-format "%t %s")

(setq org-agenda-show-current-time-in-grid nil)
(setq org-agenda-hide-tags-regexp ".")
(setq org-agenda-use-time-grid nil)

(add-to-list 'org-modules 'org-habit)

(setq org-habit-preceding-days 21)
(setq org-habit-following-days 7)

(setq org-todo-keywords
      '((sequence
         "WAIT(w)"
         "NEXT(n)"
         "DOIN(d)"
         "TODO(t)"
         "PROJ(p)"
         "INCU(i)"
         "|"
         "DONE(D)"
         "CNLD(C)" )
        )
      )
(setq org-log-done nil)

(with-eval-after-load 'ox-latex
(add-to-list 'org-latex-classes
             '("extbook"
               "\\documentclass{extbook}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
(add-to-list 'org-latex-classes
             '("extarticle"
               "\\documentclass{extarticle}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
(add-to-list 'org-latex-classes
             '("extreport"
               "\\documentclass{extreport}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
(add-to-list 'org-latex-classes
             '("IEEEtran"
               "\\documentclass{IEEEtran}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
)

(setq org-babel-python-command "python3")

(setq org-id-link-to-org-use-id t)

(setq org-file-apps
      '((auto-mode . emacs)
        ("\\.mm\\'" . default)
        ("\\.x?html?\\'" . default)
        ("\\.pdf\\'" . default)
        ("\\.jpg\\'" . default)
        ("\\.png\\'" . default)
        ("\\.svg\\'" . default)
        ("\\.pptx\\'" . default)
        ;; Libreoffice (ODF) extensions
        ("\\.odt\\'" . default) ;; text
        ("\\.ods\\'" . default) ;; spreadsheet
        ("\\.odp\\'" . default) ;; presentation
        ("\\.odg\\'" . default) ;; graphics
        )
      )

(setq org-clock-persist 'history)
(setq org-clock-persist-file "~/.doom.d/.org-clock-save.el")
(setq org-clock-persistence-insinuate t)

(setq org-export-exclude-tags '("noexport"))

(setq org-tags-exclude-from-inheritance '("crypt"))

(use-package! org-transclusion)

(require 'org-depend)

;; ORG-ROAM
(setq org-roam-directory "~/auxRoam")

(setq org-default-notes-file (concat org-directory "default_notes.org"))

(setq org-capture-templates
     '(
      ("w" "Work" entry (file "~/FilenSync/org/refile.org")
         "* %u %?\n# - %U\n\n" :clock-in nil)
      ("W" "Work Citation" entry (file "~/FilenSync/org/bibliography.org")
         "* %u\n# - %U\n\n#+begin_src latex\n%?\n#+end_src" :clock-in nil)
      ("p" "Personal" entry (file "~/auxRoam/refile.org")
         "* %u %?\n# - %U\n\n" :clock-in nil)
      ("P" "Personal Citation" entry (file "~/auxRoam/bibliography.org")
         "* %u\n# - %U\n\n#+begin_src latex\n%?\n#+end_src" :clock-in nil)
))

(setq org-hierarchical-todo-statistics nil)

(setq org-export-with-sub-superscripts nil)

)
;; END AFTER ORG

(define-key evil-motion-state-map (kbd "C-z") nil) ; disable C-z as 'pause'
(global-set-key (kbd "\C-cr") 'ispell-region)

(setq calendar-week-start-day 1)

(setq +treemacs-git-mode 'simple)

;; disable backup
(setq backup-inhibited t)
;; disable auto save
(setq auto-save-default nil)

(custom-set-faces!
  '(aw-leading-char-face
    :foreground "white" :background "red"
    :weight bold :height 2.5 :box (:line-width 10 :color "red")))

;; (custom-set-variables
;;  '(safe-local-variable-values (quote ((ispell-dictionary . "español"))))
;;  )

(global-display-fill-column-indicator-mode)
(setq-default display-fill-column-indicator-column 55)
;;(setq display-fill-column-indicator t)
;;(setq fill-column 80)

(global-git-gutter-mode +1)

(map! :leader
      (:prefix-map ("k" . "custom key bindings")
        (:prefix-map ("k" . "org-kanban")
         :desc "Insert kanban here" "i" #'org-kanban/initialize-here
         :desc "Configure kanban block at point" "c" #'org-kanban/configure-block
         :desc "Shift TODO state of current entry" "s" #'org-kanban/shift
        )
        (:prefix-map ("r" . "reload")
         :desc "Current dynamic block" "d" #'org-update-dblock
         :desc "All dynamic blocks" "D" #'org-update-all-dblocks
        )
        (:prefix-map ("a" . "align")
         :desc "by regexp" "r" #'align-regexp
        )
      )
)
