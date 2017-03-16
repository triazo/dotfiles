; Hooks to enable custom modes
(add-to-list 'auto-mode-alist '("\\.cu\\'" . c++-mode))

; Settings for Text mode
(add-hook 'text-mode-hook 'auto-fill-mode)
(add-hook 'text-mode-hook 'flyspell-mode)
;; (add-hook 'text-mode-hook (lambda () (progn
;; 				       (face-remap-add-relative 'default '(:family "Tex Gyre Chorus"))
;; 					(face-remap-add-relative 'default '(:height 120)))))


; Settings for C++ mode (and I guess C as well)
(add-hook 'c-mode-common-hook (lambda () (load "~/.emacs.d/modes/c-mode.el")))
(add-hook 'c-mode-common-hook 'hs-minor-mode)
(add-hook 'c-mode-common-hook 'linum-mode)
