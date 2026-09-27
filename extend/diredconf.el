;;; ...  -*- lexical-binding: t -*-

(setq dired-movement-style 'bounded-files)
;; (setq dired-mouse-drag-files t)

(defun my/dired-create-empty-file ()
  "Wrapper to dired-create-empty-file to avoid minibuffer completion."
  (interactive)
  (let ((search-term
         (read-from-minibuffer "File : ")))
    (dired-create-empty-file search-term)))

(defun my/dired-create-directory ()
  "Wrapper to dired-create-directory to avoid minibuffer completion."
  (interactive)
  (let ((search-term
         (read-from-minibuffer "Dir : ")))
    (dired-create-directory search-term)))
