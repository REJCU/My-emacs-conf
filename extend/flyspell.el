;;; ...  -*- lexical-binding: t -*-
(setq ispell-program-name "aspell")
(setq ispell-dictionary "en_AU")
(setq ispell-quietly t)
(setq ispell-extra-args '("--sug-mode=ultra"))

(defun my-flyspell-prog-mode (&rest _args)
  "Enable `flyspell-prog-mode' with buffer-local Aspell arguments."
  ;; The --run-together flag instructs Aspell to accept words formed by
  ;; combining two or more valid dictionary words without spaces, treating the
  ;; resulting string as valid.
  ;;
  ;; This is excellent for source code. Code is heavily populated with
  ;; compound variable names and technical terms (e.g., filepath, buffername,
  ;; checkbox).
  ;; URL: https://www.jamescherti.com/emacs-spell-checker-flyspell-ispell-aspell/
  (make-local-variable 'ispell-extra-args)
  (dolist (item '("--run-together"
                  ;; "--ignore=2"
                  ;; "--run-together-min=3"
                  ;; "--run-together-limit=4"
                  ;; "--camel-case"
                  ))
    (add-to-list 'ispell-extra-args item))
  (flyspell-prog-mode))


;; The flyspell package is a built-in Emacs minor mode that provides on-the-fly
;; spell checking. It highlights misspelled words as you type, offering
;; interactive corrections.
;; URL: https://www.jamescherti.com/emacs-spell-checker-flyspell-ispell-aspell/
(defun my-flyspell-enable-appropriate-mode ()
  "Enable the appropriate Flyspell mode based on the current major mode."
  (if (or (derived-mode-p 'conf-mode)
          (derived-mode-p 'yaml-mode)
          (derived-mode-p 'yaml-ts-mode)
          (derived-mode-p 'ansible-mode)
          (derived-mode-p 'nxml-mode)
          (derived-mode-p 'sgml-mode))
      (my-flyspell-prog-mode)
    (flyspell-mode 1)))

(add-hook 'prog-mode-hook #'my-flyspell-prog-mode)
(add-hook 'conf-mode-hook #'my-flyspell-enable-appropriate-mode)
(add-hook 'text-mode-hook #'my-flyspell-enable-appropriate-mode)
