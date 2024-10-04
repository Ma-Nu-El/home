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

(setq org-agenda-files "~/.doom.d/agenda-files.txt")

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
                              ("Effort_ALL" .
                               "0 0:01 0:03 0:05 0:10 0:15 0:20 0:30 0:45 1:00 1:30 2:00 2:30 3:00 3:30 4:00 4:30 5:00 5:30 6:00 6:30 7:00 7:30 8:00")
                              )
      )

(setq org-columns-default-format '"%60ITEM(Item) %5Effort(Estim){:} %5CLOCKSUM(Curr)")

(setq org-log-into-drawer "LOGBOOK")
(setq org-clock-into-drawer "CLOCKBOOK")

(setq org-agenda-span 3)
(setq org-agenda-start-day "-0d") ; start on current day,
                                        ; useful when exporting html 28-day version.
(setq org-agenda-start-on-weekday nil)

(setq org-agenda-prefix-format "%t %s")

(setq org-agenda-show-current-time-in-grid nil)
(setq org-agenda-hide-tags-regexp ".")
(setq org-agenda-use-time-grid nil)

(setq org-agenda-custom-commands
      '(
        ;; ( "1" "Next 28 days."
        ;;   ((agenda ""))
        ;;   ;; ((org-agenda-tag-filter-preset '("-habit")))
          ;; ("~/agenda-today.html") ;; enables html export of this agenda view
        ;;   ((org-agenda-span 28))
        ;;   ((org-agenda-start-day "-0d"))
        ;;   )
        ("1" "Next 28 days" agenda ""
         ((org-agenda-span 28)
          (org-agenda-start-day "-0d")
          (org-agenda-remove-tags t)
         )
         ("~/test.pdf"))
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

(add-to-list 'org-modules 'org-habit)

(setq org-habit-preceding-days 21)
(setq org-habit-following-days 7)

(setq org-todo-keywords
      '((sequence
         "WAIT(w@)"
         "NEXT(n!)"
         ;; "DOIN(d!)"
         "TODO(t!)"
         "PROJ(p!)"
         "INCU(i!)"
         "|"
         "DONE(D@)"
         "CNLD(C@)" )
        )
      )

(setq org-log-done 'note)

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

(setq org-babel-python-command "~/venv/python3.12.2/bin/python")

(setq org-hierarchical-todo-statistics nil)

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
        ("\\.tar.xz\\'" . default) ;; for org-mode extensions
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
(setq org-clock-auto-clock-resolution nil)

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
         "* %u %?\n\n" :clock-in nil)
      ("W" "Work Citation" entry (file "~/FilenSync/org/bibliography.org")
         "* %u %?\n\n#+begin_src latex\n%?\n#+end_src" :clock-in nil)
      ("p" "Personal" entry (file "~/auxRoam/refile.org")
         "* %u %?\n\n" :clock-in nil)
      ("P" "Personal Citation" entry (file "~/auxRoam/bibliography.org")
         "* %u %?\n\n#+begin_src latex\n%?\n#+end_src" :clock-in nil)
))

(setq org-export-with-sub-superscripts nil)

(setq org-tag-alist '(
                      ("noexport" . ?n)
                      ("PROJ" . ?p)
                      ("read_only" . ?R)
                      )
)

(defvar org-created-property-name "CREATED"
  "The name of the org-mode property that stores the creation date of the entry")

