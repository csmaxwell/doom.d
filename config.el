;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "CS Maxwell"
      user-mail-address "csm@protonmail.com")

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

(setq doom-font (font-spec :family "JetBrains Mono" :size 12))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-acario-dark)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Set visibility of entries for RSS
(after! elfeed
  (setq rmh-elfeed-org-files '("~/org/elfeed.org"))
  (setq elfeed-search-filter "@1-month-ago +unread"))

(after! org-roam
      (setq org-roam-capture-ref-templates
            '(("r" "website" plain (function org-roam-capture--get-point)
               "%?"
               :file-name "references/${slug}"
               :head "#+TITLE: ${title}\n#+ROAM_KEY: ${ref}"
               :unnarrowed t)))
      (setq org-roam-capture-templates
            '(("d" "default" plain #'org-roam-capture--get-point
               "%?"
               :file-name "%<%Y%m%d%H%M%S>-${slug}"
               :head "#+title: ${title}"
               :unnarrowed t )))
      (setq org-roam-directory "~/roam")
      (setq deft-directory "~/roam"))


;; Re-define to get link from DTP3
(defun org-as-get-selected-devonthink-item ()
  "AppleScript to create links to selected items in DEVONthink 3.app."
  (do-applescript
   (concat
    "set theLinkList to {}\n"
    "tell application id \"DNtp\"\n"
    "set selectedRecords to selection\n"
    "set selectionCount to count of selectedRecords\n"
    "if (selectionCount < 1) then\n"
    "return\n"
    "end if\n"
    "repeat with theRecord in selectedRecords\n"
    "set theID to uuid of theRecord\n"
    "set theURL to \"x-devonthink-item:\" & theID\n"
    "set theSubject to name of theRecord\n"
    "set theLink to theURL & \"::split::\" & theSubject & \"\n\"\n"
    "copy theLink to end of theLinkList\n"
    "end repeat\n"
    "end tell\n"
    "return theLinkList as string"
    )))
