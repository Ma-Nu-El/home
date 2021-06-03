;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Manuel Fuica Morales"
      ;; user-mail-address "m.fuica01@ufromail.cl"
      )

(setq mu4e-maildir "~/Maildir")
(setq mu4e-attachment-dir (expand-file-name "~/myDrive/mailAttachments"))

(setq message-send-mail-function 'smtpmail-send-it
      starttls-u        se-gnutls t
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

(setq doom-theme 'doom-one)

(setq org-directory "~/org/")

(setq org-agenda-files (directory-files-recursively "~/org/" "\\.org$"))

(setq display-line-numbers-type nil)

;; BEGIN AFTER ORG
(after! org

(setq org-adapt-indentation nil)

(setq org-fontify-quote-and-verse-blocks nil
      org-fontify-whole-heading-line nil
      org-hide-leading-stars nil
      org-startup-indented nil
      flyspell-mode t
      )

(setq org-startup-folded nil)

(setq org-log-into-drawer "LOGBOOK")
(setq org-clock-into-drawer "CLOCKBOOK")

;; https://github.com/pokeefe/Settings/blob/master/emacs-settings/.emacs.d/modules/init-org.el
;; Effort and global properties
(setq org-global-properties '(
                              ("Effort_ALL". "0 0:01 0:03 0:05 0:10 0:15 0:20 0:30 0:45 1:00 1:30 2:00 3:00
                               4:00 6:00 8:00")
                              )
      )

(setq org-columns-default-format '"%34ITEM(Item) %10TAGS(Tags) %5TODO(State)
 %5Effort(Estim){:} %10CLOCKSUM(Actual)")

(setq org-agenda-span 1) ; show today only by default; it's quicker
(setq org-agenda-start-day "-0d") ; start on current day,
                                        ; useful when exporting html 28-day version.

(add-to-list 'org-export-backends 'org)

(setq org-todo-keywords
      '((sequence "TODO(t/!)" "NEXT(n/!)" "WAIT(w@/!)" "PROJ(p)"
                  "SOMEDAY(s)" "|" "DONE(d@/!)" "CANCELED(c@/!)")
        )
      )
(setq org-log-done t)

(add-to-list 'org-modules 'org-habit)

(custom-set-variables
 '(org-agenda-custom-commands
   '(( "h" "Custom agenda, ignore 'habit' tag"
       ((agenda ""))
       ((org-agenda-tag-filter-preset '("-habit")))
       )
     ( "x" "28-day version of h"
       ;; Made to be exported to html
       ((agenda ""
                ((org-agenda-span 28))
                ))
       ;; The bigger the agenda span, the longer the process
       ((org-agenda-tag-filter-preset '("-habit")))
       ("~/org/agenda.html") ;; enables html export of this agenda view
       )
     ( "H" "Custom agenda, only 'habit' tag"
       ((agenda ""))
       ((org-agenda-tag-filter-preset '("+habit"))))
     ( "u" "Custom agenda, ignore 'university' tag"
       ((agenda ""))
       ((org-agenda-tag-filter-preset '("-university"))))
     ( "U" "Custom agenda, only 'university' tag"
       ((agenda ""))
       ((org-agenda-tag-filter-preset '("+university"))))
     ( "c" "Custom agenda, only 'contacts' tag"
       ((agenda ""))
       ((org-agenda-tag-filter-preset '("+contacts"))))
     ( "b" "Custom agenda, only 'birthday' tag"
       ((agenda ""))
       ((org-agenda-tag-filter-preset '("+birthday"))))
     ( "k" "Custom agenda, ignore 'music' tag"
       ((agenda ""))
       ((org-agenda-tag-filter-preset '("-music"))))
     ( "K" "Custom agenda, only 'music' tag"
       ((agenda ""))
       ((org-agenda-tag-filter-preset '("+music"))))
     )
   )
 )

(setq org-agenda-prefix-format "%t %s")

(setq org-agenda-show-current-time-in-grid nil)
(setq org-agenda-hide-tags-regexp ".")
(setq org-agenda-use-time-grid nil)

(setq org-latex-toc-command "\\tableofcontents \\clearpage")

(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)

(setq org-id-link-to-org-use-id t)

(setq org-file-apps
      '((auto-mode . emacs)
        ("\\.mm\\'" . default)
        ("\\.x?html?\\'" . default)
        ("\\.pdf\\'" . default)
        ("\\.jpg\\'" . default)
        ("\\.png\\'" . default)
        )
      )

(setq org-clock-persist 'history)
(setq org-clock-persist-file "~/.doom.d/.org-clock-save.el")
(setq org-clock-persistence-insinuate t)

(setq org-export-exclude-tags '("noexport"))

(setq org-tags-exclude-from-inheritance '("crypt"))

(use-package! org-transclusion)

)
;; END AFTER ORG

(define-key evil-motion-state-map (kbd "C-z") nil) ; disable C-z as 'pause'
(global-set-key (kbd "\C-cr") 'ispell-region)

(setq ispell-dictionary "en")

;; ORG-ROAM
(setq org-roam-directory "~/org/auxRoam")
(add-hook 'after-init-hook 'org-roam-mode)
(require 'org-roam-protocol)

;; disable backup
(setq backup-inhibited t)
;; disable auto save
(setq auto-save-default nil)
