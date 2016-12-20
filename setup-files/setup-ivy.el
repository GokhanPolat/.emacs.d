;; Time-stamp: <2016-12-19 23:38:53 csraghunandan>

;; flx, ivy

;; flx - fuzzy sorting heuristics algorithm
;; needed for sorting the results from fuzzy search in ivy
(use-package flx)

;; ivy
;; incremental narrowing framework for emacs
(use-package ivy
  :diminish ivy-mode
  :init (ivy-mode 1)
  :bind
  (:map ivy-minibuffer-map
        ("C-'" . ivy-avy))
  :config
  ;; C-c C when in ivy minibuffer will copy all the completion candidates to kill ring.
  (bind-key "C-c C" 'ivy-kill-ring-save ivy-minibuffer-map)
  (setq ivy-use-virtual-buffers t
	ivy-height 13
	ivy-initial-inputs-alist nil
	ivy-count-format ""
	ivy-virtual-abbreviate 'full ; Show the full virtual file paths
	ivy-extra-directories nil ; default value: ("../" "./")
        ivy-wrap t)

  (bind-keys
   ("C-c v p" . ivy-push-view)
   ("C-c v o" . ivy-pop-view))

  (setq ivy-re-builders-alist '((swiper . ivy--regex-plus)
                                (t . ivy--regex-fuzzy)))

  ;; Show more information for ivy minibuffer
  (use-package ivy-rich
    :config (ivy-set-display-transformer 'ivy-switch-buffer 'ivy-rich-switch-buffer-transformer)))

(provide 'setup-ivy)

;; ivy
;; * `C-c C-o' to run `ivy-occur' on the results of ivy
;; * when in `ivy-occur' enter wgrep mode by pressing `C-x C-q', to save changes
;; * press `C-x C-s' to save changes or `C-c C-k' to abort changes
;;   when in ivy-minibuffer, press `C-c C' to copy all the completion candidates to kill ring
;; * press C-' when in ivy-minibuffer to use avy to select completion candidates
;; * press `~' when in `counsel-find-file' to go to home directory
;; * press `//' when in `counsel-find-file' to go to root directory
