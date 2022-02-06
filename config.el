;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

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
(setq doom-theme 'doom-vibrant)

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

(setq doom-font (font-spec :family "Iosevka SS04" :size 14)
      doom-big-font (font-spec :family "Iosevka SS04" :size 24)
      doom-variable-pitch-font (font-spec :family "Iosevka SS04" :size 14)
      doom-unicode-font (font-spec :family "Iosevka SS04")
      doom-serif-font (font-spec :family "Iosevka SS04" :weight 'light))

(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

;; (setq doom-font (font-spec :family "SauceCodePro Nerd Font Mono" :size 13)
;;       doom-variable-pitch-font (font-spec :family "Ubuntu Nerd Font" :size 13)
;;       doom-big-font (font-spec :family "SauceCodePro Nerd Font Mono" :size 24))

(setq lsp-java-vmargs
      (list
         "-noverify"
         "-Xmx1G"
         "-XX:+UseG1GC"
         "XX:+UseStringDeduplication"
         "-javaagent:~/.local/jars/lombok.jar"))


(setq lsp-java-vmargs '("-noverify" "-Xmx1G" "-XX:+UseG1GC" "-XX:+UseStringDeduplication" "-javaagent:/Users/usrsem/.local/jars/lombok.jar" "-Xbootclasspath/a:/Users/usrsem/.local/jars/lombok.jar"))
(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration))

;; Transperancy
(set-frame-parameter (selected-frame) 'alpha '(93))
(add-to-list 'default-frame-alist '(alpha . (96)))

(setq lsp-ui-doc-show-with-cursor nil) ;; Turn off lsp documentaton pop-ups
;; (global-visual-line-mode t) ;; Line wrapping


;; NeoTree hotkey
;; (require 'neotree)
(global-set-key [f2] 'neotree-toggle)
(setq neo-window-width 100)


(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp))))  ; or lsp-deferred
(setq lsp-pyright-venv-path "./env")

(add-hook 'python-mode-hook
  (lambda () (setq python-indent-offset 4)))

(setq doom-modeline-bar-width 1)

(setq centaur-tabs-style "bar"
      centaur-tabs-height 17)

(blink-cursor-mode 1)

(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\.env\\'"))
  ;; or
  ;; (add-to-list 'lsp-file-watch-ignored-files "[/\\\\]\\.my-files\\'"))

(setq-default
 delete-by-moving-to-trash t                      ; Delete files to trash
 window-combination-resize t                      ; take new window space from all other windows (not just current)
 x-stretch-cursor t)                              ; Stretch cursor to the glyph width

(setq undo-limit 80000000                         ; Raise undo-limit to 80Mb
      evil-want-fine-undo t                       ; By default while in insert all changes are one big blob. Be more granular
      auto-save-default t                         ; Nobody likes to loose work, I certainly don't
      truncate-string-ellipsis "…"                ; Unicode ellispis are nicer than "...", and also save /precious/ space
      password-cache-expiry nil                   ; I can trust my computers ... can't I?
      scroll-preserve-screen-position 'always     ; Don't have `point' jump around
      scroll-margin 7)                            ; It's nice to maintain a little margin

(display-time-mode 1)                             ; Enable time in the mode-line

(unless (string-match-p "^Power N/A" (battery))   ; On laptops...
  (display-battery-mode 1))                       ; it's nice to know how much power you have

(global-subword-mode 1)                           ; Iterate through CamelCase words
(setq display-line-numbers-type 'relative)
(setq doom-fallback-buffer-name "► Doom"
      +doom-dashboard-name "► Doom")
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)


(load! "org-bullets")
(after! org
  (require 'org-bullets)
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
)
