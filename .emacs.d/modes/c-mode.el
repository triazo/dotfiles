;; New Keybindings
(define-key c-mode-base-map (kbd "<f11>") 'compile)
(define-key c-mode-base-map "\C-c\C-c" 'compile)
(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)
(define-key c-mode-base-map (kbd "C-c SPC") 'hs-toggle-hiding)

;; Syntax hilighting
(setq c-default-style "stroustrup")

;; Some stuff for yas and auto-complete
;; (yas/minor-mode-on)
;; (auto-complete-mode 1)

;; avoid enabling irony-mode in modes that inherits c-mode, e.g: php-mode
;; (when (member major-mode irony-known-modes)
;;   (irony-mode 1))


;; Bury the compile buffer when finished compiling.  Function in lisp/functions.el
(add-hook 'compilation-finish-functions 'bury-compile-buffer-if-successful)

;; Define Tab width
(setq truncate-lines 1)
(setq tab-width 4)
;; (setq c-basic-offset 4)
(setq indent-tabs-mode nil)
; (defvaralias 'c-basic-offset 'tab-width)


;; Make backspace and C-d delete whitespace
(c-toggle-hungry-state t)

;; When using a new enough version of emacs, use many gdb windows.
(when (or (> emacs-major-version 23)
	  (and (= emacs-major-version 23)
	       (>= emacs-minor-version 2)))
  ;; Use the GDB visual debugging moden
  (setq gdb-many-windows t)
  ;; Turn Semantic on
  ;; (add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode)
  ;; (add-to-list 'semantic-default-submodes 'global-semantic-highlight-func-mode)
  ;; (add-to-list 'semantic-default-submodes 'global-semantic-idle-local-symbol-highlight-mode)
  ;; (add-to-list 'semantic-default-submodes 'global-semantic-idle-scheduler-mode)
  ;; (add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode)
  ;; (add-to-list 'semantic-default-submodes 'global-cedet-m3-minor-mode)
  ;; (semantic-mode 1)
  ;; (require 'semantic/ia)
  ;; (require 'semantic/bovine/gcc)

  ;; Enable imenu

  ;;(semantic-load-enable-minimum-features)
  ;;(semantic-load-enable-gaudy-code-helpers)
  ;; Try to make completions when not typing
  ;;(global-semantic-idle-completions-mode 1)
  ;; Use the Semantic speedbar additions
  ;; (add-hook 'speedbar-load-hook (lambda () (require 'semantic/sb))))
  )
