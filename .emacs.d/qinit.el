; Triazo Emacs config.  This statement last updated Oct 19, 2014
;
; Note that 'C-h v' will bring the help for a variable

;; A better package management system.  Don't do everything manually
(add-to-list 'load-path "~/.emacs.d/lisp/")
(require 'package)
(package-initialize)
;; (push '("marmalade" . "http://marmalade-repo.org/packages/") package-archives )
(push '("melpa" . "http://melpa.milkbox.net/packages/") package-archives)

;; Package management disabled in qinit.el

;; Requires and imports
(add-to-list 'load-path "~/.emacs.d/modes")
(load "~/.emacs.d/lisp/functions.el")
;; (require 'expand-region)
;; (require 'ido)
;; (require 'go-mode-load)
;;(require 'popup)
;;(require 'auto-complete)
;;(require 'auto-highlight-symbol)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)
(load "~/.emacs.d/styles/styles.el")
(load "~/.emacs.d/bindings.el")
(load "~/.emacs.d/modes/mode-hooks.el")

; Change settings for backup files.
; Set the directory to store them in to ~/.emacs.d/autosaves.
(if (eq (user-uid) 0)
    ; Root Backups do not go in the shared emacs config file.
    (setq backup-directory-alist `(("." . "~/.emacs-autosaves")))
  ; Else
  (setq backup-directory-alist `(("." . "~/.emacs.d/autosaves"))))

; Backup things by copying them.
(setq backup-by-copying t)
; Set some other backup related options.
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)

; Set syntax hilighting to maximum. Does this do anything?
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


(global-visual-line-mode t)

;; For Scheme programming
(setq scheme-program-name "tinyscheme")

;; Slime mode setup
(add-hook 'slime-mode-hook (lambda () (interactive)
			     (local-set-key (kbd "C-o C-e") 'slime-eval-last-expression)))

;; hs- stuff
(add-hook 'prog-mode-hook (lambda()
			    (hs-minor-mode)
			    (local-set-key (kbd "C-c SPC") 'hs-toggle-hiding)))

(put 'set-goal-column 'disabled nil)

;; Auto-hilight symbol mode
;; (global-auto-highlight-symbol-mode t)
;; (put 'downcase-region 'disabled nil)

;; For js-beutify.el
;; (eval-after-load 'js2-mode
;;   '(define-key js2-mode-map (kbd "C-c b") 'web-beautify-js))
;; (eval-after-load 'json-mode
;;   '(define-key json-mode-map (kbd "C-c b") 'web-beautify-js))
;; (eval-after-load 'sgml-mode
;;   '(define-key html-mode-map (kbd "C-c b") 'web-beautify-html))
;; (eval-after-load 'css-mode
;;   '(define-key css-mode-map (kbd "C-c b") 'web-beautify-css))
