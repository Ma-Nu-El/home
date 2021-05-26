;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Manuel Fuica Morales"
      ;; user-mail-address "m.fuica01@ufromail.cl"
      )
;; (setq smtpmail-smtp-server "smtp.gmail.com")
;; (setq smtpmail-smtp-service 587) ;; this might need to change


;; https://stackoverflow.com/questions/17281669/using-smtp-gmail-and-starttls
;; https://emacs.stackexchange.com/questions/46257/sending-email-fails-with-process-smtpmail-not-running
(setq mu4e-maildir "~/Maildir")
(setq mu4e-attachment-dir (expand-file-name "~/myDrive/mailAttachments"))
;; Details for mu4e-attachement-dir configuration:
;; https://github.com/hlissner/doom-emacs/issues/3294

;; https://gist.github.com/areina/3879626
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

-----BEGIN PGP MESSAGE-----

jA0ECQMCrNKZlxS5d8//0sE7ATOfEle03cbdtksSgFLH96Hu2noFjtRvmhZEwzlN
BO7X+UOpoDdWotD8Ubrllm0wWkvn+kLqz+8LjoFCHCfFc84vwFZ4gtyVGLD02lsy
3ETb3614nOX/nvyIauo/If0+yfsrvEa77DndAeaPtYNuDVkLLrHfjXxUDnUkcgAo
dte5yyOojC40saA4rEXs55+OuQ8jZkSd8ANZEx9UEy9bD4wJ9BuPZBMjYygFxwCN
bTjM088GOid9Lnt1wIHqw4OmfXQjadjvac6QgpWEusQEtoIn3d6D5RdpTFWBJiXz
l6gyyZQSpLG70K0f1hWZ6IZQ90lAXA8fiME36rXzRi7VEQ48psRv4+drnmYRG7Tu
kDs+++y3SZluQqWJCNBz2Bb5YIy+F9/U1HA46sK+Y1UOSRn2Y/vj4zFulD3l41to
rlEe23re4r0rTVowUL3PkxwMhbOwSyx20lLOmf8LL8CRaFlTvdDy+tKiy3z7gn2r
D6YIx51wRaxK724y3YLVwpc7V4HuO7VOpKHTj8JEJkcLA/f+y1evCACdPibiwvdM
2QdhQSrBqXScF3qRodKpNFQKL6x6gQFngw4X1nk7kp0/chPX9jjkZ/cJiHs2/tGd
8UcDGRYHIw9EyvRKGg/UVXJY+G2CqovtLl3S2kdkr1Yip5BpHaSPWZHSgdjv
=BfQG
-----END PGP MESSAGE-----

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
;; Added by me
;; https://stackoverflow.com/questions/11384516/how-to-make-all-org-files-under-a-folder-added-in-agenda-list-automatically
(setq org-agenda-files (directory-files-recursively "~/org/" "\\.org$")) 

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)
;; https://github.com/hlissner/doom-emacs/blob/develop/docs/faq.org#why-is-emacsdoom-slow

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

