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


(straight-use-package 'use-package)
(straight-use-package 'expand-region)
(straight-use-package 'popup)
(straight-use-package 'auto-complete)
(straight-use-package 'auto-highlight-symbol)
(straight-use-package 'pushbullet)
(straight-use-package 'php-mode)
(straight-use-package 'magit)
(straight-use-package 'tree-sitter)
(straight-use-package 'tree-sitter-langs)
(straight-use-package 'lsp-mode)
(straight-use-package
 '(copilot :type git  :host github :repo "zerolfx/copilot.el" :files ("dist" "*.el") :ensure t))