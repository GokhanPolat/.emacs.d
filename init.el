;; Time-stamp: <2017-12-02 15:09:50 csraghunandan>
;; Author: C S Raghunandan

;; https://www.reddit.com/r/emacs/comments/3kqt6e/2_easy_little_known_steps_to_speed_up_emacs_start/
(defvar gc-cons-threshold--orig gc-cons-threshold)
(setq gc-cons-threshold (* 100 1024 1024))

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)

;; load directory for configuration files for emacs
(add-to-list 'load-path (concat user-emacs-directory "setup-files/"))
(add-to-list 'load-path (concat user-emacs-directory "my-elisp-code"))

;; set home and emacs directories
(defvar user-home-directory (concat (getenv "HOME") "/"))
(setq user-emacs-directory (concat user-home-directory ".emacs.d/"))

;; save custom file to a separate directory
(setq custom-file (concat user-emacs-directory "my-elisp-code/custom-settings.el"))
(load custom-file :noerror :nomessage) ; load custom-file silently
(load (locate-user-emacs-file "general.el") nil :nomessage)



(unless (package-installed-p 'use-package) ; unless it is already installed
  (package-refresh-contents) ; updage packages archive
  (package-install 'use-package)) ; install the latest version of use-package
(eval-when-compile (require 'use-package))
(setq use-package-always-ensure t)

;; add imenu support for use-package declarations
(setq use-package-enable-imenu-support t)

;; diminish-mode: to hide minor modes in mode-line
;; https://github.com/emacsmirror/diminish
(use-package diminish
  :ensure t)

(require 'setup-osx)
(require 'setup-org)
(require 'setup-backup)
(require 'setup-selected)
(require 'setup-treemacs)
(require 'setup-search)
(require 'setup-ibuffer)
(require 'setup-recentf)
(require 'setup-desktop)
(require 'setup-calc)
(require 'setup-ediff)
(require 'setup-dired)
(require 'setup-elisp-mode)
(require 'setup-fly)
(require 'setup-bookmark)
(require 'setup-hydra)
(require 'setup-company)
(require 'setup-smartparens)
(require 'setup-git-stuff)
(require 'setup-avy)
(require 'setup-ace-window)
(require 'setup-projectile)
(require 'setup-yas)
(require 'setup-buffers)
(require 'setup-ivy)
(require 'setup-counsel)
(require 'setup-swiper)
(require 'setup-movement)
(require 'setup-markdown)
(require 'setup-highlight)
(require 'setup-info)
(require 'setup-mode-line)
(require 'setup-editing)
(require 'setup-racket)
(require 'setup-hungry-delete)
(require 'setup-rust)
(require 'setup-cc)
(require 'setup-haskell)
(require 'setup-python)
(require 'setup-tex)
(require 'setup-origami)
(require 'setup-duplicate-line)
(require 'setup-white-space)
(require 'setup-mc)
(require 'setup-js)
(require 'setup-typescript)
(require 'setup-ocaml)
(require 'setup-web-mode)
(require 'setup-css)
(require 'setup-eshell)
(require 'setup-comint)
(require 'setup-term)
(require 'setup-which-key)
(require 'setup-kurecolor)
(require 'setup-erc)
(require 'setup-font-check)
(require 'setup-misc)
(require 'setup-visual)
(require 'setup-tramp)
(require 'setup-zenburn)
(require 'setup-command-log-mode)
(require 'setup-calendar)
(require 'setup-minibuffer)
(require 'setup-purescript)
(require 'setup-abbrev)
(require 'setup-quickrun)
(require 'setup-macro)
(require 'setup-help)
(require 'setup-tldr)
(require 'setup-config-files)
(require 'setup-shell)
(require 'setup-smerge)
(require 'setup-nov)
(require 'xkcd)
(require 'setup-docker)

;; install all packages (if they already not installed by use-package)
(package-install-selected-packages)



;; start emacs server only it has not already been started
(require 'server)
(unless (server-running-p) (server-start))

;; set gc-cons-threshold back to original value
(setq gc-cons-threshold gc-cons-threshold--orig)

;;; init.el ends here
