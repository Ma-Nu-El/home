;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Manuel Fuica Morales"
      ;; user-mail-address "m.fuica01@ufromail.cl"
      )

(setq doom-theme 'doom-gruvbox)

(setq org-directory "~/FilenSync/org/"
      personal-org-directory "~/auxRoam/")

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
      '(("A" "Custom Agenda View"
         ((agenda "" ;; Regular agenda view
                  (
                    ;; Do not include scheduled, due or overdue items here
                   (org-deadline-warning-days 0)
                   (org-scheduled-past-days 0)
                   (org-deadline-past-days 0)
                   (org-agenda-skip-scheduled-if-done nil)
                   (org-agenda-skip-timestamp-if-done nil)
                   (org-agenda-skip-deadline-if-done nil)
                   ))))
        ))

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
  (dolist (class
           '(("extbook" "\\documentclass{extbook}"
              ("\\section{%s}" . "\\section*{%s}")
              ("\\subsection{%s}" . "\\subsection*{%s}")
              ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
              ("\\paragraph{%s}" . "\\paragraph*{%s}")
              ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
             ("extarticle" "\\documentclass{extarticle}"
              ("\\section{%s}" . "\\section*{%s}")
              ("\\subsection{%s}" . "\\subsection*{%s}")
              ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
              ("\\paragraph{%s}" . "\\paragraph*{%s}")
              ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
             ("extreport" "\\documentclass{extreport}"
              ("\\section{%s}" . "\\section*{%s}")
              ("\\subsection{%s}" . "\\subsection*{%s}")
              ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
              ("\\paragraph{%s}" . "\\paragraph*{%s}")
              ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
             ("IEEEtran" "\\documentclass{IEEEtran}"
              ("\\section{%s}" . "\\section*{%s}")
              ("\\subsection{%s}" . "\\subsection*{%s}")
              ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
              ("\\paragraph{%s}" . "\\paragraph*{%s}")
              ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))
    (add-to-list 'org-latex-classes class t)))

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

(require 'org-crypt)

(org-crypt-use-before-save-magic)

;; Prevent inherited 'crypt' tags from double-encrypting content.
(setq org-tags-exclude-from-inheritance '("crypt"))

(setq org-crypt-disable-auto-save t) ;; Disable auto-save to prevent unencrypted copies.

;; Use symmetric encryption by default, switch to public key if CRYPTKEY is set.
(setq org-crypt-key "")

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

(setq org-cite-export-processors
      '((html csl)            ; use citeproc-el for HTML
        (latex biblatex)))    ; use biblatex/biber for PDF

(setq org-cite-global-bibliography '("~/FilenSync/org/bibliography.bib"))

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

(setq org-export-with-tags nil)

)
;; END AFTER ORG

(use-package! org-glossary
  :hook (org-mode . org-glossary-mode))

(after! lsp-mode
  (setq lsp-clients-php-server-command '("intelephense" "--stdio")))

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

;; (global-git-gutter-mode +1)

;; (setq org-ai-openai-api-token "") ; Ensure this is valid and set before the package
;; Ensure auth-source is enabled
(setq auth-sources '("~/.authinfo.gpg"))

;; Disable direct API token setting (optional if you're using auth-source)
(setq org-ai-use-auth-source t)

(use-package! org-ai
  :ensure t
  :commands (org-ai-mode
             org-ai-global-mode)
  :init
  (add-hook 'org-mode-hook #'org-ai-mode) ; enable org-ai in org-mode
  (org-ai-global-mode) ; installs global keybindings on C-c M-a
  :config
  (setq org-ai-auto-fill t)
  (setq org-ai-jump-to-end-of-block nil)
  ;; (setq org-ai-default-chat-model "gpt-3.5-turbo")
  (setq org-ai-default-chat-model "gpt-4o-mini")
  ;; (setq org-ai-default-chat-model "gpt-4")
  (org-ai-install-yasnippets)) ; if you are using yasnippet and want `ai` snippets

(after! org (setq org-fold-core-style 'overlays) )

(setq rmh-elfeed-org-files
      (list (concat personal-org-directory "elfeed.org")))

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

(defconst my/custom-cli-line-length
  (string-to-number (or (getenv "CUSTOM_CLI_LINE_LENGTH") "55"))
  "The default line length: read from system or default value (55).")

(defun my/sync-line-in-windows-simple ()
  "Sync the current line number and cursor position relative to the window in both horizontally split windows."
  (interactive)
  (let ((current-line (line-number-at-pos))                     ;; Save current line number
        (window-line (count-lines (window-start) (point))))     ;; Get how many lines from window top to cursor
    (other-window 1)                                            ;; Switch to the other window
    (goto-line current-line)                                    ;; Go to the same line number in the other window
    (recenter window-line)                                      ;; Move cursor to same number of lines from top
    (other-window 1)))                                          ;; Return to the original window

(defun my/copy-to-clipboard (start end)
  "Copy the selected region or the entire buffer to the clipboard using a temporary file and an external script."
  (interactive "r")
  (let* ((is-region (use-region-p))                             ;; Check if region is active
         (text (if is-region
                   (buffer-substring-no-properties start end)   ;; Get region content
                 (buffer-substring-no-properties (point-min) (point-max)))) ;; Get entire buffer content
         (temp-file (make-temp-file "emacs-clipboard-"))
         (script-path (expand-file-name "~/bin/copy_to_clipboard"))) ;; Adjust script path
    (if (not (file-executable-p script-path))
        (message "Error: Script not found or not executable: %s" script-path)
      (progn
        ;; Write text to temporary file
        (with-temp-file temp-file
          (insert text))
        ;; Call the external script with the temporary file as argument
        (call-process script-path nil nil nil temp-file)
        ;; Delete the temporary file
        (delete-file temp-file)
        ;; Display success message
        (message (if is-region
                     "Region copied to clipboard!"
                   "Buffer copied to clipboard!"))))))

(defun my/copy-file-path-to-clipboard ()
  "Copy the current buffer's file path to the clipboard, replacing the home directory with '~'."
  (interactive)
  (if buffer-file-name
      (let* ((home (expand-file-name "~"))
             (file-path (if (string-prefix-p home buffer-file-name)
                            (concat "~" (substring buffer-file-name (length home)))
                          buffer-file-name))
             (temp-file (make-temp-file "emacs-clipboard-"))
             (script-path (expand-file-name "~/bin/copy_to_clipboard"))) ;; Adjust script path
        (if (not (file-executable-p script-path))
            (message "Error: Script not found or not executable: %s" script-path)
          (progn
            ;; Write file path to temporary file
            (with-temp-file temp-file
              (insert file-path))
            ;; Call the external script with the temporary file as argument
            (call-process script-path nil nil nil temp-file)
            ;; Delete the temporary file
            (delete-file temp-file)
            ;; Display success message
            (message "File path copied to clipboard: %s" file-path))))
    (message "Error: This buffer is not visiting a file.")))

(defun my/copy-directory-path-to-clipboard ()
  "Copy the current buffer's directory path to the clipboard, replacing the home directory with '~'."
  (interactive)
  (if default-directory
      (let* ((home (expand-file-name "~"))
             (dir-path (if (string-prefix-p home default-directory)
                           (concat "~" (substring default-directory (length home)))
                         default-directory))
             (temp-file (make-temp-file "emacs-clipboard-"))
             (script-path (expand-file-name "~/bin/copy_to_clipboard"))) ;; Adjust script path
        (if (not (file-executable-p script-path))
            (message "Error: Script not found or not executable: %s" script-path)
          (progn
            ;; Write directory path to temporary file
            (with-temp-file temp-file
              (insert dir-path))
            ;; Call the external script with the temporary file as argument
            (call-process script-path nil nil nil temp-file)
            ;; Delete the temporary file
            (delete-file temp-file)
            ;; Display success message
            (message "Directory path copied to clipboard: %s" dir-path))))
    (message "Error: No valid directory found.")))

(defun my/show-region-bytes (&rest _args)
  "Show the size in bytes of the current region in the echo area."
  (interactive)
  (if (use-region-p)
      (message "Region is %d bytes"
               (string-bytes (buffer-substring (region-beginning) (region-end))))
    (message "")))

(defun my/center-text ()
  "Center window text."
  (interactive)
  (let* ((line-length my/custom-cli-line-length)
         (margin (max (/ (- (window-width) line-length 4) 2) 0)))
    (setq left-margin-width (max margin 0))
    (setq right-margin-width (max (/ margin 2) 0))
    (set-window-buffer (selected-window) (current-buffer))))

(defun my/flush-left-text ()
  "Flush text to the left by resetting margins. Also ensuring wrapping rules are applied."
  (interactive)
  (setq left-margin-width 0)  ;; Reset left margin
  (setq right-margin-width 0) ;; Reset right margin
  (let ((line-length my/custom-cli-line-length))
    (setq-default display-fill-column-indicator-column line-length)
    (setq-default fill-column line-length))
  (global-display-fill-column-indicator-mode)
  (set-window-buffer (selected-window) (current-buffer)))

(defvar my/center-text-enabled nil
  "Tracks whether dynamic centering is enabled.")

(defun my/center-text-p ()
  "Reapply centering if globally enabled."
  (when my/center-text-enabled
    (dolist (window (window-list)) ;; Iterate over all windows
      (with-selected-window window
        (my/center-text)))))

(defun my/enable-auto-center-text ()
  "Enable auto-centering dynamically across all windows."
  (interactive)
  (setq my/center-text-enabled t)
  (add-hook 'window-configuration-change-hook #'my/center-text-p)
  (my/center-text-p) ;; Initial application
  )

(defun my/disable-auto-center-text ()
  "Disable auto-centering dynamically across all windows."
  (interactive)
  (setq my/center-text-enabled nil)
  (remove-hook 'window-configuration-change-hook #'my/center-text-p)
  (dolist (window (window-list)) ;; Reset margins for all windows
    (with-selected-window window
      (my/flush-left-text))))

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

(:prefix-map ("C" . "copy to clipboard")
  (:desc "my/copy-to-clipboard" "c" #'my/copy-to-clipboard)
  (:desc "my/copy-file-path-to-clipboard" "f" #'my/copy-file-path-to-clipboard)
  (:desc "my/copy-directory-path-to-clipboard" "d" #'my/copy-directory-path-to-clipboard)
)

(:desc "my/show-region-bytes" "s" #'my/show-region-bytes)

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

             :desc "my/org-archive-done-tasks" "c" #'my/org-archive-done-tasks

             (:prefix-map ("a" . "agenda")
              :desc "my/org-agenda-custom-search-next-action" "n" #'my/org-agenda-custom-search-next-action
              )

             (:prefix-map ("m" . "org-timer")
              :desc "Start timer (Countdown)" "d" #'org-timer-set-timer
              :desc "Start stopwatch" "s" #'org-timer-start
              :desc "Pause/Play" "k" #'org-timer-pause-or-continue
              :desc "Stop" "t" #'org-timer-stop
              :desc "Insert timestamp" "i" #'org-timer
              :desc "Insert list item" "l" #'org-timer-item
              )

             (:prefix-map ("a" . "org-ai")
                          ;; :desc "my/org-agenda-custom-search-next-action" "n" #'my/org-agenda-custom-search-next-action
                          ;; :desc "my/org-agenda-custom-search-next-action" "n" #'my/org-agenda-custom-search-next-action
                          ;; :desc "my/org-agenda-custom-search-next-action" "n" #'my/org-agenda-custom-search-next-action
                          )
             )

(:prefix-map ("w" . "windows")
 :desc "my/sync-line-in-windows-simple" "s" #'my/sync-line-in-windows-simple
 :desc "my/center-text" "c" #'my/center-text
 :desc "my/flush-left-text" "l" #'my/flush-left-text
 :desc "my/enable-auto-center-text" "C" #'my/enable-auto-center-text
 :desc "my/disable-auto-center-text" "L" #'my/disable-auto-center-text

 )

:desc "treemacs-select-window" "t" #'treemacs-select-window

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
