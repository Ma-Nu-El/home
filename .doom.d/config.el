;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

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
(setq display-line-numbers-type 'relative)

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
(after! org
  (setq org-hide-leading-stars t
        org-startup-indented nil
        flyspell-mode t
        )
                                        ; https://emacs.stackexchange.com/questions/9709/keep-the-headlines-expanded-in-org-mode
  (setq org-startup-folded t)
                                        ; https://stackoverflow.com/questions/24686129/how-can-i-make-org-mode-store-state-changes-for-a-repeating-task-in-a-drawer
  (setq org-log-into-drawer t) ; couldn't make it work with a STRING but still gets the job done anyway so I'm happy.
  (setq org-log-states-order-reversed t) ; doesn't really work...why?
  (add-to-list 'org-export-backends 'org)

                                        ; ### TRACK TODO STATE CHANGES
                                        ; https://orgmode.org/manual/Tracking-TODO-state-changes.html
                                        ; OrgMode E03S01: Automatic logging of status changes:
                                        ; https://www.youtube.com/watch?v=R4QSTDco_w8
  (setq org-todo-keywords
        '((sequence "TODO(t/!)" "NEXT(n/!)" "WAIT(w@/!)" "PROJ(p)" "|" "DONE(d@/!)" "CANCELED(c@/!)")))
  (setq org-log-done t)
  (define-key org-mode-map "SPC o i s t" 'org-insert-structure-template)
  ) ;; end after org

;; personal key bindings
(define-key evil-motion-state-map (kbd "C-z") nil) ; disable C-z as 'pause'
(global-set-key (kbd "\C-cr") 'ispell-region)

;; roam capabilities
(setq org-roam-directory "~/org/auxRoam")
(add-hook 'after-init-hook 'org-roam-mode)
(require 'org-roam-protocol)
                                        ;disable backup
(setq backup-inhibited t)
                                        ;disable auto save
(setq auto-save-default nil)

;; https://orgmode.org/manual/Breaking-Down-Tasks.html#Breaking-Down-Tasks
(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)
;; also, you have to set the cookie property to 'todo recursive'; you can use
;; Doom's 'SPC m o'. Still, it's too much work. Have to do something about it.
(add-to-list 'load-path "~/path/to/your/downloaded/htmlize.el")
(require 'htmlize)

(setq org-id-link-to-org-use-id t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values (quote ((ispell-dictionary . "español")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
)
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
