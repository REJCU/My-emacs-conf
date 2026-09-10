;;; ...  -*- lexical-binding: t -*-

(svg-line-define 'my-mode-line
  :target 'mode-line
  :layout 'lines
  :content (lambda ()
             ;; one or more rows; each is (LEFT . RIGHT) or a
             ;; (:left L :center C :right R) plist for a centred middle
             (list (cons (list (buffer-name))
                         (list (format-mode-line "%l:%c")))))
  :active  #'mode-line-window-selected-p
  :background (lambda () "#e7edf6")
  :foreground (lambda () "#2a4d77"))

(svg-line-activate 'my-mode-line)     ; M-x svg-line-deactivate / svg-line-toggle
