;; Bury the compile buffer when finished compiling.  Function in lisp/functions.el
(add-hook 'compilation-finish-functions 'bury-compile-buffer-if-successful)

(add-hook 'before-save-hook #'gofmt-before-save)

;; Define Tab width
(setq truncate-lines t)