(defun org-set-created-property (&optional active NAME)
  "Set a property on the entry giving the creation time.

By default the property is called CREATED. If given the `NAME'
argument will be used instead. If the property already exists, it
will not be modified."
  (interactive)
  (let* ((created (or NAME org-created-property-name))
         (fmt (if active "<%s>" "[%s]"))
         (now  (format fmt (format-time-string "%Y-%m-%d %a %H:%M"))))
    (unless (org-entry-get (point) created nil)
      (org-set-property created now))))
(add-hook 'org-capture-before-finalize-hook #'org-set-created-property)

(setq org-enable-priority-commands t
    org-priority-highest 1
    org-priority-default 9
    org-priority-lowest 9)

(defun my/org-get-parent-heading ()
  "Return the name of the parent heading of the current task."
  (save-excursion
    (outline-up-heading 1 t)  ;; Move to the parent heading
    (org-get-heading t t t t)))  ;; Get the parent heading name without tags or properties

(defun my/org-dynamic-archive-location ()
  "Dynamically generate the archive location based on the parent heading and current year.
The heading is sanitized to remove brackets, tags, and other non-alphabetic characters."
  (let* ((year (format-time-string "%Y"))  ;; Get the current year
         (parent-heading (my/org-get-parent-heading))  ;; Get the parent heading
         ;; Remove bracketed content (like [1/2][50%]) and tags (like :personal:)
         (clean-heading (replace-regexp-in-string "\\[.*?\\]\\|:[^:]*:" "" parent-heading))
         ;; Sanitize the heading: strip extra spaces and convert to lowercase with underscores
         (sanitized-heading (replace-regexp-in-string " +" "_" (downcase (string-trim clean-heading))))
         ;; Construct the archive file path
         (archive-file (concat "calendar/" year "/" sanitized-heading "_gtd_archive.org")))
    archive-file))  ;; Return the archive file path

(defun my/org-archive-done-tasks ()
  "Archive DONE tasks using a dynamically generated archive location based on the parent heading and year.
The default archive behavior is restored after the custom archiving."
  (interactive)
  (let ((org-archive-location (concat (my/org-dynamic-archive-location) "::")))  ;; Temporarily set archive location
    (org-archive-subtree)))  ;; Archive the current subtree

(defun create-prompt-from-list (prompt lst)
  "Helper function for numbered options with dots for alignment."
  (let ((max-length (apply 'max (mapcar 'length lst)))  ;; Get the max length of the items
        (choices ""))
    (cl-loop for x in lst
             for idx from 1
             do (let ((dots (make-string (- (+ max-length 5) (length x)) ?.)))  ;; Create the dots
                  (setq choices (concat choices (format "%s %s (%d)\n" x dots idx)))))
    (let ((choice (read-string (concat prompt "\n" choices "\nPress Enter to skip: "))))
      (if (and (string-match "^[0-9]+$" choice)  ;; Only accept numeric input
               (<= (string-to-number choice) (length lst)))
          (nth (1- (string-to-number choice)) lst)  ;; Return the selected tag
        nil))))  ;; Return nil if input is empty or invalid

;; Helper function to convert effort to HH:MM format
(defun effort-to-hhmm (effort-string)
  "Convert an EFFORT string in MINUTES or HOUR:MINUTE format to 'HH:MM'."
  (if (string-match-p ":" effort-string)
      ;; If format is HOUR:MINUTE (contains ":")
      effort-string
    ;; If format is just MINUTE, convert to HOUR:MINUTE
    (let* ((minutes (string-to-number effort-string))
           (hours (/ minutes 60))
           (mins (% minutes 60)))
      (format "%d:%02d" hours mins))))

;; Main function
(defun my/org-agenda-custom-search-next-action ()
  "Search Org mode agenda for entries with TODO='NEXT', CONTEXT, PLACE, ENERGY, EFFORT range, and optionally filter by PROJ ancestors.
If any argument is empty, the filter is ignored."
  (interactive)
  (let* (
         ;; CONTEXT filter selection (using `my-custom-tags-personal` from personal.el)
         (context-choice
          (create-prompt-from-list "Context (optional):" my-custom-tags-personal))

         ;; PLACE filter selection (using `my-custom-tags-place` from personal.el)
         (place-choice
          (create-prompt-from-list "Place (optional):" my-custom-tags-place))

         ;; ENERGY filter selection (using `my-custom-tags-energy` from personal.el)
         (energy-choice
          (create-prompt-from-list "Energy (optional):" my-custom-tags-energy))

         ;; Minimum EFFORT
         (min-effort (read-string "Minimum EFFORT (HOUR:MINUTE or MINUTE, leave empty to ignore): " nil nil ""))

         ;; Maximum EFFORT
         (max-effort (read-string "Maximum EFFORT (HOUR:MINUTE or MINUTE, leave empty to ignore): " nil nil ""))

         ;; PROJ filter selection (y/n or skip)
         (proj-only
          (let ((choice (read-string "Show only tasks with PROJ ancestors (y) or only without PROJ ancestors (n)? (Press Enter to skip): ")))
            (cond
             ((string= choice "y") t)   ;; If 'y', return true for project-related tasks
             ((string= choice "n") nil) ;; If 'n', return false for non-project tasks
             (t 'skip)))))  ;; If Enter is pressed, skip the PROJ filter entirely

    ;; Build the query, starting with TODO="NEXT"
    (let (query)
      (setq query "TODO=\"NEXT\"")

      ;; Add CONTEXT filter
      (when context-choice
        (setq query (concat query (format "+%s" context-choice))))

      ;; Add PLACE filter
      (when place-choice
        (setq query (concat query (format "+%s" place-choice))))

      ;; Add ENERGY filter
      (when energy-choice
        (setq query (concat query (format "+%s" energy-choice))))

      ;; Add Minimum EFFORT filter
      (when (and min-effort (not (string= min-effort "")))
        (setq query (concat query (format "+EFFORT>=\"%s\"" (effort-to-hhmm min-effort)))))

      ;; Add Maximum EFFORT filter
      (when (and max-effort (not (string= max-effort "")))
        (setq query (concat query (format "+EFFORT<=\"%s\"" (effort-to-hhmm max-effort)))))

      ;; Handle PROJ filtering (t, nil, or skip)
      (cond
       ((eq proj-only t)
        (setq query (concat query "+PROJ")))  ;; Show only project tasks
       ((eq proj-only nil)
        (setq query (concat query "-PROJ")))) ;; Exclude project tasks

      ;; Perform the search with the constructed query
      (org-tags-view nil query))))

(defun my/org-convert-to-next-action ()
  "Convert a TODO heading to a NEXT action, adding CONTEXT, PLACE, and ENERGY properties.
Calls `org-set-effort' to assign EFFORT interactively afterward.
Works if the point is anywhere within the subtree of the heading."
  (interactive)
  (save-excursion
    ;; Move point to the nearest heading, regardless of where it is in the subtree
    (org-back-to-heading t)

    (let* (
           ;; CONTEXT prompt with dots
           (context-choice
            (create-prompt-from-list "Context (optional):" my-custom-tags-personal))

           ;; PLACE prompt with dots
           (place-choice
            (create-prompt-from-list "Place (optional):" my-custom-tags-place))

           ;; ENERGY prompt with dots
           (energy-choice
            (create-prompt-from-list "Energy (optional):" my-custom-tags-energy)))

      ;; Replace the TODO keyword with NEXT
      (org-todo "NEXT")

      ;; Build the tags string from the choices and add it to the heading
      (let ((tags (concat (or context-choice "")
                          (if (and context-choice place-choice) ":" "")
                          (or place-choice "")
                          (if (and (or context-choice place-choice) energy-choice) ":" "")
                          (or energy-choice ""))))
        (org-set-tags-to tags))

      ;; Call org-set-effort for the interactive effort input
      (org-set-effort nil))))

