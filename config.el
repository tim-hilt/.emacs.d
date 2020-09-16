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

(use-package! org-roam
  :hook ((after-init . org-roam-mode))
  :custom
  (setq org-roam-directory "~/org/roam/"))

(use-package! org-ref
  :after org-roam
  :config
  (setq reftex-default-bibliography '("~/Hahn-Schickard/Bachelorarbeit/Arbeit/library.bib")
        org-ref-default-bibliography '("~/Hahn-Schickard/Bachelorarbeit/Arbeit/library.bib")
        org-ref-bibliography-notes "~/org/roam/bibnotes.org"
        org-ref-notes-directory "~/org/roam/" ;; org-ref also knows where the notes are stored, so there must be some direct way to open them from a cite-link!
        org-ref-notes-function 'orb-edit-notes
        org-ref-get-pdf-filename-function 'org-ref-get-pdf-filename-helm-bibtex))


(use-package! ivy-bibtex
  :after org-ref
  :config
  (setq bibtex-completion-notes-path "~/org/roam/"
        bibtex-completion-bibliography "~/Hahn-Schickard/Bachelorarbeit/Arbeit/library.bib"
        bibtex-completion-pdf-field "file"))


(use-package! org-roam-bibtex
  :after org-roam
  :hook (org-roam-mode . org-roam-bibtex-mode)
  :bind (:map org-mode-map
         (("C-c n a" . orb-note-actions)))
  :config
  (setq orb-preformat-keywords
        '(("citekey" . "=key=") "title" "url" "file" "author-or-editor" "keywords"))

  (setq orb-templates
        '(("r" "ref" plain (function org-roam-capture--get-point)
           ""
           :file-name "${citekey}"
           :head "#+TITLE: ${citekey}: ${title}
#+ROAM_KEY: ${ref}

- tags ::
- keywords :: ${keywords}

* ${title}
:PROPERTIES:
:Custom_ID: ${citekey}
:URL: ${url}
:AUTHOR: ${author-or-editor}
:NOTER_DOCUMENT: %(orb-process-file-field \"${citekey}\")
:NOTER_PAGE:
:END:"))))


(use-package org-noter
  :after (:any org pdf-view)
  :config
  (setq org-noter-notes-search-path '("~/org/roam")
        org-noter-always-create-frame nil)) ;; Everything is relative to the main notes file
        ;; org-noter-notes-window-location 'other-frame ;; The WM can handle splits
        ;;  ;; Please stop opening frames
        ;; org-noter-hide-other nil ;; I want to see the whole file


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

(use-package! company
  :config
  (setq company-idle-delay 0
        company-minimum-prefix-length 1))

(use-package! ivy
  :defer t
  :bind
  (:map ivy-minibuffer-map
   ("RET" . 'ivy-alt-done)
   ("TAB" . 'ivy-alt-done))
  :init
  (setq ivy-extra-directories nil))
