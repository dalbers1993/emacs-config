;; MELPA channel hinzufügen für mehr packages
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)


;; Theme einstellen
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'dracula t)
;(load-theme 'mytheme t)

;; Grundsätzliche  Konfigurationen
(use-package emacs
  :config
  (setq ring-bell-function 'ignore)
  (global-visual-line-mode 1)
  (global-display-line-numbers-mode 1)
  (global-hl-line-mode 1)
  (repeat-mode 1)
  (toggle-scroll-bar 0)
  (tool-bar-mode 0)
  (menu-bar-mode 0))

(use-package magit
  :ensure t)

(use-package move-text
  :ensure t
  :config
  (move-text-default-bindings))

;; R-Einestellungen
(use-package ess
  :ensure t
  :config
  (setq inferior-ess-r-program "C:/Program Files/R/R-4.4.2/bin/R.exe" ; R-Path angeben
	inferior-ess-r-help-command "utils::help(\"%s\")\n" ; R-Hilfe in Emacs anzeigen, nicht im Browser
	ess-R-font-lock-keywords ; Keywords farbig darstellen
        '((ess-R-fl-keyword:keywords . t)
          (ess-R-fl-keyword:constants . t)
          (ess-R-fl-keyword:modifiers . t)
          (ess-R-fl-keyword:fun-defs . t)
          (ess-R-fl-keyword:assign-ops . t)
          (ess-R-fl-keyword:%op% . t)
          (ess-fl-keyword:fun-calls . t)
          (ess-fl-keyword:numbers)
          (ess-fl-keyword:operators)
          (ess-fl-keyword:delimiters)
          (ess-fl-keyword:=)
          (ess-R-fl-keyword:F&T . t))))

;; Quarto nicht automatisch den Process buffern
(setq quarto-preview-display-buffer nil)


;; Junge junge Emacs ist so schlecht, dass ich sogar Umlaute erst aktivieren muss
(set-language-environment "UTF-8")


;; Automatisch Autocompletion starten
(add-hook 'after-init-hook 'global-company-mode)



;; cua-mode, damit man wie ein normaler Mensch copy-pasten kann
;; nächste Zeilen sind damit weiterhin Ctrl+Enter in Ess funktioniert
(cua-mode 1) 
(with-eval-after-load 'ess-r-mode
  (define-key cua-global-keymap (kbd "C-<return>") nil)
  (define-key ess-r-mode-map (kbd "C-<return>")
   #'ess-eval-line-and-step))


;; Latex-Einstellungen

;; enquote mit " öffnen
(setq TeX-auto-save t
      TeX-parse-self t
      TeX-save-query nil
      LaTeX-csquotes-open-quote "\\enquote{"
      LaTeX-csquotes-close-quote "}"
      LaTeX-csquotes-quote-after-quote nil)

;; PDF Tools als PDF-Viewer
;(pdf-tools-install)  ; Standard activation command
(pdf-loader-install) ; On demand loading, leads to faster startup time


(setq TeX-view-program-selection '((output-pdf "PDF Tools"))
      TeX-source-correlate-mode t
      TeX-source-correlate-method 'synctex
      TeX-source-correlate-start-server t)

(add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)
(add-hook 'LaTeX-mode-hook #'TeX-source-correlate-mode)
;(add-hook 'pdf-view-mode-hook
;          #'pdf-view-roll-minor-mode)

(setq-default pdf-view-display-size 'fit-height)
(add-hook 'pdf-view-mode-hook (lambda () (display-line-numbers-mode -1)))

;;YAsnippets
(use-package yasnippet
  :hook (LaTeX-mode . yas-minor-mode)
  :config
  (yas-reload-all))

;;dashboard
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-center-content t
	dashboard-items '((recents . 5)
			  (bookmarks . 5))))

;; Geöffnete Buffer und Fenster beim Neustart wiederherstellen
;; das muss ganz runter, weil sonst die anderen Einstellungen  beim init nicht geladen werden
;(desktop-save-mode 1)
;(desktop-read)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(auctex autothemer benchmark-init company dashboard dracula-theme ess
	    magit move-text pdf-tools quarto-mode yasnippet)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
