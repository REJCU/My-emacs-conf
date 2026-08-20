;;; -*- lexical: t -*-
;; package list 
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;Remove UI
(menu-bar-mode -1)
(tool-bar-mode -1)


;; QOL
(global-display-line-numbers-mode 1)
(recentf-mode 1)
(save-place-mode 1)
(setq compilation-ask-about-save nil)

;; 
(scroll-bar-mode -1)

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

;; Isearch
(setopt isearch-lazy-count t)

; custom-file placement 
(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file '
      noerror 'nomessage)

; refresh buffer when underlying file has changed 
(global-auto-revert-mode t)
; same for dired
(setq global-auto-revert-non-file-buffers t)

;ido-mode emacs
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; Make a whole list of custom keymaps 
;; TODO -
;; binds recompile to keymap

(unbind-key "C-q")
(dolist (map (list global-map))
  (keymap-set global-map "C-q r" #'recompile)
  (keymap-set global-map "C-q c" #'compile)
  (keymap-set global-map "C-q n" #'next-error)
  (keymap-set global-map "C-q e" #'eval-buffer))

;; commenting region
  (global-set-key [f9] 'comment-region)
  (global-set-key [f10] 'uncomment-region)

  
;; recommended structure for if i want different keybinds for different files C vs Rust
;; compile vs open up term and python - i guess


(global-set-key (kbd "<f1>") '5x5)

(defvar com-keymaps
  (let ((map (make-sparse-keymap)))
    (define-key map "s" 'shell)
    (define-key map "g" 'rgrep)
    map)
  "my keymap")

;; --- Dashboard --- 

;; Move Customization Variables To A Separate File And Load It
;; (Setqtartup-Hook))

;; Dashboard
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-startup-banner "~/.emacs.d/splash/cat.txt")
  (setq dashboard-center-content t)
  (setq initial-buffer-choice 'dashboard-open) ;; infernal scratch-pad 
  (setq dashboard-vertically-center-content t)
  (setq dashboard-navigation-cycle t)
  (setq dashboard-heading-shorcut-format " [%s]")
  (setq dashboard-display-icons-p t)
  (setq dashboard-icon-type 'nerd-icons)
  (setq dashboard-items '((recents   . 5)
                          (bookmarks . 5)
                          (projects  . 5)
                          (agenda    . 5)
                          (registers . 5)))
  (setq dashboard-item-shortcuts '((recents   . "r")
                                    (bookmarks . "m")
                                    (projects  . "p")
                                    (agenda    . "a")
                                    (registers . "e")))
  (setq dashboard-startupify-list '(dashboard-insert-banner
                                    dashboard-insert-newline
                                    dashboard-insert-newline
                                    dashboard-insert-banner-title
                                    dashboard-insert-navigator
                                    dashboard-insert-newline
                                    dashboard-insert-init-info
                                    dashboard-insert-items
                                    dashboard-insert-newline
                                    dashboard-insert-footer)))



;; fonts
(set-frame-font "Iosevka")

(add-to-list 'default-frame-alist '(font ."Iosevka"))
(set-face-attribute 'default nil :font "Iosevka" :height 108)
(set-face-attribute 'fixed-pitch nil :family "Iosevka")


(when (member "Iosevka" (font-family-list))
  (set-face-attribute 'variable-pitch nil :family "Iosevka" :height 1.18))

;; nerd-icons
(use-package nerd-icons
  :ensure t)

(use-package nerd-icons-completion
  :ensure t
  :after marginalia
  :config
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))

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

;;For Kanagawa
;; (use<>-package kanagawa-themes
;;   :ensure t
;;   :config (load-theme 'kanagawa-wave))

; ef-themes 
(use-package ef-themes
  :ensure t
  :config
  (modus-themes-load-theme 'ef-day))


 
; stop highlight when changing theme
;; (dolist (face '(font-lock-keyword-face
;; 		font-lock-function-name-face
;; 		font-lock-variable-name-face
;; 		font-lock-type-face
;; 		font-lock-constant-face
;; 		font-lock-builtin-face
;; 		font-lock-preprocessor-face
;; 		font-lock-string-face
;; 		font-lock-comment-face
;; 		font-lock-doc-face
;; 		elisp-shorthand-font-lock-face
;; 		highlight-quoted-symbol
;; 		highlight-quoted-keyword
;; 		highlight-numbers-number))
;;   (when (facep face)
;;     (set-face-attribute face nil :background 'unspecified :box nil)))


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
         (latex-mode  . eglot-ensure)  ; built-in tex-mode's LaTeX mode
         (qml-ts-mode . eglot-ensure)
         (lua-ts-mode . eglot-ensure))

  
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
               '((LaTeX-mode latex-mode) . ("texlab")))
  (add-to-list 'eglot-server-programs
	       '(qml-ts-mode  . ("qmlls6" "-E"))))

(use-package treesit-auto
  :ensure t
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(use-package markdown-mode
  :ensure t
  :mode ("\\.md\\'" . markdown-mode) ; Use GitHub Flavored Markdown for READMEs
  :init (setq markdown-command "multimarkdown") ; Or "pandoc" / "markdown"
  :bind (:map markdown-mode-map
	      ("C-c C-e" . markdown-do))
  :config
  (setq markdown-header-scaling t) ; Make headers larger than body text
  (setq markdown-italic-underscore t)) ; Allow _italic_ as well as *italic*

;; for 


(use-package pet
  :ensure t
  :hook (python-base-mode . pet-mode))

(projectile-mode +1)
;; Recommended keymap prefix on Windows/Linux
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(setq projectile-project-search-path '("~/UNI/" "~/c_projects/" "~/cpp_projects/" "~/UNI/DeepLearning/" "~/.config/home-manager/" "~/ryquick/"))
				       
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

(use-package cape
  :bind ("C-c p" . cape-prefix-map)

  :init
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block)
)

;; Quickshell
(add-to-list 'load-path "~/.emacs.d/site-lisp/qml-ts-mode")

(use-package qml-ts-mode
  :mode "\\.qml\\'"
  :hook (qml-ts-mode . (lambda ()
                         (setq-local electric-indent-chars '(?\n ?\( ?\) ?{ ?} ?\[ ?\] ?\; ?,)))))

(setq treesit-language-source-alist
      '((qmljs . ("https://github.com/yuja/tree-sitter-qmljs"))))



