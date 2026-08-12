; melpa package list
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;Remove UI
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; QOL
(global-display-line-numbers-mode 1)
(recentf-mode 1)
(save-place-mode 1)
(setq compilation-ask-about-save nil)

;; 

; increase proccess output buffer for LSP
(setq read-process-output-max (* 4 1024 1024))

;; dont render cursors in non-focused windows
(setq-default cursor-in-non-selected-windows nil)
(setq highlight-nonselected-windows nil)

;; save external clipboard content before killing
(setq save-interprogram-paste-before-kill t)

; dont save duplicates
(setq kill-do-not-save-duplicates t)

; bash shebang - auto-chmod scripts on save 
(add-hook 'after-save-hook
	  #'executable-make-buffer-file-executable-if-script-p)

; sane syntax in re-builder - M-x  re-builder
(setq reb-re-syntax 'string)

;; minibuffer prompts
(setq history-length 15)
(savehist-mode 1)

;; Windows
; proportional window resizing 
(setq window-combination-resize t)

; makes popping repeated from c-u c-spc to just c-spc after one
(dashboard-setup-startup-hook)

; custom-file placement 
(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file '
      noerror 'nomessage)

; refresh buffer when underlying file has changed 
(global-auto-revert-mode t)
; same for dired
(setq global-auto-revert-non-file-buffers t)

;; Move Customization Variables To A Separate File And Load It
;; (Setqtartup-Hook))
 
;; dashboard
;;(setq dashboard-banner-logo-title"Emacs")
(setq set-mark-command-repeat-pop t)
(setq dashboard-startup-banner "~/Picture/Asci/cat.txt")
(setq dashboard-center-content t)
(setq dashboard-vertically-center-content t)

(setq dashboard-items '((recents   . 5)
                        (bookmarks . 5)
                        (projects  . 5)
                        (agenda    . 5)
                        (registers . 5)))

(setq dashboard-startupify-list '(dashboard-insert-banner
                                  dashboard-insert-newline
                                  dashboard-insert-newline
                                  dashboard-insert-banner-title
                                  dashboard-insert-navigator
                                  dashboard-insert-newline
                                  dashboard-insert-init-info
                                  dashboard-insert-items
                                  dashboard-insert-newline
                                  dashboard-insert-footer))

(setq dashboard-navigation-cycle t)
(setq dashboard-heading-shorcut-format " [%s]")

(setq dashboard-item-shortcuts '((recents   . "r")
                                 (bookmarks . "m")
                                 (projects  . "p")
                                 (agenda    . "a")
                                 (registers . "e")))

