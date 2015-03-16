(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(emdroid-activity-creator "ActivityCreator.py")
 '(emdroid-tools-dir "/opt/android-sdk")
 '(inhibit-startup-screen t)
 '(mpc-host "pi.triazo.net")
 '(send-mail-function (quote smtpmail-send-it))
 '(smtpmail-smtp-server "mail.triazo.net")
 '(smtpmail-smtp-service 587))

(if (display-graphic-p)
    (progn (custom-set-variables
	    '(custom-enabled-themes (quote (adwaita))))
	   
	   (custom-set-faces
	    ;; custom-set-faces was added by Custom.
	    ;; If you edit it by hand, you could mess it up, so be careful.
	    ;; Your init file should contain only one such instance.
	    ;; If there is more than one, they won't work right.
	    '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 98 :width normal :foundry "unknown" :family "lime" :background "#ebebeb"))))
	    '(fringe ((t (:background "#ebebeb" :foreground "#6d8cc7"))))
	    '(scroll-bar ((t (:background "#ebebeb" :foreground "#6d8cc7" :height 1.0 :width condensed)))))))




