;; Time-stamp: <2017-01-02 20:56:52 csraghunandan>

;; Theme configuration for emacs
;; https://github.com/bbatsov/zenburn-emacs
(use-package zenburn-theme
  :config
  ;; make zenburn theme look darker by default
  (zenburn-with-color-variables
    (custom-theme-set-faces
     'zenburn
     `(default ((t (:foreground ,zenburn-fg :background ,zenburn-bg-05))))))

  ;; make function face brighter so it's easily distinguishable from font-lock face for types
  (set-face-attribute 'font-lock-function-name-face nil :foreground "CadetBlue1")
  ;; fontify links to make them standout
  (set-face-attribute 'link nil :foreground "#C9B8A2" :underline nil :weight 'normal)
  (set-face-attribute 'link-visited nil :foreground "#C9AE8C" :underline nil :weight 'normal)
  ;; make everything look gray :)
  (set-face-attribute 'font-lock-comment-delimiter-face nil :foreground "gray55")
  (set-face-attribute 'font-lock-comment-face nil :foreground "gray55" :slant 'italic)
  (set-face-attribute 'font-lock-doc-face nil :foreground "gray70" :slant 'italic)
  (set-face-background 'shm-current-face "#444444")
  (set-face-attribute 'hl-line nil :background "#444444")
  (set-face-attribute 'fringe nil :background "#444444")
  (set-face-attribute 'vhl/default-face nil :background "#444444")

  ;; make mode line look pretty :)
  (set-face-attribute 'mode-line nil :box '(:line-width 2 :color "gray30")
                      :weight 'normal :foreground "#C8F7C8" :background "gray20")
  (set-face-attribute 'mode-line-inactive nil :box '(:line-width 2 :color "gray30")
                      :weight 'normal :foreground "gray70")
  (set-face-attribute 'powerline-active2 nil :background "gray32")
  (set-face-attribute 'powerline-active1 nil :background "gray32" :weight 'normal)
  (set-face-attribute 'mode-line-buffer-id nil :foreground "#FFECBA" :weight 'bold)
  ;; dim inactive modeline
  (set-face-attribute 'powerline-inactive2 nil :background "gray20")
  (set-face-attribute 'powerline-inactive1 nil :background "gray32")

  ;; contrasting colors for ivy minibuffer match results
  (set-face-attribute 'ivy-minibuffer-match-face-4 nil :background "pink4")
  (set-face-attribute 'ivy-minibuffer-match-face-3 nil :background "CadetBlue4")
  (set-face-attribute 'ivy-minibuffer-match-face-2 nil :background "DarkSeaGreen4"))

(provide 'setup-zenburn)