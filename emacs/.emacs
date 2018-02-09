(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/" ) )
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/" ) )
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/" ) )

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

(use-package evil
	     :ensure t
	     :config
	     (evil-mode 1)
	     )

(use-package ob-go
  :ensure t )

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

(use-package key-chord
  :ensure t
  :config
  (key-chord-mode 1)
  (key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
  (key-chord-define evil-insert-state-map "kj" 'evil-normal-state)
  (key-chord-define evil-insert-state-map "Jk" 'evil-normal-state)
  (key-chord-define evil-insert-state-map "jK" 'evil-normal-state))


(global-set-key (kbd "M-x") 'helm-M-x)

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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(frame-background-mode (quote dark))
 '(package-selected-packages
   (quote
    (ob-go smart-mode-line-powerline-theme powerline use-package evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

