;;; ...  -*- lexical-binding: t -*-

;; org-mode - as large, could export to another file
(use-package org
  :mode (("\\.org" . org-mode))
  :init
  (setq org-return-follows-link t))

(setq org-agenda-files '("~/org/"))


