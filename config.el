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
(setq doom-font (font-spec :family "monospace" :size 18 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "sans" :size 19))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

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


;; Maximize when start
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;;  (set-company-backend! 'sh-mode nil) ; unsets backends for sh-mode
(set-company-backend! '(c-mode
                        c++-mode
                        ess-mode
                        haskell-mode
                        ;;emacs-lisp-mode
                        lisp-mode
                        sh-mode
                        php-mode
                        python-mode
                        go-mode
                        ruby-mode
                        rust-mode
                        js-mode
                        css-mode
                        org-mode
                        web-mode
                        )
  '(:separate company-dabbrev-code company-keywords))

(set-company-backend! 'prog-mode
  '(:seperate company-dabbrev))

(setq +lsp-company-backends '(company-capf
                              :with company-yasnippet
                              company-tabnine
                              :separate))
(after! company
  (setq company-idle-delay 0
        company-show-numbers t
        company-minimum-prefix-length 2))

;; dap config
(after! dap-mode
  (dap-register-debug-template
   "Python :: Odoo-Hg"
   (list :type "python"
         :args (list "-c" "/home/fanhe/workspace/odoo14/odoorc")
         :cwd nil
         :module nil
         :program "/home/fanhe/workspace/odoo14/odoo/odoo-bin"
         :request "launch"
         :name "Python :: Odoo-Hg")))

;; tidy add uft8
;; (after! format-all
;;   (set-formatter! 'html-tidy
;;     '("tidy" "-q" "-indent" "-utf8"
;;       "--tidy-mark" "no"
;;       "--wrap" "0"
;;       "--drop-empty-elements" "no"
;;       ("--show-body-only" "%s" (if +format-region-p "true" "auto"))
;;       ("--indent-spaces" "%d" tab-width)
;;       ("--indent-with-tabs" "%s" (if indent-tabs-mode "yes" "no"))
;;       ("-xml" (memq major-mode '(nxml-mode xml-mode))))
;;     :ok-statuses '(0 1)))


(setq-hook! 'nxml-mode-hook +format-with :none)

;; lsp-python-ms
;; (add-hook 'hack-local-variables-hook
;; 	       (lambda ()
;; 		 (when (derived-mode-p 'python-mode)
;; 		   (require 'lsp-python-ms)
;; 		   (lsp)))) ; or lsp-deferred

;; (put 'lsp-python-ms-python-executable 'safe-local-variable (lambda (_) t))
;;put follow in .dir-locals.el
;;((python-mode . ((lsp-python-ms-python-executable . "/usr/bin/python"))))
(after! format
  (set-formatter! 'black "black -S -q -"))
