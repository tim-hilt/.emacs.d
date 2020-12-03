;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Tim Hilt"
      user-mail-address "timhilt@live.de"
      doom-theme 'doom-one
      org-directory "~/org/")

(defvar bibliography-files '("~/texmf/bibtex/bib/local/bibliography.bib")
  "List of bib-files; used in multiple declarations below")

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

(use-package! org-roam
  :defer t
  :hook ((after-init . org-roam-mode))
  :custom
  (setq org-roam-directory "~/org/roam/"))


(use-package! org-ref
  :after org-roam
  :config
  (setq reftex-default-bibliography bibliography-files
        org-ref-default-bibliography bibliography-files
        org-ref-bibliography-notes "~/org/roam/bibnotes.org"  ;; Is this even needed?
        org-ref-notes-directory "~/org/roam/"
        org-ref-notes-function 'orb-edit-notes
        org-ref-get-pdf-filename-function 'org-ref-get-pdf-filename-helm-bibtex))


(use-package! bibtex-completion
  :defer t
  :config
  (setq bibtex-completion-notes-path "~/org/roam/"
        bibtex-completion-pdf-field "file"
        bibtex-completion-bibliography bibliography-files))


(defvar orb-title-format "${author-or-editor-abbrev} (${date}).  ${title}."
  "Format of the title to use for `orb-templates'.")


(use-package! org-roam-bibtex
  :after org-roam
  :hook (org-roam-mode . org-roam-bibtex-mode)
  :bind (:map org-mode-map
         (("C-c n a" . orb-note-actions)))
  :config
  (setq orb-preformat-keywords
        '(("citekey" . "=key=") "title" "date" "author-or-editor-abbrev")
        orb-templates
        `(("r" "ref" plain
           (function org-roam-capture--get-point)
           ""
           :file-name "${citekey}"
           :head ,(s-join "\n"
                          (list
                           (concat "#+TITLE: " orb-title-format)
                           "#+ROAM_KEY: ${ref}"
                           ""
                           "- tags :: "
                           ""
                           "* Notes"
                           ""))
           :unnarrowed t)
          ("n" "ref + noter" plain
           (function org-roam-capture--get-point)
           ""
           :file-name "${citekey}"
           :head ,(s-join "\n"
                          (list
                           (concat "#+TITLE: " orb-title-format)
                           "#+ROAM_KEY: ${ref}"
                           ""
                           "- tags :: "
                           ""
                           "* Annotations :noter:"
                           ":PROPERTIES:"
                           ":NOTER_DOCUMENT: %(orb-process-file-field \"${citekey}\")"
                           ":NOTER_PAGE:"
                           ":END:"
                           ""))))))


(map! :after pdf-tools
      :map pdf-view-mode-map
      :gn "q" (lambda ()
                (interactive)
                (if (bound-and-true-p org-noter-doc-mode)
                    (org-noter-kill-session)
                  (kill-current-buffer))))


(use-package org-noter
  :after (:any org pdf-view)
  :config
  (setq org-noter-notes-search-path '("~/org/roam")
        org-noter-always-create-frame nil))


;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

(global-subword-mode 1)

(use-package! conda
  :defer t
  :hook (python-mode . conda-env-autoactivate-mode))

(use-package! tex
  :defer t
  :init
  (setq-default TeX-engine 'luatex)
  :config
  (setq +latex-viewers '(zathura)
        TeX-save-query nil))

(use-package! disable-mouse
  :init
  (global-disable-mouse-mode)
  :config
  (mapc #'disable-mouse-in-keymap
        (list evil-motion-state-map
              evil-normal-state-map
              evil-visual-state-map
              evil-insert-state-map)))

(use-package! company
  :config
  (setq company-idle-delay 0
        company-minimum-prefix-length 1
        company-global-modes '(not org-mode)))


(use-package! ivy
  :defer t
  :bind
  (:map ivy-minibuffer-map
   ("RET" . 'ivy-alt-done)
   ("TAB" . 'ivy-alt-done))
  :init
  (setq ivy-extra-directories nil))
