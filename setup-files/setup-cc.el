;; Timestamp: <2017-07-22 13:53:13>
;; all the configuration for C/C++ projects

;;; features:
;; Source code navigation using RTags
;; Source code completion using Irony
;; Syntax checking with Flycheck
;; CMake automation with cmake-ide
;; C/C++ code disassembler using disaster
;; modern C++ font-lock support

(use-package cc-mode :defer t
  :config

  ;; A c/c++ client/server indexer for c/c++/objc[++] with integration for Emacs
  ;; based on clang.
  ;; https://github.com/Andersbakken/rtags
  (use-package rtags
    :config

    (rtags-enable-standard-keybindings)

    ;; ivy completion frontend for rtags
    (use-package ivy-rtags
      :config
      (setq rtags-display-result-backend 'ivy))

    ;; start the rtags process automatically if it's not started
    ;; (add-hook 'c-mode-hook 'rtags-start-process-unless-running)
    ;; (add-hook 'c++-mode-hook 'rtags-start-process-unless-running)
    )

  ;; cmake-ide: Use Emacs as a C/C++ IDE
  ;; https://github.com/atilaneves/cmake-ide
  ;; (use-package cmake-ide
  ;;   :config (cmake-ide-setup))

  ;; cmake-mode: major-mode for editing cmake files
  (use-package cmake-mode :defer t
    :config
    ;; cmake-font-lock: emacs font lock rules for CMake
    ;; https://github.com/Lindydancer/cmake-font-lock
    (use-package cmake-font-lock
      :config
      (autoload 'cmake-font-lock-activate "cmake-font-lock" nil t)
      (add-hook 'cmake-mode-hook 'cmake-font-lock-activate)))

  ;; irony: A C/C++ minor mode for Emacs powered by libclang
  ;; https://github.com/Sarcasm/irony-mode
  (use-package irony
    :config
    ;; company backend for irony completion server
    ;; https://github.com/Sarcasm/company-irony
    (use-package company-irony)
    ;; completions for C/C++ header files
    ;; https://github.com/hotpxl/company-irony-c-headers
    (use-package company-irony-c-headers)

    (defun my-irony-mode-hook ()
      (define-key irony-mode-map [remap completion-at-point]
        'irony-completion-at-point-async)
      (define-key irony-mode-map [remap complete-symbol]
        'irony-completion-at-point-async))

    (add-hook 'irony-mode-hook 'my-irony-mode-hook)
    (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

    (add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)
    (setq company-backends (delete 'company-semantic company-backends))

    (defun my-c-mode-hook ()
      (set (make-local-variable 'company-backends)
           '((company-irony-c-headers company-irony company-files company-yasnippet))))

    (add-hook 'c++-mode-hook #'my-c-mode-hook)
    (add-hook 'c-mode-hook #'my-c-mode-hook)

    (use-package flycheck-irony
      :config
      (defun +cc|init-c++14-clang-options ()
        (make-local-variable 'irony-additional-clang-options)
        (cl-pushnew "-std=c++14" irony-additional-clang-options :test 'equal))
      (add-hook 'c++-mode-hook #'+cc|init-c++14-clang-options)

      (eval-after-load 'flycheck
        '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup)))

    ;; irony-eldoc: eldoc support for irony
    ;; https://github.com/ikirill/irony-eldoc
    (use-package irony-eldoc
      :config (add-hook 'irony-mode-hook #'irony-eldoc)))

  (defun +cc|extra-fontify-c++ ()
    ;; We could place some regexes into `c-mode-common-hook', but
    ;; note that their evaluation order matters.
    ;; NOTE modern-cpp-font-lock will eventually supercede some of these rules
    (font-lock-add-keywords
     nil '(;; c++11 string literals
           ;;       L"wide string"
           ;;       L"wide string with UNICODE codepoint: \u2018"
           ;;       u8"UTF-8 string", u"UTF-16 string", U"UTF-32 string"
           ("\\<\\([LuU8]+\\)\".*?\"" 1 font-lock-keyword-face)
           ;;       R"(user-defined literal)"
           ;;       R"( a "quot'd" string )"
           ;;       R"delimiter(The String Data" )delimiter"
           ;;       R"delimiter((a-z))delimiter" is equivalent to "(a-z)"
           ("\\(\\<[uU8]*R\"[^\\s-\\\\()]\\{0,16\\}(\\)" 1 font-lock-keyword-face t) ; start delimiter
           (   "\\<[uU8]*R\"[^\\s-\\\\()]\\{0,16\\}(\\(.*?\\))[^\\s-\\\\()]\\{0,16\\}\"" 1 font-lock-string-face t)  ; actual string
           (   "\\<[uU8]*R\"[^\\s-\\\\()]\\{0,16\\}(.*?\\()[^\\s-\\\\()]\\{0,16\\}\"\\)" 1 font-lock-keyword-face t) ; end delimiter
           ) t))

  (add-hook 'c++-mode-hook #'+cc|extra-fontify-c++) ; fontify C++11 string literals

  ;; adds font-lock highlighting for modern C++ upto C++17
  (use-package modern-cpp-font-lock
    :config (modern-c++-font-lock-global-mode t))

  ;; clang-format: format C/C++ files using clang-format
  (use-package clang-format
    :if (executable-find "clang-format")
    :config
    (add-hook 'c++-mode-hook
              (lambda ()
                (add-hook 'before-save-hook
                          (lambda ()
                            (time-stamp)
                            (clang-format-buffer)) nil t)))
    (add-hook 'c-mode-hook
              (lambda ()
                (add-hook 'before-save-hook
                          (lambda ()
                            (time-stamp)
                            (clang-format-buffer)) nil t))))

  ;; configure autocompletions for C/C++ using irony
  (add-hook 'c++-mode-hook 'company-mode)
  (add-hook 'c-mode-hook 'company-mode)
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)

  (add-hook 'c++-mode-hook 'flycheck-mode)
  (add-hook 'c-mode-hook 'flycheck-mode)

  (add-hook 'c++-mode-hook 'smart-dash-mode)
  (add-hook 'c-mode-hook 'smart-dash-mode)

  ;; https://github.com/Fuco1/smartparens/issues/815
  ;; remove this once this issue is fixed for emacs master
  (>=e "26.0"
      (sp-local-pair 'c-mode "'" nil :actions nil))
  (>=e "26.0"
      (sp-local-pair 'c++-mode "'" nil :actions nil))

  (c-add-style "llvm"
               '("gnu"
	         (fill-column . 80)
	         (c++-indent-level . 4)
	         (c-basic-offset . 4)
	         (indent-tabs-mode . nil)
	         (c-offsets-alist . ((arglist-intro . ++)
				     (innamespace . 0)
				     (member-init-intro . ++)))))

  (setq-default c-default-style "llvm"))

(provide 'setup-cc)

;;; notes
;; To have cmake-ide automatically create a compilation commands file in your
;; project root create a .dir-locals.el containing the following:
;; ((nil . ((cmake-ide-build-dir . "<PATH_TO_PROJECT_BUILD_DIRECTORY>"))))
