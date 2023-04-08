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
(define-key ctl-x-map (kbd "g") 'magit-status)
(define-key ctl-x-map (kbd "C-g") 'magit-status)

;; Dired mode bindings
(define-key ctl-x-map (kbd "d") (lambda () (interactive) (dired (file-name-directory (or load-file-name buffer-file-name)))))
(define-key ctl-x-map (kbd "C-d") (lambda () (interactive) (dired (file-name-directory (or load-file-name buffer-file-name)))))

;; Fix minor modes overwriting my keybindings
(add-hook 'org-mode-hook
          '(lambda ()
	     (define-key org-mode-map (kbd "C-'") nil)))

(add-hook 'flyspell-mode-hook
	  '(lambda ()
	     (define-key flyspell-mode-map (kbd "C-,") nil)))

(add-hook 'dired-mode-hook
          '(lambda ()
	     (define-key dired-mode-map (kbd "C-o") nil)))

(add-hook 'read-only-mode-hook
	  '(lambda ()
	     (local-set-key (kbd "j")
			    '(lambda () (interactive) (scroll-up 3)))
	     (local-set-key (kbd "k")
			    '(lambda () (interactive) (scroll-down 3)))))

(global-set-key (kbd "C-c e") 'eval-and-replace)

;; projectile mode stuff

(add-hook 'projectile-mode-hook
	  '(lambda ()
	     (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
	     (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)))

(global-set-key [f8] 'neotree-project-dir)


(add-hook 'lsp-mode-hook
	  '(lambda ()
	     (define-key lsp-mode-map (kbd "C-c C-l") 'lsp-command-map)))
