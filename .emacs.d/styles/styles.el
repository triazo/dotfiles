;; load custom mode line
(load-file (fullpath-relative-to-current-file "mode-line.el"))

;; Aesthetics
(menu-bar-mode 0)
(if (display-graphic-p)
    (progn (tool-bar-mode 0)
	   (setq default-frame-alist '((background-color . "#ebebeb")
				       (foreground-color . "#484848")
				       (right-fringe . 1)
				       (left-fringe . 1)
				       (scroll-bar-width . 7)
				       ))))



;; Load theme for bluezenburn
;;(load-file (fullpath-relative-to-current-file "bluezenburn.el"))


(set-face-attribute 'default nil :height 100)

; Disable Startup screen
(setq inhibit-startup-screen t)
