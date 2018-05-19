(require 'package)

(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/" ) )
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/" ) )
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/" ) )

(setq package-enable-at-startup nil)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
;;(require 'diminish)
(require 'bind-key)

(add-hook 'text-mode-hook 'linum-mode )

(setq visible-bell t)
(setq vc-follow-symlinks t)

(use-package evil
	     :ensure t
	     :config
	     (evil-mode 1)
	     )

(use-package ag
  :ensure t
  :commands (ag ag-regexp ag-project))

(use-package ob-go
  :ensure t )

(use-package magit
  :ensure t
  :defer t
  :config
  (setq magit-branch-arguments nil)
  (setq magit-push-always-verify nil)
  (setq magit-last-seen-setup-instructions "1.4.0")
  (magit-define-popup-switch 'magit-log-popup ?f "first parent" "--first-parent"))

;;; Git Commit Mode (a Magit minor mode):
(add-hook 'git-commit-mode-hook 'evil-insert-state)

;;;;; Emacs Lisp mode:
;;(add-hook 'emacs-lisp-mode-hook
;;          (lambda ()
;;            (yas-minor-mode t)
;;            (eldoc-mode)
;;            (highlight-symbol-mode)
;;            (define-key emacs-lisp-mode-map (kbd "<C-return>") 'eval-last-sexp)))
;;
;;;;; SH mode:
;;(add-hook 'sh-mode-hook (lambda ()
;;                          (setq sh-basic-offset 2)
;;                          (setq sh-indentation 2)))

(use-package yasnippet
  :ensure t
  :defer t
  :config
  (yas-reload-all)
  (setq yas-snippet-dirs '("~/.emacs.d/snippets"
                           "~/.emacs.d/remote-snippets"))
  (setq tab-always-indent 'complete)
  (setq yas-prompt-functions '(yas-completing-prompt
                               yas-ido-prompt
                               yas-dropdown-prompt))
  (define-key yas-minor-mode-map (kbd "<escape>") 'yas-exit-snippet))

(use-package yasnippet-snippets
  :ensure t )


(use-package flycheck
  :ensure t
  :commands flycheck-mode)

(use-package helm-make
  :ensure t
  :config
  (global-set-key (kbd "C-c m") 'helm-make-projectile))



;; Solarized
;; https://github.com/sellout/emacs-color-theme-solarized/pull/187
;;(setq color-themes '())
;;(use-package color-theme-solarized
;;  :ensure t
;;  :config
;;  (customize-set-variable 'frame-background-mode 'dark)
;;  (load-theme 'solarized t))

;; Powerline
(use-package powerline
  :ensure t
  :config (powerline-center-evil-theme))

;;(use-package powerline
;;	     :ensure t)
;;
;;(use-package smart-mode-line-powerline-theme
;;	     :ensure t)
;;
;;(use-package smart-mode-line
;;	     :ensure t
;;	     :config 
;;	     (require 'powerline))

(defvar helm-command-prefix-key)
(setq helm-command-prefix-key nil)
(use-package helm
  :ensure t
  :config
  (helm-mode 1)
)

(use-package helm-ag
  :ensure helm-ag
  :bind ("M-p" . helm-projectile-ag)
  )
;;  :commands (helm-ag helm-projectile-ag)
;;  :init (setq helm-ag-insert-at-point 'symbol
;;	      helm-ag-command-option "--path-to-ignore ~/.agignore"))

(use-package projectile
  :ensure t
  :defer t
  :config
  (projectile-global-mode)
  (setq projectile-enable-caching t))

(use-package helm-projectile
  :ensure t
  :bind ( ("M-t" . helm-projectile-find-file)
          :map evil-normal-state-map
          ("C-p" . helm-projectile) )
  :config
  (helm-projectile-on))

(use-package key-chord
  :ensure t
  :config
  (key-chord-mode 1)
  (key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
  (key-chord-define evil-insert-state-map "kj" 'evil-normal-state)
  (key-chord-define evil-insert-state-map "Jk" 'evil-normal-state)
  (key-chord-define evil-insert-state-map "jK" 'evil-normal-state))


(global-set-key (kbd "M-x") 'helm-M-x)

(use-package ox-twbs
             :ensure t )

(eval-after-load "org"
  '(require 'ox-md nil t))
(eval-after-load "org"
  '(require 'ox-twbs nil t))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (C . t)
   (ditaa . t)
   (sh . t)
   (plantuml . t)
   (go . t)))

(use-package smooth-scrolling
  :ensure t
  :config
  (smooth-scrolling-mode 1)
  (setq smooth-scroll-margin 5))


(use-package go-mode
    :ensure t)

(load-theme 'wombat t)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(set-default-font "Mono-12")

(global-hl-line-mode +1)
(show-paren-mode 1)

(setq evil-move-cursor-back nil)

(setq org-plantuml-jar-path "~/base/plantuml.jar" )

(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
  backup-by-copying t
  version-control t
  delete-old-versions t
  kept-new-versions 20
  kept-old-versions 10
  )

(setq projectile-tags-command "ctags-exuberant -Re %s %s .")

(if (functionp 'display-line-numbers-mode)
    (and (add-hook 'display-line-numbers-mode-hook
                   (lambda () (setq display-line-numbers-type 'relative)))
         (add-hook 'prog-mode-hook #'display-line-numbers-mode))
  (use-package nlinum-relative
    :ensure t
    :config
    (nlinum-relative-setup-evil)
    (setq nlinum-relative-redisplay-delay 0)
    (add-hook 'prog-mode-hook 'nlinum-relative-mode)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(frame-background-mode (quote dark))
 '(package-selected-packages
   (quote
    (helm-projectile projectile ag ob-go smart-mode-line-powerline-theme powerline use-package evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