(setq dashboard-display-icons-p t)     ; display icons on both GUI and terminal
(setq dashboard-icon-type 'nerd-icons) ; use `nerd-icons' package
(add-to-list 'dashboard-items '(agenda) t)

;; Font

(when (member "Roboto Mono" (font-family-list))
  (set-face-attribute 'default nil :font "Roboto Mono" :height 108)
  (set-face-attribute 'fixed-pitch nil :family "Roboto Mono"))

(when (member "Source Sans Pro" (font-family-list))
  (set-face-attribute 'variable-pitch nil :family "Source Sans Pro" :height 1.18))

;; nerd-icons
(use-package nerd-icons
  :ensure t)

(use-package nerd-icons-completion
  :ensure t
  :after marginalia
  :config
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))

(use-package nerd-icons-corfu
  :ensure t
  :after corfu
  :config
  (Addto-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

(use-package nerd-icons-dired
  :ensure t
  :hook
  (dired-mode . nerd-icons-dired-mode))

;; corfu
(use-package corfu
  ;; Optional customizations
  :custom
  (corfu-auto t)
  (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  (corfu-auto-prefix 2)
  ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  ;; (corfu-preview-current nil)    ;; Disable current candidate preview
  ;; (corfu-preselect 'prompt)      ;; Preselect the prompt
  ;; (corfu-on-exact-match 'insert) ;; Configure handling of exact matches

  ;; Enable Corfu only for certain modes. See also `global-corfu-modes'.
  ;; :hook ((prog-mode . corfu-mode)
  ;;        (shell-mode . corfu-mode)
  ;;        (eshell-mode . corfu-mode))

  :init

  ;; Recommended: Enable Corfu globally.  Recommended since many modes provide
  ;; Capfs and Dabbrev can be used globally (M-/).  See also the customization
  ;; variable `global-corfu-modes' to exclude certain modes.
  (global-corfu-mode)

  ;; Enable optional extension modes:
  (corfu-history-mode)
  (corfu-popupinfo-mode)
  )

;; Enable Vertico for vertical minibuffer completion (M-x, C-x b, C-x C-f, etc.)
(use-package vertico
  :ensure t
  :init
  (vertico-mode 1)
  :custom
  (vertico-cycle t)            ; Enable cycling through candidates
  (vertico-count 15))          ; Show 15 candidates at once

;; Add rich annotations/descriptions in the minibuffer margin (next to M-x options)
(use-package marginalia
  :ensure t
  :init
  (marginalia-mode 1))


;; A few more useful configurations...
(use-package emacs
  :custom
  ;; TAB cycle if there are only few candidates
  (completion-cycle-threshold 3)

  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (tab-always-indent 'complete)

  ;; Emacs 30 and newer: Disable Ispell completion function.
  ;; Try `cape-dict' as an alternative.
  (text-mode-ispell-word-completion nil)

  ;; Hide commands in M-x which do not apply to the current mode.  Corfu
  ;; commands are hidden, since they are not used via M-x. This setting is
  ;; useful beyond Corfu.
  (read-extended-command-predicate #'command-completion-default-include-p))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles . (partial-completion))))))

;; which key
(use-package which-key
  :ensure t
  :init (which-key-mode))

;; For Kanagawa
(use-package kanagawa-themes
  :ensure t
  :config (load-theme 'kanagawa-wave t))

(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-one t))

  
(use-package exec-path-from-shell
  :ensure t
  :if (memq window-system '(mac ns x))
  :config
  (exec-path-from-shell-initialize))

(use-package eglot
  :ensure nil
  :hook ((c-mode      . eglot-ensure)
         (c-ts-mode   . eglot-ensure)
         (c++-mode    . eglot-ensure)
         (c++-ts-mode . eglot-ensure)
         (python-mode    . eglot-ensure)
         (python-ts-mode . eglot-ensure)
         (mhtml-mode  . eglot-ensure)
         (html-ts-mode . eglot-ensure)
         (LaTeX-mode  . eglot-ensure)   ; AUCTeX's mode
         (latex-mode  . eglot-ensure))  ; built-in tex-mode's LaTeX mode
  :bind (:map eglot-mode-map
              ("C-c l r" . eglot-rename)
              ("C-c l a" . eglot-code-actions)
              ("C-c l f" . eglot-format))
  :config
  (add-hook 'before-save-hook
            (lambda () (when (eglot-managed-p) (eglot-format-buffer))))
  (add-to-list 'eglot-server-programs
               '((python-mode python-ts-mode) . ("pyright-langserver" "--stdio")))
  (add-to-list 'eglot-server-programs
               '((LaTeX-mode latex-mode) . ("texlab"))))

(use-package treesit-auto
  :ensure t
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode) ; Use GitHub Flavored Markdown for READMEs
  :init (setq markdown-command "multimarkdown") ; Or "pandoc" / "markdown"
  :config
  (setq markdown-header-scaling t) ; Make headers larger than body text
  (setq markdown-italic-underscore t)) ; Allow _italic_ as well as *italic*

(use-package pet
  :ensure t
  :hook (python-base-mode . pet-mode))

(projectile-mode +1)
;; Recommended keymap prefix on Windows/Linux
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; avy movement
(use-package avy
  :ensure t
  :bind
  ;; Jump to any character (Type C-s, then the char, then the avy-key)
  ("C-;" . avy-goto-char-timer)
  ;; Jump to any line
  ("M-g g" . avy-goto-line)
  ;; Jump to a word
  ("M-g w" . avy-goto-word-1)
  :config
  ;; Customization: Make the keys appear in the center of the screen
  (setq avy-all-windows t)
  
  (setq avy-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)))

(setq dired-listing-switches "-alh")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("d2ab3d4f005a9ad4fb789a8f65606c72f30ce9d281a9e42da55f7f4b9ef5bfc6"
     "745f8c882e6edae45476e93f7b47c5bd4a4dc98c65494672ddcd291359935a3a"
     "8899e88d19a37d39c7187f4bcb5bb596fba990728ef963420b93e2aea5d1666a"
     "3aa51468052c1e3e21dd41a3fa40c0161e07ca600683e3d96f1bca70f36749e2"
     "3b2ae1d19f5843cdc5833266b76e6367744932d96c5ddd713ede9797a2bd93fe"
     "daa27dcbe26a280a9425ee90dc7458d85bd540482b93e9fa94d4f43327128077"
     default))
 '(package-selected-packages nil)
 '(warning-suppress-types '((use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


