;; bindings.el

;; Let C-o have the same function as C-x
(use-local-map (make-sparse-keymap))
(global-set-key (kbd "C-o") ctl-x-map)
(global-set-key "\C-o\C-o" 'exchange-point-and-mark)

;; assign another commnad to M-x, for running commands not bound to a key.
(global-set-key "\C-ot" 'execute-extended-command)

;; attempt to use C-w instead of backspace
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\M-W" 'kill-region)

;; Make C-a go to the beginning of typed lines
(global-set-key "\C-a" 'back-to-indentation)
(global-set-key "\M-m" 'move-beginning-of-line)

(global-set-key (kbd "M-#") 'comment-or-uncomment-region)

(global-set-key "\C-z" 'eshell)

;; Use expand-region.
(global-set-key (kbd "M-SPC") 'er/expand-region)

;; Basic binding for hide-show mode

;; Bind
(global-set-key (kbd "C-'") 'other-window)
(global-set-key (kbd "C-,") (lambda () (interactive) (switch-to-buffer (other-buffer))))

;; Magit settings
(global-set-key (kbd "M-g s") 'magit-status)
(global-set-key (kbd "M-g M-s") 'magit-status)
