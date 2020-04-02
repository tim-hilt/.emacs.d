(org-babel-load-file (concat user-emacs-directory "README.org"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-minimum-prefix-length 1)
 '(company-tooltip-align-annotations t)
 '(custom-enabled-themes (quote (doom-one)))
 '(custom-safe-themes
   (quote
    ("e1ecb0536abec692b5a5e845067d75273fe36f24d01210bf0aa5842f2a7e029f" "285efd6352377e0e3b68c71ab12c43d2b72072f64d436584f9159a58c4ff545a" default)))
 '(package-selected-packages
   (quote
    (arduino-mode elpy docker company-auctex adaptive-wrap sublimity centered-window ace-jump-mode pdf-tools ivy-rich hl-todo ivy-prescient prescient flycheck-popup-tip git-gutter-fringe fish-mode csv-mode json-mode yaml-mode disable-mouse which-key org-bullets sudo-edit hungry-delete rainbow-delimiters multiple-cursors expand-region visual-regexp-steroids visual-regexp toc-org org-toc-mode matlab-mode julia-mode lsp-ui company-box auctex magit dashboard doom-modeline all-the-icons counsel swiper doom-themes company-lsp lsp-mode company yasnippet-snippets yasnippet use-package)))
 '(safe-local-variable-values (quote ((TeX-command-extra-options . "--shell-escape"))))
 '(use-package-always-defer t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#282c34" :foreground "#bbc2cf" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 98 :width normal :foundry "SRC" :family "Hack"))))
 '(fringe ((t (:background "#282c34")))))
