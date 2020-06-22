  (setq redisplay-dont-pause t
   scroll-margin 10
   scroll-step 1
   scroll-conservatively 1000
   scroll-preserve-screen-position 1)
   (setq package-enable-at-startup nil)
   (require 'cl)
   (setq load-path (remove-if (lambda (x) (string-match-p "org$" x)) load-path))
   (require 'package)
   (setq package-archives
	 '(
	   ("gnu"          . "https://elpa.gnu.org/packages/")
	   ("stable melpa" . "https://stable.melpa.org/packages/")
	   )
	 )
   package-archive-priorities
   '(
     ("gnu elpa"     . 10)
     ("melpa stable" . 5)
     )
     (package-initialize)
	  (unless (package-installed-p 'use-package)
	    (package-refresh-contents)
	    (package-install 'use-package)
	    )
;; test tangle
(setq inhibit-startup-message t)
(global-set-key (kbd "<f5>") 'revert-buffer)
(fset 'yes-or-no-p 'y-or-n-p)
(global-hl-line-mode)
(set-face-background hl-line-face "gray53")
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
      (use-package undo-tree
	:ensure t
	:init
	(global-undo-tree-mode)
	)
       (unless (package-installed-p 'evil)
	 (package-install 'evil)
	 )
(setq evil-want-C-i-jump nil)
       (require 'evil)
       (evil-mode 1)
     (load-theme 'tango-dark)
  (custom-set-variables
  '(org-export-backends (quote (ascii html icalendar latex md org)))
  '(org-src-fontify-natively t)
  '(show-paren-mode t)
  '(show-paren-when-point-inside-paren t)
  )
	(use-package ivy
	 :ensure t
	 :diminish (ivy-mode)
	 :bind (("C-x b" . ivy-switch-buffer))
	 :config
	 (ivy-mode 1)
	 (setq ivy-use-virtual-buffers t)
	 (setq ivy-count-format "%d/%d ")
	 (setq ivy-display-style 'fancy))
	  (use-package counsel
	   :ensure t
	   :bind
	   (("M-y" . counsel-yank-pop)
	    :map ivy-minibuffer-map
	    ("M-y" . ivy-next-line)))
  (use-package swiper
    :ensure t
    :bind (("C-s" . swiper-isearch)
	   ("C-r" . swiper-isearch)
	   ("C-c C-r" . ivy-resume)
	   ("M-x" . counsel-M-x)
	   ("C-x C-f" . counsel-find-file))
    :config
    (progn
      (ivy-mode 1)
      (setq ivy-use-virtual-buffers t)
      (setq ivy-display-style 'fancy)
      (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
      )
   )
   (require 'swiper)
    (setq calendar-week-start-day 1)
  (setq org-adapt-indentation nil)
  (setq org-hide-leading-stars t)
  (global-set-key "\C-cl" 'org-store-link)
  (global-set-key "\C-ca" 'org-agenda)
  (global-set-key "\C-cc" 'org-capture)
  (global-set-key "\C-ct" 'org-insert-structure-template)
  (global-set-key "\C-cp" 'org-fill-paragraph)
  (global-set-key "\C-c\C-xw" 'ispell-word)
		(org-babel-do-load-languages
		 'org-babel-load-languages
		 '(
		   (emacs-lisp . t)
		   (shell . t)
		   (sql . t)
		   )
		 )
  (add-hook 'org-mode-hook 'auto-fill-mode)
  (add-hook 'org-mode-hook 'flyspell-mode)
(define-key evil-motion-state-map (kbd "C-z") nil)
