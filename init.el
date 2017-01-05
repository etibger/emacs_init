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
    magit
    elpy
    counsel
    hydra
    ivy-hydra
    ivy-rich
    auto-complete
    solarized-theme
    org
    org-bullets
    pos-tip
    pp-c-l
    hide-comnt))

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
(setq elpy-rpc-backend "jedi")

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

;; key bindings for origami
(define-key origami-mode-map (kbd "C-M-; o o") 'origami-open-node)
(define-key origami-mode-map (kbd "C-M-; o c") 'origami-close-node)
(define-key origami-mode-map (kbd "C-M-; o t") 'origami-toggle-node)
(define-key origami-mode-map (kbd "C-M-; o a o") 'origami-open-all-nodes)
(define-key origami-mode-map (kbd "C-M-; o a c") 'origami-close-all-nodes)
(define-key origami-mode-map (kbd "C-M-; o a t") 'origami-toggle-all-nodes)
(define-key origami-mode-map (kbd "C-M-; o r o") 'origami-open-node-recursively)
(define-key origami-mode-map (kbd "C-M-; o r c") 'origami-close-node-recursively)

;; enable line numbers globally
(global-linum-mode t)

;; show culomn number by default
(setq column-number-mode t)

;; enable delet selection mode
(delete-selection-mode t)

;; disable tab insertion
(setq-default indent-tabs-mode nil)

;; remove trailing whitspace before save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; enable visual line mode
(global-visual-line-mode t)

;; enable automatical buffer reversion
(global-auto-revert-mode t)

;; enable magits for files
(global-magit-file-mode)

(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)

;; global ivy-mode
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

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; enable pos-tip
;(require 'pos-tip)

;; load pretty control L package
(require 'pp-c-l)
;;enable pretty contorl L by default
(pretty-control-l-mode 1)

(require 'hide-comnt)
;; key bindings for hide/show-comment
(define-key origami-mode-map (kbd "C-M-; h h") 'hide/show-comments)
(define-key origami-mode-map (kbd "C-M-; h t") 'hide/show-comments-toggle)

;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom KBD macros  ;;
;;;;;;;;;;;;;;;;;;;;;;;;

; select word at cursor position and search it
(fset 'search-current-word "\M-b\C-s\C-w\C-s")
(global-set-key (kbd "C-M-'") 'search-current-word)

; select word at cursor position with extension and open it
(fset 'open-file-with-extension [?\M-b ?\C-  ?\M-f ?\M-f ?\M-w ?\C-x ?\C-f ?\C-y return])
(global-set-key (kbd "C-M-; C-o") 'open-file-with-extension)

;kill current file and close window
(fset 'kill-buffer-window  [?\C-x ?k return ?\C-x ?o ?\C-x ?1])
(global-set-key (kbd "C-M-; k") 'kill-buffer-window)

;copy actual word
(fset 'copy_actual_word  [?\M-b ?\C-  ?\M-f ?\M-w])
(global-set-key (kbd "C-M-; w") 'copy_actual_word)

;replace actual word
(fset 'replace_actual_word  [?\M-b ?\C-  ?\M-f ?\C-y])
(global-set-key (kbd "C-M-; y") 'replace_actual_word)

; open selected file path
(fset 'open-selected-file  [?\M-w ?\C-x ?\C-f ?\C-y return])
(global-set-key (kbd "C-M-; C-f") 'open-selected-file)

;; open new vertical window and switch current buffer
(fset 'vertical-window-buffer-switch [?\C-x ?3 ?\C-x ?b return])
(global-set-key (kbd "C-M-; 3") 'vertical-window-buffer-switch)

;; copy to end of line
(fset 'copy-to-lind-end  [?\C-  ?\C-e ?\M-w])
(global-set-key (kbd "C-M-; l") 'copy-to-lind-end)

;; duplicate line
(fset 'duplicate-line [?\C-a ?\C-  ?\C-n ?\M-w ?\C-y])
(global-set-key (kbd "C-M-; D") 'duplicate-line)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(custom-enabled-themes (quote (solarized-dark)))
 '(custom-safe-themes
   (quote
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "98cc377af705c0f2133bb6d340bf0becd08944a588804ee655809da5d8140de6" default)))
 '(hl-sexp-background-color "#1c1f26")
 '(package-selected-packages (quote (flycheck solarized-theme better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 136 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))

(provide 'init)
;;; init.el ends here

