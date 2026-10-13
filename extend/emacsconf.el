;;; ...  -*- lexical-binding: t -*-

(setq grep-find-template
      "find <D> <X> -type f <F> -exec grep <C> -nH -e <R> \\{\\} +")

(setopt grep-command
      "grep --color=auto -rnH --null -e")

(defun rye-grep (command-args)
  "Run Grep with user-specified COMMAND-ARGS.
The output from the command goes to the \"*grep*\" buffer.

While Grep runs asynchronously, you can use \\[next-error] (M-x next-error),
or \\<grep-mode-map>\\[compile-goto-error] in the *grep* \
buffer, to go to the lines where Grep found
matches.  To kill the Grep job before it finishes, type \\[kill-compilation].

Noninteractively, COMMAND-ARGS should specify the Grep command-line
arguments.

For doing a recursive `grep', see the `rgrep' command.  For running
Grep in a specific directory, see `lgrep'.

This command uses a special history list for its COMMAND-ARGS, so you
can easily repeat a grep command.

A prefix argument says to default the COMMAND-ARGS based on the current
tag the cursor is over, substituting it into the last Grep command
in the Grep command history (or into `grep-command' if that history
list is empty)."
  (interactive
   (progn
     (require 'grep)
     (when (fboundp 'grep-compute-defaults)
       (grep-compute-defaults))
     (list (read-shell-command
            "Grep: "
            ""
            'grep-history
            (if (fboundp 'grep-default-command)
                (if current-prefix-arg
                    nil
                  (grep-default-command))
              nil)))))

  (require 'grep)
  (require 'files-x) ; null-device
  (let* ((default (if (fboundp 'grep-default-command)
                      (grep-default-command)
                    ""))
         (base-command (if current-prefix-arg
                           default
                         (if (and (boundp 'grep-command-position)
                                  grep-command-position
                                  (boundp 'grep-command)
                                  (stringp grep-command)
                                  (>= (length grep-command)
                                      grep-command-position))
                             (substring grep-command 0 grep-command-position)
                           (if (boundp 'grep-command)
                               grep-command
                             ""))))
         (grep-arguments (concat base-command " " command-args)))
    ;; If called non-interactively, also compute the defaults if we haven't
    ;; already.
    (when (and (boundp 'grep-highlight-matches)
               (eq grep-highlight-matches 'auto-detect)
               (fboundp 'grep-compute-defaults))
      (grep-compute-defaults))
    (when (fboundp 'grep--save-buffers)
      (grep--save-buffers))
    ;; Setting process-setup-function makes exit-message-function work even
    ;; when async processes aren't supported.
    (when (fboundp 'grep-mode)
      (compilation-start
       (let ((null-device (when (fboundp 'null-device)
                            (null-device))))
         (if (and (bound-and-true-p grep-use-null-device)
                  null-device)
             (concat grep-arguments " " null-device)
           grep-arguments))
       #'grep-mode))))
