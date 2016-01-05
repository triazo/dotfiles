;; load custom mode line
(load-file (fullpath-relative-to-current-file "mode-line.el"))

;; Aesthetics
(menu-bar-mode 0)
(setq linum-format "%3d|")
(if (display-graphic-p)
    (progn (tool-bar-mode 0)
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


(set-face-attribute 'default nil :height 100)

; Disable Startup screen
(setq inhibit-startup-screen t)


(custom-set-faces
 '(mode-line ((t (:box nil :overline "#FF213B"))))
 '(mode-line-inactive ((t (:overline "#0074FF"))))
 '(fringe ((t (:background "#000000" :foreground "#0074FF"))))
 '(scroll-bar ((t (:background "#000000" :foreground "#0074FF" :height 1.0 :width condensed))))
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 98 :width normal :foundry "unknown" :family "lemon")))))
