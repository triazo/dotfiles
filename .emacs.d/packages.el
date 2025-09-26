;; This file made during the switch from package.el to straight.el

(defvar bootstrap-version)
(let ((bootstrap-file
      (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
        "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
        'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))


;; Attempting to make emacs not take forever to start up

(setq straight-check-for-modifications '(watch-files))

(straight-use-package 'use-package)
(straight-use-package 'expand-region)
(straight-use-package 'popup)
(straight-use-package 'json-mode)
(straight-use-package 'auto-complete)
(straight-use-package 'auto-highlight-symbol)
;; (straight-use-package 'pushbullet)
(straight-use-package 'php-mode)
(straight-use-package 'magit)
(straight-use-package 'tree-sitter)
(straight-use-package 'tree-sitter-langs)
(straight-use-package 'lsp-mode)
(straight-use-package 'elixir-mode)
(straight-use-package 'nginx-mode)
(straight-use-package 'markdown-mode)
(straight-use-package 'terraform-mode)
(straight-use-package 'shader-mode)
(straight-use-package 'dracula-theme)
(straight-use-package 'nix-mode)
(straight-use-package 'python-black)
(straight-use-package 'rust-mode)
(straight-use-package 'palette)
(straight-use-package
 '(unity :type git :host github :repo "elizagamedev/unity.el"))
(add-hook 'after-init-hook #'unity-mode)
;; (straight-use-package
;; '(copilot :type git  :host github :repo "zerolfx/copilot.el" :files ("dist" "*.el") :ensure t))
