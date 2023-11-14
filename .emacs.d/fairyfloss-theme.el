;;; FairyFloss-theme.el --- FairyFloss
;;; Version: 1.0
;;; Commentary:
;;; A theme called FairyFloss
;;; Code:

(deftheme fairyfloss "DOCSTRING for fairyfloss")
  (custom-theme-set-faces 'fairyfloss
   '(default ((t (:foreground "#f8f8f2" :background "#b091ce" )))); 9887e3
   '(cursor ((t (:background "#F8F8F0" ))))
   '(fringe ((t (:background "#282828" ))))
   '(mode-line ((t (:foreground "#F8F8F2" :background "#7367ac" ))))
   '(region ((t (:background "#bcb0f4" ))))
   '(secondary-selection ((t (:background "#49483E" ))))
   '(font-lock-builtin-face ((t (:foreground "#C2FFDF" ))))
   '(font-lock-comment-face ((t (:foreground "#E6C000" ))))
   '(font-lock-comment-delimiter-face ((t (:foreground "#E6C000" ))))
   '(font-lock-function-name-face ((t (:foreground "#FFF352" :slant italic ))))
   '(font-lock-keyword-face ((t (:foreground "#FFB8D1" ))))
   '(font-lock-string-face ((t (:foreground "#FFEA00" ))))
   '(font-lock-type-face ((t (:foreground "#c2ffdf" :slant italic ))))
   '(font-lock-constant-face ((t (:foreground "#c5a3ff" ))))
   '(font-lock-variable-name-face ((t (:foreground "#FF857F" ))))
   '(minibuffer-prompt ((t (:foreground "#f8f8f2" :bold t ))))
   '(ahs-plugin-default-face ((t (:foreground "#f8f8f2" :background "#c9c0ef" ))))
   '(ahs-plugin-default-face-unfocused ((t (:foreground "#f8f8f2" :background "#b6a9ef" ))))
   '(font-lock-warning-face ((t (:foreground "#ff5472" :bold t :background "#9887e3" ))))
   )

;;;###autoload
(and load-file-name
    (boundp 'custom-theme-load-path)
    (add-to-list 'custom-theme-load-path
                 (file-name-as-directory
                  (file-name-directory load-file-name))))
;; Automatically add this theme to the load path

(provide-theme 'fairyfloss)

;;; FairyFloss-theme.el ends here
;;; (load-theme 'FairyFloss t)
;;; (package-install-file "FairyFloss-theme.el")
