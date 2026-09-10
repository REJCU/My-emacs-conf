;;; ...  -*- lexical-binding: t -*-
;; container development

(defcustom lemacs-docker-executable 'docker
  "The executable to be used with docker-mode"
  :type '(choice
	  (const :tag "docker" docker)
	  (const :tag "podman"))
  :group 'lemacs)

(use-package docker
	:defer t
	:ensure t
	:bind ("C-c d" . docker)
	:config
	(pcase lemacs-docker-executable
	  ('docker
	   (setf docker-command "docker"
			 docker-compose-command "docker-compose"
			 docker-container-tramp-method "docker"))
	  ('podman
	   (setf docker-command "podman"
			 docker-compose-command "podman-compose"
			 docker-container-tramp-method "podman"))))


