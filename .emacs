;; Don't create backup file
(setq make-backup-files nil)

;; Disable welcome message
(setq inhibit-startup-message t)

;; Set default window size
(add-to-list 'default-frame-alist (cons 'width 100))

;; Set background and font
(set-background-color "black")
(set-foreground-color "white")

;; Use space for tab and set tab size
(setq-default indent-tabs-mode nil)
(setq c-basic-offset 3)

;; Enable mouse scrolling
(mouse-wheel-mode t)

;; Enable line and column numbering
(line-number-mode 1)
(column-number-mode 1)

;; Make the sequence "C-x w" execute the `what-line' command, 
;; which prints the current line number in the echo area.
(global-set-key "\C-xw" 'what-line)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(standard-indent 3))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

;; ispell executable path for spell check
(setq ispell-program-name "/usr/local/bin/ispell")
