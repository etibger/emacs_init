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
    flycheck
    origami
    material-theme))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      init-myPackages)

;; BASIC CUSTOMIZATION
;; --------------------------------------
;; hide the startup message
(setq inhibit-startup-message t)

;; enable flychek mode globally
(global-flycheck-mode)

;; enable origami mode by default
(global-origami-mode t)

;; load material theme
(load-theme 'material t)

;; enable line numbers globally
(global-linum-mode t)

;; enable delet selection mode
(delete-selection-mode t)

;; remove trailing whitspace before save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; enable origami mode by default
(global-origami-mode t)

;; enable visual line mode
(global-visual-line-mode t)

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
