
(add-to-list 'load-path (fullpath-relative-to-current-file "."))
(require 'color-theme-tomorrow)
(color-theme-tomorrow--define-theme night-bright)

;; load custom mode line
(load-file (fullpath-relative-to-current-file "mode-line.el"))

;; Aesthetics
(menu-bar-mode 0)
(setq linum-format "%3d│")
(if (display-graphic-p)
    (progn ;; (load-theme 'lavender)
	   (tool-bar-mode 0)
	   (setq linum-format "%3d|")
	   (setq default-frame-alist '((right-fringe . 1)
				       ;; (background-color . "#ebebeb")
				       ;; (foreground-color . "#484848")
				       (background-color . "#000000")
				       (foreground-color . "#ffffff")
				       (left-fringe . 1)
				       (scroll-bar-width . 7)
				       ))))



;; Load theme for bluezenburn
;;(load-file (fullpath-relative-to-current-file "bluezenburn.el"))


; Disable Startup screen
(setq inhibit-startup-screen t)


(custom-set-faces
 ;'(mode-line ((t (:box nil :overline "#9edea2"))))
 ;'(mode-line-inactive ((t (:overline "#d5c1de"))))
 '(fringe ((t (:background "#b091ce" :foreground "#cf87de"))))
 '(scroll-bar ((t (:background "#4d405b" :foreground "#cf87de" :height 1.0 :width condensed))))
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 130 :width normal :foundry "unknown" :family "Roboto Mono")))))
