;; New Keybindings
;; (define-key c-mode-base-map (kbd "<f11>") 'compile)
;; (define-key c-mode-base-map "\C-c\C-c" 'compile)
;; (define-key c-mode-base-map (kbd "RET") 'newline-and-indent)
;; (define-key c-mode-base-map (kbd "C-c SPC") 'hs-toggle-hiding)

;; Bury the compile buffer when finished compiling.  Function in lisp/functions.el
(add-hook 'compilation-finish-functions 'bury-compile-buffer-if-successful)

;; Define Tab width
(setq truncate-lines 1)
;; (setq tab-width 4)
;; (setq indent-tabs-mode nil)
