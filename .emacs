;; init.el --- Emacs configuration

;; INSTALL PACKAGES
;; --------------------------------------
(require 'package)

(add-to-list 'package-archives
       '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(auctex
    better-defaults
    cdlatex
    counsel
    cmake-ide
    cmake-mode
    company
    company-auctex
    company-math
    company-irony
    company-irony-c-headers
    company-rtags
    elpy
    expand-region
    flycheck
    flycheck-irony
    flycheck-rtags
    irony
    importmagic
    ivy
    material-theme
    magit
    popup
    py-autopep8
    rtags
    smartparens
    swiper
    undo-tree
    use-package))

(mapc #'(lambda (package)
          (unless (package-installed-p package)
            (package-install package)))
      myPackages)

;; BASIC CUSTOMIZATION
;; --------------------------------------
(defalias 'yes-or-no-p 'y-or-n-p)
(setq auto-save-default nil)



(require 'use-package)
(use-package ivy
  :ensure t
  :diminish (ivy-mode)
  :bind(("C-x b" . ivy-switch-buffer))
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-display-style 'fancy))

(use-package swiper
  :ensure try
  :bind (("C-s" . swiper)
         ("C-r" . swiper))
  :config
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (setq ivy-display-style 'fancy)
    (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
    ))

(setq inhibit-startup-message t) ;; hide the startup message
(load-theme 'material t) ;; load material theme
(global-linum-mode t) ;; enable line numbers globally
(elpy-enable)

;;(use-package importmagic
;;    :ensure t
;;    :config
;;    (add-hook 'python-mode-hook 'importmagic-mode))

(setq auto-mode-alist
      (append
       '(("CMakeLists\\.txt\\'" . cmake-mode))
       '(("\\.cmake\\'" . cmake-mode))
       auto-mode-alist))
(autoload 'cmake-mode "/usr/share/cmake-3.8/editors/emacs/cmake-mode.el" t)

(require 'ido)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode t)
(defalias 'list-buffers 'ibuffer-other-window)

(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
;;(elpy-use-ipython)


;; enable rtags and company mode


(require 'rtags)
(require 'company-rtags)

(setq rtags-completions-enabled t)
(eval-after-load 'company
  '(add-to-list
    'company-backends 'company-rtags))
(setq rtags-autostart-diagnostics t)
(rtags-enable-standard-keybindings)

;;enable Helm

;;(require 'rtags-helm)
;;(setq rtags-use-helm t)


;;Source code completition

(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))

(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)


(add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)
(setq company-backends (delete 'company-semantic company-backends))
;;(eval-after-load 'company
;;  '(add-to-list
;;    'company-backends 'company-irony))

(add-hook 'after-init-hook 'global-company-mode)

(require 'company-irony-c-headers)
(eval-after-load 'company
  '(add-to-list
    'company-backends '(company-irony-c-headers company-irony)))

(setq company-idle-delay 0)
(define-key c-mode-map [(tab)] 'company-complete)
(define-key c++-mode-map [(tab)] 'company-complete)

;; flycheck

(add-hook 'c++-mode-hook 'flycheck-mode)
(add-hook 'c-mode-hook 'flycheck-mode)

(require 'flycheck-rtags)

(defun my-flycheck-rtags-setup ()
  (flycheck-select-checker 'rtags)
  (setq-local flycheck-highlighting-mode nil) ;; RTags creates more accurate overlays.
  (setq-local flycheck-check-syntax-automatically nil))
;; c-mode-common-hook is also called by c++-mode
(add-hook 'c-mode-common-hook #'my-flycheck-rtags-setup)

(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))

;; cmake


(cmake-ide-setup)

;;; use popup menu for yas-choose-value
(require 'popup)
(add-to-list 'load-path
              "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(add-to-list 'yas-snippet-dirs "~/git_repos/yasnippet-snippets/")
(yas-global-mode 1)
(yas-reload-all)
;; (defun shk-yas/helm-prompt (prompt choices &optional display-fn)
;;     "Use helm to select a snippet. Put this into `yas-prompt-functions.'"
;;     (interactive)
;;     (setq display-fn (or display-fn 'identity))
;;     (if (require 'helm-config)
;;         (let (tmpsource cands result rmap)
;;           (setq cands (mapcar (lambda (x) (funcall display-fn x)) choices))
;;           (setq rmap (mapcar (lambda (x) (cons (funcall display-fn x) x)) choices))
;;           (setq tmpsource
;;                 (list
;;                  (cons 'name prompt)
;;                  (cons 'candidates cands)
;;                  '(action . (("Expand" . (lambda (selection) selection))))
;;                  ))
;;           (setq result (helm-other-buffer '(tmpsource) "*helm-select-yasnippet"))
;;           (if (null result)
;;               (signal 'quit "user quit!")
;;             (cdr (assoc result rmap))))
;;       nil))

(defun yas-popup-isearch-prompt (prompt choices &optional display-fn)
  (when (featurep 'popup)
    (popup-menu*
     (mapcar
      (lambda (choice)
        (popup-make-item
         (or (and display-fn (funcall display-fn choice))
             choice)
         :value choice))
      choices)
     :prompt prompt
     ;; start isearch mode immediately
     :isearch t
     )))

(setq yas-prompt-functions '(yas-popup-isearch-prompt yas-ido-prompt yas-no-prompt))

;; Completing point by some yasnippet key
(defun yas-ido-expand ()
  "Lets you select (and expand) a yasnippet key"
  (interactive)
  (let ((original-point (point)))
    (while (and
            (not (= (point) (point-min) ))
            (not
             (string-match "[[:space:]\n]" (char-to-string (char-before)))))
      (backward-word 1))
    (let* ((init-word (point))
           (word (buffer-substring init-word original-point))
           (list (yas-active-keys)))
      (goto-char original-point)
      (let ((key (remove-if-not
                  (lambda (s) (string-match (concat "^" word) s)) list)))
        (if (= (length key) 1)
            (setq key (pop key))
          (setq key (ido-completing-read "key: " list nil nil word)))
        (delete-char (- init-word original-point))
        (insert key)
        (yas-expand)))))



(require 'smartparens-config)
;; Always start smartparens mode in js-mode.
(use-package smartparens-config
    :ensure smartparens
    :config
    (progn
      (show-smartparens-global-mode t)))

(add-hook 'prog-mode-hook 'turn-on-smartparens-mode)
(add-hook 'markdown-mode-hook 'turn-on-smartparens-mode)

(use-package undo-tree
  :ensure t
  :init
  (global-undo-tree-mode)
  (global-set-key (kbd "C-z") 'undo)
  (defalias 'redo 'undo-tree-redo)
  (global-set-key (kbd "C-S-z") 'redo))

(use-package expand-region
  :ensure t
  :config
  (global-set-key (kbd "C-=") 'er/expand-region))

;; (use-package aggressive-indent
;;   :ensure t
;;   :config
;;   (global-aggressive-indent-mode 1)
;;   (add-to-list 'aggressive-indent-excluded-modes 'html-mode))

(define-key yas-minor-mode-map (kbd "<C-tab>")     'yas-ido-expand)
(define-key global-map (kbd "C-c o") 'elpy-multiedit)


(define-key popup-menu-keymap (kbd "M-n") 'popup-next)
;;(define-key popup-menu-keymap (kbd "TAB") 'popup-next)
;; (define-key popup-menu-keymap (kbd "<tab>") 'popup-next)
;; (define-key popup-menu-keymap (kbd "<backtab>") 'popup-previous)
(define-key popup-menu-keymap (kbd "M-p") 'popup-previous)

;;(global-set-key (kbd "M-RET") 'company-complete)
;;(global-set-key (kbd "TAB") 'company-complete)
(global-set-key (kbd "C-c m") 'cmake-ide-compile)

(defun comment-or-uncomment-region-or-line ()
  "Comments or uncomments the region or the current line if there's no active region."
  (interactive)
  (let (beg end)
    (if (region-active-p)
        (setq beg (region-beginning) end (region-end))
      (setq beg (line-beginning-position) end (line-end-position)))
    (comment-or-uncomment-region beg end)
    (next-line)))
(global-set-key (kbd "C-c c") 'comment-or-uncomment-region-or-line)


;; Latex

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)
(setq-default TeX-master nil)
(setq TeX-PDF-mode t)

(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t
      reftex-enable-partial-scans t)


;; (add-hook 'LaTeX-mode-hook 'turn-on-cdlatex)   ; with AUCTeX LaTeX mode
;; (add-hook 'latex-mode-hook 'turn-on-cdlatex)   ; with Emacs latex mode


;; (cond ((fboundp 'global-font-lock-mode)
;; ;; Turn on font-lock in all modes that support it
;; (global-font-lock-mode t)
;; ;; Maximum colors
;; (setq font-lock-maximum-decoration t)))

(require 'company-auctex)
(company-auctex-init)
(add-to-list 'company-backends 'company-math-symbols-unicode)

(add-hook 'LaTeX-mode-hook 'turn-on-reftex)   ; with AUCTeX LaTeX mode
(add-hook 'LaTeX-mode-hook 'flycheck-mode)

(setq ispell-program-name "aspell") ; could be ispell as well, depending on your preferences
(setq ispell-dictionary "english") ; this can obviously be set to any language your spell-checking program supports

;; (add-hook 'LaTeX-mode-hook 'flyspell-mode)
;; (add-hook 'LaTeX-mode-hook 'flyspell-buffer)

;; (defun turn-on-outline-minor-mode ()
;; (outline-minor-mode 1))

;; (add-hook 'LaTeX-mode-hook 'turn-on-outline-minor-mode)
;; (add-hook 'latex-mode-hook 'turn-on-outline-minor-mode)
;; (setq outline-minor-mode-prefix "\C-c \C-o") ; Or something else

;; (require 'tex-site)
;; (autoload 'reftex-mode "reftex" "RefTeX Minor Mode" t)
;; (autoload 'turn-on-reftex "reftex" "RefTeX Minor Mode" nil)
;; (autoload 'reftex-citation "reftex-cite" "Make citation" nil)
;; (autoload 'reftex-index-phrase-mode "reftex-index" "Phrase Mode" t)
;; (add-hook 'latex-mode-hook 'turn-on-reftex) ; with Emacs latex mode
;; ;; (add-hook 'reftex-load-hook 'imenu-add-menubar-index)
;; (add-hook 'LaTeX-mode-hook 'turn-on-reftex)

;; (setq LaTeX-eqnarray-label "eq"
;; LaTeX-equation-label "eq"
;; LaTeX-figure-label "fig"
;; LaTeX-table-label "tab"
;; LaTeX-myChapter-label "chap"
;; TeX-auto-save t
;; TeX-newline-function 'reindent-then-newline-and-indent
;; TeX-parse-self t
;; TeX-style-path
;; '("style/" "auto/"
;; "/usr/share/emacs21/site-lisp/auctex/style/"
;; "/var/lib/auctex/emacs21/"
;; "/usr/local/share/emacs/site-lisp/auctex/style/")
;; LaTeX-section-hook
;; '(LaTeX-section-heading
;; LaTeX-section-title
;; LaTeX-section-toc
;; LaTeX-section-section
;; LaTeX-section-label))


;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (aggressive-indent expand-region material-theme better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
