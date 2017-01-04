;;; Package --- Summary:
;;; Commentary:

;;; init.el --- Emacs configuration

;; INSTALL PACKAGES
;; --------------------------------------
;;; Code:
(require 'package)

(add-to-list 'package-archives
       '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)
(package-refresh-contents)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar init-myPackages
  '(better-defaults
;;    flycheck
;;    origami
;;    magit
;;    elpy
;;    counsel
;;    hydra
;;    ivy-hydra
;;    ivy-rich
;;    auto-complet
    material-theme))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      init-myPackages)

;; BASIC CUSTOMIZATION
;; --------------------------------------
;; hide the startup message
(setq inhibit-startup-message t)

(when (require 'elpy nil t)
  (elpy-enable))

(ac-config-default)

(defadvice auto-complete-mode (around disable-auto-complete-for-python)
  (unless (eq major-mode 'python-mode) ad-do-it))

(ad-activate 'auto-complete-mode)

;; enable flychek mode globally
(global-flycheck-mode)

(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; enable origami mode by default
(global-origami-mode t)

;; load material theme
(load-theme 'material t)

;; enable line numbers globally
(global-linum-mode t)

;; show culomn number by default
(setq column-number-mode t)

;; enable delet selection mode
(delete-selection-mode t)

;; remove trailing whitspace before save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; enable visual line mode
(global-visual-line-mode t)

;; enable magits for files
(global-magit-file-mode)

;; enable ido mode by default
;;(ido-mode t)

;;
(ivy-mode t)

(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")

(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(global-set-key (kbd "<f5>") 'kill-this-buffer)

(require 'ivy-rich)
(ivy-set-display-transformer 'ivy-switch-buffer 'ivy-rich-switch-buffer-transformer)

(setq ivy-virtual-abbreviate 'full
      ivy-rich-switch-buffer-align-virtual-buffer t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (flycheck material-theme better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(provide 'init)
;;; init.el ends here