;; Load personal settings from ~/.doom.d/personal.el, if it exists
(when (file-exists-p "~/.doom.d/personal.el")
  (load "~/.doom.d/personal.el"))

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

;; Load environment variables from the shell
;; (exec-path-from-shell-initialize)

;; Access the custom line length from the environment variable
(let ((line-length (string-to-number (or (getenv "CUSTOM_CLI_LINE_LENGTH") "55"))))
  ;;(setq display-fill-column-indicator t)
  (setq-default display-fill-column-indicator-column line-length)
  (setq-default fill-column line-length)
  (global-display-fill-column-indicator-mode))

(global-git-gutter-mode +1)

(after! org (setq org-fold-core-style 'overlays) )

(defun org-mark-readonly ()
  (interactive)
  (org-map-entries
   (lambda ()
     (let* ((element (org-element-at-point))
            (begin (org-element-property :begin element))
            (end (org-element-property :end element)))
       (add-text-properties begin (- end 1) '(read-only t))))
   "read_only")
)

(defun org-remove-readonly ()
  (interactive)
  (org-map-entries
   (lambda ()
     (let* ((element (org-element-at-point))
            (begin (org-element-property :begin element))
            (end (org-element-property :end element))
            (inhibit-read-only t))
         (remove-text-properties begin (- end 1) '(read-only t))))
     "read_only")
     (message "readonly disabled")
  )

(add-hook 'org-mode-hook 'org-mark-readonly)

(map! :leader
  (:prefix-map ("k" . "custom key bindings")

    (:prefix-map ("r" . "reload")
     :desc "Current dynamic block" "d" #'org-update-dblock
     :desc "All dynamic blocks" "D" #'org-update-all-dblocks
    )

    (:prefix-map ("a" . "align")
     :desc "align-regexp" "r" #'align-regexp
    )

    (:prefix-map ("c" . "code")
     :desc "org-edit-src-block" "c" #'org-edit-src-code
    )

    (:prefix-map ("o" . "orgmode")
      (:prefix-map ("p" . "Add property")
       :desc "CREATED" "c" #'org-set-created-property
      )

      (:prefix-map ("k" . "org-kanban")
       :desc "Insert kanban here" "i" #'org-kanban/initialize-here
       :desc "Configure kanban block at point" "c" #'org-kanban/configure-block
       :desc "Shift TODO state of current entry" "s" #'org-kanban/shift
      )

      (:prefix-map ("T" . "table")
         :desc "org-table-shrink" "s" #'org-table-shrink
         :desc "org-table-expand" "e" #'org-table-expand
         :desc "org-table-toggle-column-width" "t" #'org-table-toggle-column-width
      )

      (:prefix-map ("t" . "TODO")
         :desc "my/org-convert-to-next-action" "n" #'my/org-convert-to-next-action
      )

      (:prefix-map ("r" . "readonly")
         :desc "org-mark-readonly" "e" #'org-mark-readonly
         :desc "org-remove-readonly" "d" #'org-remove-readonly
      )
      :desc "my/org-archive-done-tasks" "A" #'my/org-archive-done-tasks
      (:prefix-map ("a" . "agenda")
         :desc "my/org-agenda-custom-search-next-action" "n" #'my/org-agenda-custom-search-next-action
      )
    )
  )
)

;;;###package csv-mode
(map! :after csv-mode
      :localleader
      :map csv-mode-map
      "a" #'csv-align-fields
      "u" #'csv-unalign-fields
      "s" #'csv-sort-fields
      "S" #'csv-sort-numeric-fields
      "k" #'csv-kill-fields
      "t" #'csv-transpose
      "h" #'csv-header-line
      )