;; BEGIN AFTER ORG
(after! org
  (setq org-adapt-indentation nil)
  ;; More consistent; if I change heading level I don't have to fix indentation.
  (setq org-fontify-quote-and-verse-blocks nil
        org-fontify-whole-heading-line nil
        org-hide-leading-stars nil
        org-startup-indented nil
        flyspell-mode t
        )
                                        ; https://emacs.stackexchange.com/questions/9709/keep-the-headlines-expanded-in-org-mode
  (setq org-startup-folded t)
                                        ; https://stackoverflow.com/questions/24686129/how-can-i-make-org-mode-store-state-changes-for-a-repeating-task-in-a-drawer
  (setq org-log-into-drawer "LOGBOOK") 
  (setq org-clock-into-drawer "CLOCKBOOK")

  ;; https://github.com/pokeefe/Settings/blob/master/emacs-settings/.emacs.d/modules/init-org.el
  ;; Effort and global properties
  (setq org-global-properties '(
                                ("Effort_ALL". "0 0:01 0:03 0:05 0:10 0:15 0:20 0:30 0:45 1:00 1:30 2:00 3:00
                               4:00 6:00 8:00")
                                )
        )

  ;; Set global Column View format
  (setq org-columns-default-format '"%34ITEM(Item) %10TAGS(Tags) %5TODO(State)
 %5Effort(Estim){:} %10CLOCKSUM(Actual)")


  (setq org-log-states-order-reversed t) ; doesn't really work...why?
  (setq org-agenda-span 1) ; show today only by default; it's quicker
  (setq org-agenda-start-day "-0d") ; start on current day,
                                    ; useful when exporting html 28-day version.
  (add-to-list 'org-export-backends 'org)
                                        ; ### TRACK TODO STATE CHANGES
                                        ; https://orgmode.org/manual/Tracking-TODO-state-changes.html
                                        ; OrgMode E03S01: Automatic logging of status changes:
                                        ; https://www.youtube.com/watch?v=R4QSTDco_w8

  (setq org-todo-keywords
        '((sequence "TODO(t/!)" "NEXT(n/!)" "WAIT(w@/!)" "PROJ(p)"
                    "SOMEDAY(s)" "|" "DONE(d@/!)" "CANCELED(c@/!)")
          )
        )
  (setq org-log-done t)
  ;;https://github.com/hlissner/doom-emacs/issues/3102
  (add-to-list 'org-modules 'org-habit)
  ;; https://emacs.stackexchange.com/questions/38183/how-to-exclude-a-file-from-agenda
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
  ;; Hide filename in agenda view
  (setq org-agenda-prefix-format "%t %s")
  ;; https://lists.gnu.org/archive/html/emacs-orgmode/2010-01/msg00744.html

  ;; Disable "now" line in org agenda view
  ;; That line is counterintuitive sometimes when checking agenda
  ;; remotely.
  (setq org-agenda-show-current-time-in-grid nil)
  (setq org-agenda-hide-tags-regexp ".")
  (setq org-agenda-use-time-grid nil)
  ;; https://orgmode.org/manual/Agenda-Commands.html
  ;; Orgmode latex export: new page after TOC
  ;; https://emacs.stackexchange.com/questions/42558/org-mode-export-force-page-break-after-toc
  (setq org-latex-toc-command "\\tableofcontents \\clearpage")

  ;; [2021-05-03 Mon]
  ;; By default, doom emacs wont store email links in mu4e headers view
  ;; have to enable org-mu4e
  ;; (require 'org-mu4e) ; interferes with the rest of org-links

  ;; MORE ABOUT ORG MODE
  ;; https://orgmode.org/manual/Breaking-Down-Tasks.html#Breaking-Down-Tasks
  (defun org-summary-todo (n-done n-not-done)
    "Switch entry to DONE when all subentries are done, to TODO otherwise."
    (let (org-log-done org-log-states)   ; turn off logging
      (org-todo (if (= n-not-done 0) "DONE" "TODO")))
    )
  (add-hook 'org-after-todo-statistics-hook 'org-summary-todo)
  ;; also, you have to set the cookie property to 'todo recursive'; you
  ;; can use Doom's 'SPC m o'. Still, it's too much work. Have to do
  ;; something about it.

  (setq org-id-link-to-org-use-id t)

  ;; orgmode: open links with default application?
  ;;https://stackoverflow.com/questions/3973896/emacs-org-mode-file-viewer-associations
  ;;https://emacs.stackexchange.com/questions/2856/how-to-configure-org-mode-to-respect-system-specific-default-applications-for-ex
  (setq org-file-apps
        '((auto-mode . emacs)
          ("\\.mm\\'" . default)
          ("\\.x?html?\\'" . default)
          ("\\.pdf\\'" . default)
          ("\\.jpg\\'" . default)
          ("\\.png\\'" . default)
          )
        )
  ) ;; END AFTER ORG

;; PERSONAL KEY BINDINGS
(define-key evil-motion-state-map (kbd "C-z") nil) ; disable C-z as 'pause'
(global-set-key (kbd "\C-cr") 'ispell-region)

(setq ispell-dictionary "en")

;; ORG-ROAM
(setq org-roam-directory "~/org/auxRoam")
(add-hook 'after-init-hook 'org-roam-mode)
(require 'org-roam-protocol)

;; https://www.orgroam.com/manual.html#Daily_002dnotes
(setq org-roam-dailies-directory "~/org/dailies/")
(setq org-roam-dailies-capture-templates
      '(("d" "default" entry
         #'org-roam-capture--get-point
         "* %?"
         :file-name "daily/%<%Y-%m-%d>"
         :head "#+title: %<%Y-%m-%d>\n\n"))
      )

;; disable backup
(setq backup-inhibited t)
;; disable auto save
(setq auto-save-default nil)

;; (custom-set-variables
;;  '(safe-local-variable-values (quote ((ispell-dictionary . "español"))))
;;  )
