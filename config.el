;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Tim Hilt"
      user-mail-address "timhilt@live.de")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq org-roam-directory "~/org/roam/")
(add-hook! 'after-init-hook
           'org-roam-mode)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

(global-subword-mode 1)

(use-package! conda
  :defer t
  :hook
  (python-mode . conda-env-autoactivate-mode))

(use-package! tex
  :defer t
  :ensure auctex
  :config
  (setq +latex-viewers '(zathura)
        TeX-save-query nil))

;; (use-package! disable-mouse-mode
;;   :init
;;   (global-disable-mouse-mode)
;;   :bind
;;   (mapc #'disable-mouse-in-keymap
;;         (list evil-motion-state-map
;;               evil-normal-state-map
;;               evil-visual-state-map
;;               evil-insert-state-map)))

(use-package! company-mode
  :defer t
  :config
  (setq company-idle-delay 0
        company-minimum-prefix-length 1))

(use-package! ivy
  :defer t
  :bind
  (:map ivy-minibuffer-map
   ("RET" . 'ivy-alt-done)
   ("TAB" . 'ivy-alt-done)))
