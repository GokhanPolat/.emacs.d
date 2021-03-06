;; Time-stamp: <2017-08-16 01:16:23 csraghunandan>

;; web-mode: major-mode for editing multiple web formats
;; http://web-mode.org/ , https://github.com/fxbois/web-mode
(use-package web-mode
  :mode (("\\.html$" . web-mode)
         ("\\.djhtml$" . web-mode)
         ("\\.tsx$" . web-mode))
  :bind (:map web-mode-map
         ("C-c o b" . browse-url-of-file)
         ("C-c [" . emmet-prev-edit-point)
         ("C-c ]" . emmet-next-edit-point))
  :config
  ;; highlight matching tag
  (setq web-mode-enable-current-element-highlight t)

  (defun my-tide-setup-hook ()
    ;; configure tide
    (tide-setup)
    ;;enable eldoc-mode
    (eldoc-mode)
    ;; enable flycheck
    (flycheck-mode)

    ;; company-backends setup
    (set (make-local-variable 'company-backends)
         '((company-tide company-files company-yasnippet))))

  (add-hook 'web-mode-hook
            (lambda ()
              (when (string-equal "tsx" (file-name-extension buffer-file-name))
                (my-tide-setup-hook))))

  (defun my-web-mode-hook ()
    "Hook for `web-mode'."
    (set (make-local-variable 'company-backends)
         '((company-tern company-css company-web-html company-files))))
  (unless (string-equal "tsx" (file-name-extension buffer-file-name))
    (add-hook 'web-mode-hook 'my-web-mode-hook))

  (add-hook 'web-mode-hook 'smartparens-mode)

  ;; Enable JavaScript completion between <script>...</script> etc.
  (defadvice company-tern (before web-mode-set-up-ac-sources activate)
    "Set `tern-mode' based on current language before running company-tern."
    (message "advice")
    (if (equal major-mode 'web-mode)
        (let ((web-mode-cur-language
               (web-mode-language-at-pos)))
          (if (or (string= web-mode-cur-language "javascript")
                 (string= web-mode-cur-language "jsx"))
              (unless tern-mode (tern-mode))
            (if tern-mode (tern-mode -1))))))
  (add-hook 'web-mode-hook 'company-mode)

  ;; ac-html-boostrap: bootstrap3 completions backend
  ;; https://github.com/osv/ac-html-bootstrap
  (use-package ac-html-bootstrap :defer t)

  ;; company-web: to get completion for HTML stuff
  ;; https://github.com/osv/company-web
  (use-package company-web)

  ;; emmet-mode: dynamic snippets for HTML
  ;; https://github.com/smihica/emmet-mode
  (use-package emmet-mode
    :init (setq emmet-move-cursor-between-quotes t) ;; default nil
    :diminish (emmet-mode . "𝐄𝐦"))
  ;; start emmet mode after web-mode launches
  (add-hook 'web-mode-hook 'emmet-mode)

  ;; colorize colors in buffers
  (setq web-mode-enable-css-colorization t))

;; impatient mode: Live refresh of web pages
;; https://github.com/skeeto/impatient-mode
(use-package impatient-mode :defer t
  :diminish (impatient-mode . "𝐈𝐦")
  :commands (impatient-mode))

(provide 'setup-web-mode)
