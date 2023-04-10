;; pager emacs config, currently updated April 4, 2023

;; Packages now handled in `.emacs.d/packages.el`
(setq package-enable-at-startup nil)
(load "~/.emacs.d/packages.el")

;; Misc Requires and imports
(add-to-list 'load-path "~/.emacs.d/lisp/")
(load "~/.emacs.d/lisp/functions.el")
(add-to-list 'load-path "~/.emacs.d/modes")

(require 'expand-region)
(require 'ido)
(require 'go-mode-load)
(require 'popup)
(require 'auto-complete)
(require 'auto-highlight-symbol)


;; Custom styles and general bindings
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)
(load "~/.emacs.d/styles/styles.el")
(load "~/.emacs.d/bindings.el")
(load "~/.emacs.d/modes/mode-hooks.el")

;; Change settings for backup files.
;; Set the directory to store them in to ~/.emacs.d/autosaves.
(if (eq (user-uid) 0)
    ;; Root Backups do not go in the shared emacs config file.
    (setq backup-directory-alist `(("." . "~/.emacs-autosaves")))
  ;; Else
  (setq backup-directory-alist `(("." . "~/.emacs.d/autosaves"))))

;; Backup things by copying them.
(setq backup-by-copying t)
;; Set some other backup related options.
(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

;; Set syntax hilighting to maximum. Does this do anything?
(setq font-lock-maximum-decoration t)

;; Start ido mode
(ido-mode t)

;; Set tetris score file
(setq tetris-score-file "~/.emacs.d/tetris-scores")

;; Automatically added when running functions
(put 'upcase-region 'disabled nil)
(put 'scroll-left 'disabled nil)

(setq auto-fill-mode 1)

;; Fix the scratch buffer, make it more useful
(setq initial-major-mode 'text-mode)
(setq initial-scratch-message (concat "-- " (format-time-string "%A %B %d %H:%M:%S") " --\n\n"))

;; Enable autocomplete mode  ;; TODO: change this so that it works on a new install
(ac-config-default)
(add-to-list 'ac-dictionary-directories "/home/adam/.emacs.d/elpa/auto-complete-20140824.1658/dict")
(require 'auto-complete-config)
(defun my:ac-c-headers-init ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers))

(add-hook 'c++-mode-hook 'my:ac-c-headers-init)
(add-hook 'c-mode-hook 'my:ac-c-headers-init)
;;(add-hook 'org-mode (lambda () (load "~/.emacs.d/org-mode.el") t)

;; Indentation settings
(setq indent-tabs-mode nil)
(global-visual-line-mode t)

;; For Scheme programming
(setq scheme-program-name "tinyscheme")

;; Slime mode setup
(add-hook 'slime-mode-hook (lambda () (interactive)
                             (local-set-key (kbd "C-o C-e") 'slime-eval-last-expression)))

;; basic programming settings
(add-hook 'prog-mode-hook
	  (lambda()
            (global-display-line-numbers-mode)
	    (copilot-mode)
            (hs-minor-mode)))

(add-hook 'hs-minor-mode-hook
	  (lambda()
	    (local-set-key (kbd "C-c SPC") 'hs-toggle-hiding)))

;; copilot mode bindings
(add-hook 'copilot-mode-hook
	  (lambda()
	    
	    (define-key copilot-mode-map (kbd "C-<tab>") 'copilot-accept-completion)
	    (define-key copilot-mode-map (kbd "M-<right>") 'copilot-next-completion)
	    (define-key copilot-mode-map (kbd "M-<left>") 'copilot-previous-completion)
	    (define-key copilot-mode-map (kbd "M-<down>") 'copilot-accept-completion-by-line)))

(put 'set-goal-column 'disabled nil)

;; Auto-hilight symbol mode
(global-auto-highlight-symbol-mode t)
;; Default autohilight bindings interfere with copilot bindings
(define-key auto-highlight-symbol-mode-map (kbd "M-<right>") nil)
(define-key auto-highlight-symbol-mode-map (kbd "M-<left>") nil)
(put 'downcase-region 'disabled nil)

;; For js-beutify.el
(eval-after-load 'js2-mode
  '(define-key js2-mode-map (kbd "C-c b") 'web-beautify-js))
(eval-after-load 'json-mode
  '(define-key json-mode-map (kbd "C-c b") 'web-beautify-js))
(eval-after-load 'sgml-mode
  '(define-key html-mode-map (kbd "C-c b") 'web-beautify-html))
(eval-after-load 'css-mode
  '(define-key css-mode-map (kbd "C-c b") 'web-beautify-css))

;; Delete trailing whitespace on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; For magit setup
(setq magit-last-seen-setup-instructions "1.4.0")

;; Trunkating lines
(setq truncate-partial-width-windows nil)
(set-default 'truncate-lines t)
(put 'narrow-to-region 'disabled nil)

;; Create a buffer-local hook to run elixir-format on save, only when we enable elixir-mode.
(add-hook 'elixir-mode-hook
          (lambda ()
	    (add-hook 'before-save-hook 'elixir-format nil t)
	    ;; projectile mode for elixir. Could use for other things
	    ;; but atm I don't use it for other types of projecs
	    (projectile-mode +1)
	    (setq projectile-switch-project-action 'neotree-projectile-action)))
