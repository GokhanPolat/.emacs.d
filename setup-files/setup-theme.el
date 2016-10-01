(use-package zenburn-theme
  :config (load-theme 'zenburn t))

(use-package rainbow-delimiters
  :config (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

;; Better defaults for emacs
(column-number-mode t)
(line-number-mode t)
(tool-bar-mode -1)
(setq display-time-day-and-date t)
(setq display-time-default-load-average nil)
(display-time-mode t)
(display-battery-mode t)
(set-frame-font "PragmataPro 13")
(setq ring-bell-function 'ignore)
;; resize minibuffer window to accommodate text
(setq resize-mini-window t)
;; (setq enable-recursive-minibuffers t)
(setq inhibit-splash-screen t)
(setq initial-scratch-message ";; Let the games begin.\n\n")
(setq-default cursor-type '(bar . 1))
(blink-cursor-mode -1)
(scroll-bar-mode -1)
(fringe-mode '(8 . 8))
;; Do not make mouse wheel accelerate its action (example: scrolling)
(setq mouse-wheel-progressive-speed nil)

;; Remove background for fringe
(set-face-attribute 'fringe nil :background "gray21")
(set-face-attribute 'mode-line nil :box nil)
(set-face-attribute 'mode-line-inactive nil :box 'nil)
(provide 'setup-theme)
