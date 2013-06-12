;;; This file is part of Danil Kutkevich <danil@kutkevich.org> home.
;(add-to-list 'load-path "~/share/emacs/site-lisp")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(scroll-bar-width 7) ;scroll bar <http://emacswiki.org/emacs/ScrollBar>.
 '(safe-local-variable-values (quote ((encoding . utf-8)))))

;;; el-get <http://github.com/dimitri/el-get>.
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
;; (require 'el-get)
(unless (require 'el-get nil t)
  (url-retrieve
   "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
   (lambda (s)
     (goto-char (point-max))
     (eval-print-last-sexp))))
(setq el-get-sources
      '(
        (:name deft
               :after (progn
                        (setq
                         deft-extension "org"
                         deft-text-mode 'org-mode)))
        ;; (:name visws
        ;;        :type emacswik)
        (:name markdown-mode
               :after (progn
                        (add-hook 'markdown-mode-hook
                                  (lambda ()
                                    ;; <http://stackoverflow.com/questions/7598433/how-to-remove-a-key-from-a-minor-mode-keymap-in-emacs#7598754>.
                                    (define-key markdown-mode-map "\M-n" nil) ;unset markdown-next-wiki-link
                                    (define-key markdown-mode-map "\M-p" nil) ;unset markdown-previous-wiki-link
                                    (setq truncate-lines t)))
                        (setq auto-mode-alist
                              (cons '("/README\\'" . markdown-mode)
                                    auto-mode-alist))
                        ;; Mutt temporary files.
                        (setq auto-mode-alist
                              (cons
                               '("/mutt[-a-zA-Z0-9]+\\'" . markdown-mode)
                               auto-mode-alist))
                        ))
        (:name less
               :after (progn
                        ;; (add-hook 'find-file-hook
                        ;;           '(lambda ()
                        ;;              (when buffer-read-only
                        ;;                (less-minor-mode-on))))
                        ;; (global-set-key (kbd "ESC ESC ESC")
                        ;;                 'less-minor-mode)
                        (global-set-key (kbd "M-v") 'less-scroll-down-line)
                        (global-set-key (kbd "C-v") 'less-scroll-up-line)
                        (global-set-key (kbd "M-p") 'scroll-down-command)
                        (global-set-key (kbd "M-n") 'scroll-up-command))
               :type git
               :url "git://github.com/emacsmirror/less.git")
        ;; (:name sass-mode
        ;;        ;; :post-init (lambda ()
        ;;        ;;              (add-to-list 'auto-mode-alist '("\\.scss$" . sass-mode)))
        ;;        :features sass-mode)
        (:name scss-mode
               :after (progn
                        (setq scss-compile-at-save nil)))
        (:name lua-mode
               :after (progn
                        (add-to-list 'auto-mode-alist
                                     '("\\.ws\\'" . lua-mode))
                        ;; <http://lua-users.org/wiki/LuaStyleGuide>,
                        ;; <http://stackoverflow.com/questions/4643206/how-to-configure-indentation-in-emacs-lua-mode#answer-4652043>
                        (setq lua-indent-level 2)))
        ;; (:name lua2-mode
        ;;        :type http
        ;;        ;; :after (lambda ()
        ;;        ;;          (autoload 'lua2-mode "lua2-mode"
        ;;        ;;            "semantic highlighting extension for lua-mode" t))
        ;;        :url "http://www.enyo.de/fw/software/lua-emacs/lua2-mode.el")
        (:name findr
               :type git
               :url "git://github.com/emacsmirror/findr.git")
        (:name window-numbering
               :type git
               :url "git://github.com/nschum/window-numbering.el.git"
               :after (progn
                        (autoload 'window-numbering-mode
                          "window-numbering"
                          "Numbered window shortcuts" t)
                        ;; <http://blog.binchen.org/?p=512#sec-1>.
                        (custom-set-faces
                         '(window-numbering-face
                           ((t (:foreground "brightmagenta" :background nil :weight normal :underline nil)))))
                        (window-numbering-mode 1)))
        ;; ;; Color theme.
        ;; (:name railscasts-theme
        ;;        :description "Railscasts color theme for GNU Emacs"
        ;;        :website "https://github.com/itiut/railscasts-theme"
        ;;        :type github
        ;;        :pkgname "itiut/railscasts-theme"
        ;;        :minimum-emacs-version 24
        ;;        :after (progn
        ;;                 (load-theme 'railscasts t nil))
        ;;        :post-init (add-to-list 'custom-theme-load-path
        ;;                                default-directory))
        ;; (:name bongo
        ;;        :type git
        ;;        :url "git://github.com/dbrock/bongo.git"
        ;;        :after (progn
        ;;                 (autoload 'bongo "bongo"
        ;;                   "Buffer-oriented media player for GNU Emacs." t)))
        ;; (:name highlight-indentation
        ;;        :type git
        ;;        :url "https://github.com/antonj/Highlight-Indentation-for-Emacs"
        ;;        :after (progn
        ;;                 (autoload 'highlight-indentation "highlight-indentation"
        ;;                   "Visual guidelines for indentation (using spaces)" t)))
        (:name rainbow-mode
               :after (progn
                        (add-hook 'css-mode-hook (lambda () (rainbow-mode 1)))
                        (add-hook 'sass-mode-hook (lambda () (rainbow-mode 1)))))
        (:name auto-complete
               :pkgname "auto-complete/auto-complete"
               :type github
               :depends (popup fuzzy)
               :after (progn
                        (require 'auto-complete-config)
                        (ac-config-default)
                        (add-to-list 'ac-modes 'coffee-mode)
                        (add-to-list 'ac-modes 'conf-mode)
                        (add-to-list 'ac-modes 'conf-space-mode)
                        (add-to-list 'ac-modes 'conf-xdefaults-mode)
                        (add-to-list 'ac-modes 'haml-mode)
                        (add-to-list 'ac-modes 'html-mode)
                        (add-to-list 'ac-modes 'lua-mode)
                        (add-to-list 'ac-modes 'markdown-mode)
                        (add-to-list 'ac-modes 'org-mode)
                        (add-to-list 'ac-modes 'rhtml-mode)
                        (add-to-list 'ac-modes 'sass-mode)
                        (add-to-list 'ac-modes 'scss-mode)
                        (add-to-list 'ac-modes 'sgml-mode)
                        (add-to-list 'ac-modes 'yaml-mode)
                        (setq ac-disable-faces (quote (font-lock-doc-face)))))
        (:name fuzzy ;;required by auto-complete
               :website "https://github.com/auto-complete/fuzzy-el"
               :description "Fuzzy matching utilities for GNU Emacs"
               :type github
               :pkgname "auto-complete/fuzzy-el")
        (:name popup ;;required by auto-complete
               :website "https://github.com/auto-complete/popup-el"
               :description "Visual Popup Interface Library for Emacs"
               :type github
               :pkgname "auto-complete/popup-el")
        (:name org-mode
               :after (progn
                        ;; (add-to-list 'auto-mode-alist
                        ;;              '("\\.org\\'" . org-mode))
                        ;; Disable previously defined unstrict pattern.
                        (add-to-list 'auto-mode-alist '("\\.org\\'" . nil))
                        ;; Add more strict pattern.
                        (add-to-list 'auto-mode-alist
                                     '("/org/.*\\.org\\'" . org-mode))
                        (global-set-key "\C-cl" 'org-store-link)
                        (global-set-key "\C-ca" 'org-agenda)
                        (global-set-key "\C-cb" 'org-iswitchb)
                        (setq org-log-done t)

                        ;; Interactively do things (Org-mode with Ido)
                        (add-hook 'org-mode-hook (lambda () (ido-mode t)))
                        (setq org-completion-use-ido t)

                        ;; Org Clock.
                        ;; Sometimes I change tasks I'm clocking
                        ;; quickly - this removes clocked tasks with
                        ;; 0:00 duration.
                        ;;(setq org-clock-out-remove-zero-time-clocks t)

                        ;; Org Agenda.
                        ;; (setq org-agenda-files
                        ;;   (list "~/org/home.org"
                        ;;         "~/org/JohnStudio.org"))
                        (setq org-agenda-files
                              (append (file-expand-wildcards
                                       "~/org/*.org")
                                      (file-expand-wildcards
                                       "~/org/home/*.org")
                                      (file-expand-wildcards
                                       "~/org/work/*.org")))
                        ;; (load-library "find-lisp")
                        ;; (setq org-agenda-files
                        ;;       (find-lisp-find-files "~/org" "\.org\\'"))
                        (setq org-agenda-custom-commands
                              '(("h" "Home" todo "TODO"
                                 ((org-agenda-files
                                   (file-expand-wildcards
                                    "~/org/home/*.org"))))
                                ("w" "Work" todo "TODO"
                                 ((org-agenda-files
                                   (file-expand-wildcards
                                    "~/org/work/*.org"))))))))
        (:name nginx-mode
               :after (progn
                        (setq auto-mode-alist
                              (cons '("/etc/nginx/.*\\.conf\\'" . nginx-mode) auto-mode-alist))))
        ;; (:name ruby-mode
        ;;        :website "https://github.com/danil/ruby-mode"
        ;;        :description "Major mode for editing Ruby files"
        ;;        :type github
        ;;        :pkgname "danil/ruby-mode")
        ;; (:name haml-mode
        ;;        :description "Major mode for editing Haml files"
        ;;        :type github
        ;;        :pkgname "danil/haml-mode")
        (:name ethan-wspace
               :after (progn
                        (setq ethan-wspace-face-customized t) ;<http://github.com/glasserc/ethan-wspace/blob/master/lisp/ethan-wspace.el#L714>
                        (set-face-background 'ethan-wspace-face "#262626") ;#3f3f3f
                        (global-ethan-wspace-mode 1)))
        ;; (:name gpicker
        ;;        :type http
        ;;        :post-init (progn
        ;;                     (autoload 'gpicker-visit-project "gpicker" nil t))
        ;;        :after (progn
        ;;                 (global-set-key (kbd "C-c f c") 'gpicker-visit-project)
        ;;                 (global-set-key (kbd "C-c f f") 'gpicker-find-file))
        ;;        :url "https://raw.github.com/alk/gpicker/v2.2/gpicker.el")
        (:name simp
               ;; :type elpa
               :type github
               :pkgname "re5et/simp"
               :post-init (progn (autoload 'simp-project-define "simp" nil t))
               :after (progn
                        (global-set-key (kbd "C-c f") 'simp-project-find-file)
                        (global-set-key (kbd "C-c s") 'simp-project-rgrep)
                        (setq simp-completing-read-command (quote ido-completing-read))
                        (setq grep-find-ignored-directories ()) ;due to bug <https://github.com/re5et/simp/issues/2>
                        (let
                            ((rails-ignore '(.git
                                            coverage
                                            public/assets
                                            public/images
                                            public/system
                                            tmp
                                            vendor/cache))))
                        (simp-project-define
                         '(:has (.git)
                                :ignore (.git)))
                        (simp-project-define
                         '(:type rails
                                 :has (config.ru app/models app/views app/controllers)
                                 :ignore ,rails-ignore))
                        (simp-project-define
                         '(:type emacs
                                 :has (init.el)
                                 :ignore (.git)))))
        ;; (:name ido-ubiquitous
        ;;        :type elpa
        ;;        :description "Use ido (nearly) everywhere"
        ;;        :post-init (progn
        ;;                     (autoload 'ido-ubiquitous-mode "ido-ubiquitous" nil t))
        ;;        :after (progn
        ;;                 (ido-mode t)
        ;;                 (ido-ubiquitous-mode 1)))
        (:name ido-yes-or-no
               :type elpa
               :description "Use Ido to answer yes-or-no questions"
               :post-init (progn
                            (autoload 'ido-yes-or-no-mode "ido-yes-or-no" nil t))
               :after (progn (ido-yes-or-no-mode 1)))
        ;; (:name ido-better-flex
        ;;        :type elpa)
        (:name smex
               :description "M-x interface with Ido-style fuzzy matching."
               :type github
               :pkgname "nonsequitur/smex"
               :features smex
               :post-init (smex-initialize)
               :after (progn
                        (global-set-key (kbd "M-x") 'smex)
                        (global-set-key (kbd "M-X") 'smex-major-mode-commands)
                        ;; This is your old M-x.
                        (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)))
        ;; (:name jump
        ;;        :type git
        ;;        :url "git://github.com/emacsmirror/jump.git")
        ;; (:name rinari
        ;;        ;; :after (lambda ()
        ;;        ;;          (autoload 'rinari-web-server "rinari"
        ;;        ;;            "Run Rails script/server." t))
        ;;        ;; :build nil
        ;;        ;; :info nil
        ;;        )
        ;; (:name emacs-rails ;<http://stackoverflow.com/questions/2713096/emacs-rails-vs-rinari>
        ;;        :type git
        ;;        :url "git://github.com/remvee/emacs-rails.git")
        (:name rhtml-mode
               :post-init (progn
                            (autoload 'rhtml-mode "rhtml-mode" nil t)
                            (add-to-list 'auto-mode-alist '("\\.erb$" . rhtml-mode))
                            (add-to-list 'auto-mode-alist '("\\.html\.erb$" . rhtml-mode))))
        ;; (:name mmm-mode
        ;;        :description "Allow Multiple Major Modes in a buffer"
        ;;        :type github
        ;;        :pkgname "purcell/mmm-mode"
        ;;        :post-init (progn
        ;;                     (autoload 'mmm-add-mode-ext-class "mmm-mode" nil t))
        ;;        :after (progn
        ;;                 ;; <https://github.com/purcell/emacs.d/blob/master/init-mmm.el>.
        ;;                 (setq mmm-global-mode 'buffers-with-submode-classes)
        ;;                 (setq mmm-submode-decoration-level 2)
        ;;                 ;; (setq mmm-parse-when-idle t)
        ;;                 ;; <https://github.com/purcell/emacs.d/blob/master/init-ruby-mode.el>.
        ;;                 (defun sanityinc/ensure-mmm-erb-loaded ()
        ;;                   (require 'mmm-erb))
        ;;                 (dolist (hook (list 'html-mode-hook 'nxml-mode-hook 'yaml-mode-hook))
        ;;                   (add-hook hook 'sanityinc/ensure-mmm-erb-loaded))
        ;;                 (dolist (mode (list 'html-mode 'html-erb-mode 'nxml-mode))
        ;;                   (mmm-add-mode-ext-class mode "\\.r?html\\(\\.erb\\)?\\'" 'html-js)
        ;;                   (mmm-add-mode-ext-class mode "\\.r?html\\(\\.erb\\)?\\'" 'html-css)
        ;;                   (mmm-add-mode-ext-class mode "\\.erb\\'" 'erb))
        ;;                 (mmm-add-mode-ext-class 'html-erb-mode "\\.jst\\.ejs\\'" 'ejs)
        ;;                 (add-to-list 'auto-mode-alist '("\\.r?html\\(\\.erb\\)?\\'" . html-erb-mode))
        ;;                 (add-to-list 'auto-mode-alist '("\\.jst\\.ejs\\'"  . html-erb-mode))
        ;;                 (mmm-add-mode-ext-class 'yaml-mode "\\.yaml\\'" 'erb)
        ;;                 (dolist (mode (list 'js-mode 'js2-mode 'js3-mode))
        ;;                   (mmm-add-mode-ext-class mode "\\.js\\.erb\\'" 'erb))))
        (:name column-marker
               :after (progn
                         (set-face-background 'column-marker-1 "#393b3f")
                        (defun my-column-marker ()
                          (unless buffer-read-only (column-marker-1 79)))
                        ;; (add-hook 'mail-mode-hook (lambda () (interactive) (my-column-marker)))
                        ;; (add-hook 'whitespace-mode-hook (lambda () (interactive) (column-marker-1 80)))
                        (add-hook 'awk-mode-hook (lambda () (interactive) (my-column-marker)))
                        (add-hook 'change-log-mode-hook (lambda () (interactive) (my-column-marker)))
                        (add-hook 'coffee-mode-hook (lambda () (interactive) (my-column-marker)))
                        (add-hook 'conf-mode-hook (lambda () (interactive) (my-column-marker)))
                        (add-hook 'css-mode-hook (lambda () (interactive) (my-column-marker)))
                        (add-hook 'emacs-lisp-mode-hook (lambda () (interactive) (my-column-marker)))
                        (add-hook 'haml-mode-hook (lambda () (interactive) (my-column-marker)))
                        (add-hook 'haskell-mode-hook (lambda () (interactive) (my-column-marker)))
                        (add-hook 'html-mode-hook (lambda () (interactive) (my-column-marker)))
                        (add-hook 'java-mode-hook (lambda () (interactive) (my-column-marker)))
                        (add-hook 'js-mode-hook (lambda () (interactive) (my-column-marker)))
                        (add-hook 'lisp-mode-hook (lambda () (interactive) (my-column-marker)))
                        (add-hook 'lua-mode-hook (lambda () (interactive) (my-column-marker)))
                        (add-hook 'makefile-gmake-mode-hook (lambda () (interactive) (my-column-marker)))
                        (add-hook 'markdown-mode-hook (lambda () (interactive) (my-column-marker)))
                        (add-hook 'nxml-mode-hook (lambda () (interactive) (my-column-marker)))
                        (add-hook 'org-mode-hook (lambda () (interactive) (my-column-marker)))
                        (add-hook 'perl-mode-hook (lambda () (interactive) (my-column-marker)))
                        (add-hook 'php-mode-hook (lambda () (interactive) (my-column-marker)))
                        (add-hook 'ruby-mode-hook (lambda () (interactive) (my-column-marker)))
                        (add-hook 'sass-mode-hook (lambda () (interactive) (my-column-marker)))
                        (add-hook 'sgml-mode-hook (lambda () (interactive) (my-column-marker)))
                        (add-hook 'sh-mode-hook (lambda () (interactive) (my-column-marker)))
                        (add-hook 'sql-mode-hook (lambda () (interactive) (my-column-marker)))
                        (add-hook 'xml-mode-hook (lambda () (interactive) (my-column-marker)))
                        (add-hook 'yaml-mode-hook (lambda () (interactive) (my-column-marker)))))
        (:name coffee-mode
               :website "http://ozmm.org/posts/coffee_mode.html"
               :description "Emacs Major Mode for CoffeeScript"
               :type github
               :pkgname "defunkt/coffee-mode"
               :features coffee-mode
               :post-init (progn
                            (add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
                            (add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))
                            ;; it defaults to js2-mode, which is not present in Emacs by default
                            (setq coffee-js-mode 'javascript-mode))
               :after (progn
                        (defun coffee-custom ()
                          "coffee-mode-hook"
                          (set (make-local-variable 'tab-width) 2))
                        (add-hook 'coffee-mode-hook
                                  '(lambda() (coffee-custom)))))
        (:name idle-highlight-mode
               :description "Idle Highlight Mode."
               :website "https://github.com/nonsequitur/idle-highlight-mode"
               :type github
               :after (progn
                        (add-hook 'awk-mode-hook (lambda () (idle-highlight-mode t)))
                        (add-hook 'change-log-mode-hook (lambda () (idle-highlight-mode t)))
                        (add-hook 'coffee-mode-hook (lambda () (idle-highlight-mode t)))
                        (add-hook 'conf-mode-hook (lambda () (idle-highlight-mode t)))
                        (add-hook 'conf-space-mode-hook (lambda () (idle-highlight-mode t)))
                        (add-hook 'conf-xdefaults-mode-hook (lambda () (idle-highlight-mode t)))
                        (add-hook 'css-mode-hook (lambda () (idle-highlight-mode t)))
                        (add-hook 'emacs-lisp-mode-hook (lambda () (idle-highlight-mode t)))
                        (add-hook 'haml-mode-hook (lambda () (idle-highlight-mode t)))
                        (add-hook 'haskell-mode-hook (lambda () (idle-highlight-mode t)))
                        (add-hook 'html-mode-hook (lambda () (idle-highlight-mode t)))
                        (add-hook 'java-mode-hook (lambda () (idle-highlight-mode t)))
                        (add-hook 'js-mode-hook (lambda () (idle-highlight-mode t)))
                        (add-hook 'lisp-mode-hook (lambda () (idle-highlight-mode t)))
                        (add-hook 'lua-mode-hook (lambda () (idle-highlight-mode t)))
                        (add-hook 'makefile-gmake-mode-hook (lambda () (idle-highlight-mode t)))
                        (add-hook 'markdown-mode-hook (lambda () (idle-highlight-mode t)))
                        (add-hook 'nxml-mode-hook (lambda () (idle-highlight-mode t)))
                        (add-hook 'org-mode-hook (lambda () (idle-highlight-mode t)))
                        (add-hook 'perl-mode-hook (lambda () (idle-highlight-mode t)))
                        (add-hook 'php-mode-hook (lambda () (idle-highlight-mode t)))
                        (add-hook 'rhtml-mode-hook (lambda () (idle-highlight-mode t)))
                        (add-hook 'ruby-mode-hook (lambda () (idle-highlight-mode t)))
                        (add-hook 'sass-mode-hook (lambda () (idle-highlight-mode t)))
                        (add-hook 'scss-mode-hook (lambda () (idle-highlight-mode t)))
                        (add-hook 'sgml-mode-hook (lambda () (idle-highlight-mode t)))
                        (add-hook 'sh-mode-hook (lambda () (idle-highlight-mode t)))
                        (add-hook 'sql-mode-hook (lambda () (idle-highlight-mode t)))
                        (add-hook 'xml-mode-hook (lambda () (idle-highlight-mode t)))
                        (add-hook 'yaml-mode-hook (lambda () (idle-highlight-mode t))))
               :pkgname "nonsequitur/idle-highlight-mode")
        (:name flymake-easy
               :type github
               :description "Helpers for easily building flymake checkers"
               :pkgname "purcell/flymake-easy"
               :after (progn
                        (custom-set-faces
                         '(flymake-errline ((((class color)) (:foreground "red"))))
                         '(flymake-warnline ((((class color)) (:background "#393b3f"))))
                         ))
               :website "http://github.com/purcell/flymake-easy")
        (:name flymake-ruby
               :type github
               :description "A flymake handler for ruby-mode files"
               :pkgname "purcell/flymake-ruby"
               :website "http://github.com/purcell/flymake-ruby"
               :depends (flymake-easy)
               :post-init (progn
                            (add-hook 'ruby-mode-hook 'flymake-ruby-load)
                            (add-hook 'rspec-mode-hook (lambda () (flymake-mode -1)))))
        (:name flymake-shell
               :type github
               :pkgname "purcell/flymake-shell"
               :description "A flymake syntax-checker for shell scripts"
               :website "http://github.com/purcell/flymake-shell"
               :depends (flymake-easy)
               :post-init (progn
                            (add-hook 'shell-script-mode-hook 'flymake-shell-load)
                            (add-hook 'sh-mode-hook 'flymake-shell-load)))
        (:name flymake-haml
               :type github
               :pkgname "purcell/flymake-haml"
               :description "Flymake handler for haml files"
               :website "http://github.com/purcell/flymake-haml"
               :depends (flymake-easy)
               :post-init (add-hook 'haml-mode-hook 'flymake-haml-load))
        (:name flymake-coffee
               :type github
               :pkgname "purcell/flymake-coffee"
               :description "Flymake support for coffee script"
               :website "http://github.com/purcell/flymake-coffee"
               :depends (flymake-easy)
               :post-init (progn
                            (add-to-list 'load-path "~/node_modules/.bin/coffee") ;make sure we can find the coffee executable
                            (add-hook 'coffee-mode-hook 'flymake-coffee-load)))
        (:name flymake-sass
               :type github
               :pkgname "purcell/flymake-sass"
               :description "Flymake handler for sass files"
               :website "http://github.com/purcell/flymake-sass"
               :depends (flymake-easy)
               :post-init (add-hook 'sass-mode-hook 'flymake-sass-load))
        (:name flymake-css
               :type github
               :pkgname "purcell/flymake-css"
               :description "Flymake support for css using csslint"
               :website "http://github.com/purcell/flymake-css"
               :depends (flymake-easy)
               :post-init (add-hook 'css-mode-hook 'flymake-css-load))
        (:name git-gutter
               :description "Emacs port of GitGutter Sublime Text 2 Plugin"
               :website "https://github.com/syohex/emacs-git-gutter"
               :type github
               :pkgname "syohex/emacs-git-gutter")
        (:name git-gutter-fringe
               :type github
               :pkgname "syohex/emacs-git-gutter-fringe"
               :description "Fringe version of git-gutter.el"
               :depends (git-gutter fringe-helper))
        ))

(setq my-packages
      (append
       '(
         ;; auto-complete-ruby ;buggy(
         ;; bongo
         ;; gpicker
         ;; helm
         ;; ido-better-flex
         ;; ido-ubiquitous
         ;; jump
         ;; ruby-mode ;Matsumoto's work well with haml, but 1.9 style hash syntax highlighting is buggy
         ;; vline
         git-gutter-fringe
         apache-mode
         auto-complete-chunk
         auto-complete-css
         auto-complete-emacs-lisp
         auto-complete-etags
         coffee-mode
         column-marker
         crontab-mode
         csv-mode
         deft
         egg
         ethan-wspace
         evil
         findr
         flymake-coffee
         flymake-haml
         flymake-ruby
         flymake-sass
         flymake-shell
         go-mode
         haml-mode
         haskell-mode
         idle-highlight-mode
         ido-yes-or-no
         inf-ruby
         less
         lua-mode
         magit
         markdown-mode
         nginx-mode
         org-mode
         paredit
         php-mode
         rainbow-mode
         rhtml-mode
         rinari
         rspec-mode
         rvm
         sass-mode
         scss-mode
         simp
         smex
         window-numbering
         yaml-mode
         yasnippet
         )
       (mapcar 'el-get-source-name el-get-sources)))

(el-get 'sync my-packages)

(setq system-time-locale "C")
(setq calendar-week-start-day 1)
(global-font-lock-mode 1)

;;; BackspaceKey <http://emacswiki.org/BackspaceKey>.
;; (keyboard-translate ?\C-h ?\C-?)
(global-set-key [(control h)] 'delete-backward-char)

;;; Transient Mark mode <http://emacswiki.org/TransientMarkMode>.
(transient-mark-mode 1)
;; (set-face-background 'region nil)
;; (set-face-attribute 'region nil :inverse-video t)

(set-background-color "#0f0f0f")
(set-cursor-color "#aa0000")
(set-face-background 'region "#002b36") ;#2E3436 ;set selection background color

;;; Truncation of Lines (toggle-truncate-lines) <http://emacswiki.org/emacs/TruncateLines>.
(set-default 'truncate-lines t)
;;; Horizontal Scrolling
;;; <http://gnu.org/software/emacs/manual/html_node/emacs/Horizontal-Scrolling.html#Horizontal-Scrolling>.
(put 'scroll-left 'disabled nil)
;(set-keyboard-coding-system 'mule-utf-8)
;(set-default-coding-systems 'utf-8)
;(set-terminal-coding-system 'utf-8)
;(modify-coding-system-alist 'file "/home/danil/src/vendor/prohq/avers/" 'utf-8)
;(set-language-environment 'cyrillic-koi8)
(setq default-tab-width 4)
(setq-default indent-tabs-mode nil)
(setq standard-indent 2)
;;; show-paren-mode <http://emacswiki.org/ShowParenMode>,
;;; <http://emacswiki.org/ParenthesesAppearance>
(show-paren-mode 1)

;;; Session Management <http://emacswiki.org/SessionManagement>.
(savehist-mode 1)
;;; Desktop <http://emacswiki.org/DeskTop>.
;;(desktop-save-mode 1)
;; <http://stackoverflow.com/questions/4477376/some-emacs-desktop-save-questions-how-to-change-it-to-save-in-emacs-d-emacs#answer-4485083>.
(defun my-desktop ()
  "Load the desktop and enable autosaving"
  (interactive)
  (let ((desktop-load-locked-desktop "ask"))
    (desktop-read)
    (desktop-save-mode 1)))

;;; Recentf (open recent files)
;;; <http://stackoverflow.com/questions/3527150/open-recent-in-emacs#answer-3527488>,
;;; <http://emacswiki.org/RecentFiles>.
(recentf-mode 1)
;; If you make extensive use of Tramp, recentf will track those files
;; too, and do it's periodic cleanup thing which can be a real mess
;; since the files are remote. Prevent this by putting this in your
;; startup file:
(setq recentf-auto-cleanup 'never)

;;; Menu Bar
;;; <http://gnu.org/software/emacs/manual/html_node/emacs/Menu-Bars.html>,
;;; <http://emacswiki.org/MenuBar>.
(menu-bar-mode -1)
(setq initial-scratch-message
";; This buffer is for notes you don't want to save, and for Lisp evaluation.
;; If you want to create a file, visit that file with C-x C-f,
;; then enter the text in that file's own buffer.
")

;;; Tool bar <http://emacswiki.org/ToolBar#toc1>,
;;; <http://superuser.com/questions/127420/how-can-i-hide-the-tool-bar-in-emacs-persistently#127422>.
(tool-bar-mode -1)

;; ;;; <http://emacswiki.org/ScrollBar>.
;; (scroll-bar-mode -1)
;; <http://stackoverflow.com/questions/3155451/emacs-scrollbar-customize#3159618>.
(set-face-background 'scroll-bar "white")
(set-face-foreground 'scroll-bar "gray")

;;; AnsiColor (Emacs terminal related stuff)
;;; <http://emacswiki.org/AnsiColor>.
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;;; Highlight current line
;;; <http://emacs-fu.blogspot.com/2008/12/highlighting-current-line.html>,
;;; <http://stackoverflow.com/questions/2718189/emacshighlight-the-current-line-by-underline-it#answer-2718543>.
(defface hl-line '((t (:background nil))) ;#222
  "Face to use for `hl-line-face`." :group 'hl-line)
(setq hl-line-face 'hl-line)
(global-hl-line-mode 1)
(set-face-attribute hl-line-face nil :underline t) ;looks inconsistent with fill-column-indicator
;;; <http://emacsblog.org/2007/04/09/highlight-the-current-line/#comment-284>.
(defun local-hl-line-mode-off ()
  (interactive)
  (make-local-variable 'global-hl-line-mode)
  (setq global-hl-line-mode nil))
(add-hook 'ediff-mode-hook 'local-hl-line-mode-off)
(add-hook 'term-mode-hook 'local-hl-line-mode-off)
(global-rinari-mode)

;;; Column number mode
;;; <http://gnu.org/software/emacs/manual/html_node/emacs/Optional-Mode-Line.html>.
;(setq line-number-mode t)
(setq column-number-mode 1)

;;; IswitchB <http://emacswiki.org/IswitchBuffers>.
;; (iswitchb-mode 1)
;; (setq iswitchb-buffer-ignore '("^ " "*scratch*" "*Messages*"
;;                                "*Completions*" "*Ibuffer*"))
;(setq iswitchb-default-method 'samewindow)

;;; Ibuffer <http://emacswiki.org/IbufferMode>,
;;; <http://emacs-fu.blogspot.ru/2010/02/dealing-with-many-buffers-ibuffer.html>,
;;; <http://martinowen.net/blog/2010/02/tips-for-emacs-ibuffer.html>.
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)
;(setq ibuffer-use-other-window 1)
;; <http://stackoverflow.com/questions/7598433/how-to-remove-a-key-from-a-minor-mode-keymap-in-emacs#7598754>.
(define-key ibuffer-mode-map "\M-n" nil) ;unset ibuffer-forward-filter-group
(define-key ibuffer-mode-map "\M-p" nil) ;unset ibuffer-backward-filter-group

;;; Interactively do things.
;; (ido-mode t)
(ido-mode 'both) ;for buffers and files
(setq
 ;; ido-save-directory-list-file "~/.emacs.d/cache/ido.last"
 ;; ido-ignore-buffers '("\\` " "^\*Mess" "^\*Back" ".*Completion" "^\*Ido" "^\*trace" "^\*compilation" "^\*GTAGS" "^session\.*") ;"^\*") ;ignore these guys
 ido-work-directory-list '("~/" "~/Desktop" "~/Documents" "~src")
 ido-case-fold  t                 ; be case-insensitive

 ido-enable-last-directory-history t ;remember last used dirs
 ido-max-work-directory-list   30    ;should be enough
 ido-max-work-file-list        50    ;remember many
 ido-use-filename-at-point     nil   ;don't use filename at point (annoying)
 ido-use-url-at-point          nil   ;don't use url at point (annoying)

 ido-enable-flex-matching      t     ;fuzzy matching <http://webcache.googleusercontent.com/search?q=cache:wOWaMK_w_joJ:emacsblog.org/2008/05/19/giving-ido-mode-a-second-chance/&hl=en&tbo=d&strip=1>
 ido-max-prospects             100   ;don't spam my minibuffer
 ido-confirm-unique-completion t     ;wait for RET, even with unique completion

 ido-max-directory-size 100000
 ;; ido-everywhere t
 ;; ido-use-virtual-buffers t           ;if Recentf is enabled
 )
(setq confirm-nonexistent-file-or-buffer nil) ;when using ido, the confirmation is rather annoying...

;;; Server <http://shreevatsa.wordpress.com/tag/emacs/>.
;; (remove-hook 'kill-buffer-query-functions
;;              'server-kill-buffer-query-function)

;;; Uniquify
;;; <http://gnu.org/software/emacs/manual/html_node/emacs/Uniquify.html>,
;;; <http://emacs-fu.blogspot.ru/2009/11/making-buffer-names-unique.html>.
(require 'uniquify)
;; nil, forward, reverse, post-forward or post-forward-angle-brackets
(setq
 uniquify-buffer-name-style 'post-forward ;'forward
 uniquify-separator ":" ;"/"
 ;; uniquify-after-kill-buffer-p t ;rename after killing uniquified
 ;; uniquify-ignore-buffers-re "^\\*" ;don't muck with special buffers
 )

;;; Browse Url with Epiphany.
;(setq browse-url-browser-function 'browse-url-epiphany)

;; (setq browse-url-browser-function 'browse-url-generic
;;   browse-url-generic-program "epiphany"
;;   browse-url-generic-args '("--new-tab"))
(setq browse-url-browser-function 'browse-url-generic
  browse-url-generic-program "google-chrome")

;;; Spelling.
;(setq-default ispell-program-name "/usr/bin/aspell")
;(setq-default ispell-program-name "/usr/bin/hunspell")
(setq ispell-dictionary "ru")

;;; InteractiveSpell.
;(setq ispell-dictionary "german")

;;; TRAMP.
;;; <http://emacswiki.org/TrampMode>.
;(setq tramp-default-method "ssh")

;;; HTML mode.
(add-to-list 'auto-mode-alist '("\\.lp\\'" . html-mode))
(add-to-list 'auto-mode-alist '("\\.op\\'" . html-mode))

;;; Logrotate scripts.
(add-to-list 'auto-mode-alist '("/etc/logrotate.d/" . shell-script-mode))
(add-to-list 'auto-mode-alist '("\\.logrotate\\'" . shell-script-mode))

;;; Cron.
(setq auto-mode-alist
      (cons '("/crontab\\'" . shell-script-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("/anacrontab\\'" . shell-script-mode) auto-mode-alist))

;;; Shell scripts.
(setq auto-mode-alist
      (cons '("/\\.bash_aliases\\'" . shell-script-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("/\\.ackrc\\'" . shell-script-mode) auto-mode-alist))

;;; Configs.
(setq auto-mode-alist
      (cons '("/\\.gitconfig\\'" . conf-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("/\\.inputrc\\'" . conf-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("/\\.screenrc\\'" . conf-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("/\\.moc/keymap\\'" . conf-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("/\\.Xmodmap\\'" . conf-xdefaults-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("/\\.rvmrc\\'" . conf-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("/\\.curlrc\\'" . conf-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("/conkyrc_calendar\\'" . conf-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("/conkyrc_top\\'" . conf-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("/portage/package\\.license\\'" . conf-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("/share/applications/defaults\\.list\\'" . conf-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("/etc/fstab\\'" . conf-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("/etc/hosts\\'" . conf-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("\\.pkla\\'" . conf-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("\\.cnf\\'" . conf-mode) auto-mode-alist))

;;; Lisp.
(setq auto-mode-alist
      (cons '("/\\.stumpwmrc\\'" . lisp-mode) auto-mode-alist))

;;; Cucumber features.
(setq auto-mode-alist
      (cons '("\\.features\\'" . conf-mode) auto-mode-alist))

;;; Gentoo ebuild.
;; (setq auto-mode-alist
;;       (cons '("\\.ebuild\\'" . sh-mode) auto-mode-alist))

;;; Gentoo confs.
(add-to-list 'auto-mode-alist '("/etc/conf.d/" . conf-mode))
(add-to-list 'auto-mode-alist '("/etc/env.d/" . conf-mode))
(setq auto-mode-alist
      (cons '("/etc/portage/package\\.mask\\'" . conf-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("/etc/portage/package\\.keywords\\'" . conf-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("/etc/portage/package\\.use\\'" . conf-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("/etc/portage/package\\.unmask\\'" . conf-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("/etc/portage/profile/use\\.mask\\'" . conf-mode) auto-mode-alist))

(require 'site-gentoo)

;;; ruby-mode.
(setq auto-mode-alist
      (cons '("/[rR]akefile\\'" . ruby-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("\\.rake\\'" . ruby-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("/Gemfile\\'" . ruby-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("/Capfile\\'" . ruby-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("/Guardfile\\'" . ruby-mode) auto-mode-alist))
;; (add-hook 'ruby-mode-hook 'ror-doc-lookup)
(add-hook 'ruby-mode-hook
          (lambda () (interactive)
            (remove-hook 'before-save-hook 'ruby-mode-set-encoding)))
(setq auto-mode-alist
      (cons '("\\.mrb\\'" . ruby-mode) auto-mode-alist))

;;; JavaScript mode.
;;; HTML Components (HTCs or .htc)
;;; <http://en.wikipedia.org/wiki/HTML_Components>.
(add-to-list 'auto-mode-alist '("\\.htc$" . js-mode))
(setq js-indent-level 2)

;;; CSS mode
;;; <http://emacswiki.org/emacs/css-mode.el>.
(setq css-indent-offset 2)

;;; Auto Fill Mode
;;; <http://gnu.org/software/emacs/manual/html_node/emacs/Auto-Fill.html>.
;(add-hook 'mail-mode-hook (lambda () (auto-fill-mode t)))

;;; Tags
;;; <http://emacswiki.org/BuildTags#toc2>.
(setq path-to-ctags "/usr/bin/exuberant-ctags")
(defun create-tags (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (shell-command
   (format "%s -f %s/TAGS -e -R %s" path-to-ctags dir-name dir-name)))

;; Mew is a mail reader for Emacs <http://mew.org>, <http://emacswiki.org/Mew>.
(autoload 'mew "mew" nil t)
(autoload 'mew-send "mew" nil t)
;; ;; Optional setup (e.g. C-xm for sending a message):
;; (autoload 'mew-user-agent-compose "mew" nil t)
;; (if (boundp 'mail-user-agent)
;;     (setq mail-user-agent 'mew-user-agent))
;; (if (fboundp 'define-mail-user-agent)
;;     (define-mail-user-agent
;;       'mew-user-agent
;;       'mew-user-agent-compose
;;       'mew-draft-send-message
;;       'mew-draft-kill
;;       'mew-send-hook))

;;; My keyboard macroses.
;; <http://emacs-fu.blogspot.ru/2010/07/keyboard-macros.html>.
(fset 'my-kbd-macro-ruby-new-hash-syntax
   "\C-s =>\C-m\C-r:\C-m\C-d\C-s =>\C-m\C-?\C-?\C-?:")
(fset 'my-kbd-macro-ruby-string-to-symbol
   "\C-[\C-s\\(\"\\|'\\)\C-s\C-m\C-?\C-[\C-r\\(\"\\|'\\)\C-m\C-d:")

;;; ri-emacs.
;; (setq ri-ruby-script "~/share/emacs/site-lisp/ri-emacs/ri-emacs.rb")
;; (autoload 'ri "~/share/emacs/site-lisp/ri-emacs/ri-ruby.el" nil t)
;; (add-hook 'ruby-mode-hook
;;   (lambda ()
;;     (local-set-key 'f1 'ri)
;;     (local-set-key "\M-\C-i" 'ri-ruby-complete-symbol)
;;     (local-set-key 'f4 'ri-ruby-show-args)
;;     ))

;;; Ruby and Rails documentation lookup.
;; (defun ror-doc-lookup () (local-set-key (kbd "<f1>") 'doc-symbol-lookup))
;; ;http://www.google.com/search?num=100&q=site%3Aruby-doc.org/core+
;; (defun doc-symbol-lookup ()
;;   (interactive)
;;   (let ((symbol (symbol-at-point)))
;;     (if (not symbol)
;;       (message "No symbol at point.")
;;       (browse-url
;;         (concat
;;           "http://www.google.com/search?num=100&q=site%3Aapi.rubyonrails.org+"
;;           (symbol-name symbol))))))

;;; DVC.
;(add-to-list 'load-path "~/share/emacs/site-lisp/dvc")
;(autoload 'dvc-status "dvc-load" nil t)
;(setq dvc-tips-enabled nil)

;;; psvn.
; Set up autoloads for psvn (svn directory edit mode for emacs)
;(autoload 'svn-status "psvn" nil t)

;;; Icicles -- enhances minibuffer completion
;;; <http://emacsmirror.org/package/icicles.html>,
;;; <http://emacswiki.org/emacs/Icicles>.
;; (add-to-list 'load-path "~/share/emacs/site-lisp/icicles")
;; (autoload 'icicle-mode "icicles" "Enhances minibuffer completion" t)

;; ;;; Viper.
;; ;;; Changing viper-toggle-key <http://emacswiki.org/ViperMode#toc14>
;; (setq viper-toggle-key "\C-q")
;; ;;; Deactivate Viper for a single buffers
;; ;;; <http://emacswiki.org/emacs/ViperMode#toc9>.
;; ;;(viper-change-state-to-emacs)
;; (setq viper-mode t)
;; (require 'viper)

;;; jabber.el
;; Set up autoloads for jabber.el
;(require 'jabber)
;; (autoload 'jabber-connect "jabber" nil t)
;; (setq jabber-account-list (quote (("danilkutkevich@jabber.org"))))
;; (setq jabber-history-enabled t)

;; Flymake <http://emacswiki.org/FlyMake>.
;; Don't want flymake mode for ruby regions in rhtml files and also on
;; read only files.
;; (add-hook 'ruby-mode-hook
;;   '(lambda () (if (and (not (null buffer-file-name))
;;                        (file-writable-p buffer-file-name))
;;                   (flymake-mode))))

;; (setq interpreter-mode-alist
;;      (cons '("ruby" . ruby-mode) interpreter-mode-alist))
;; (autoload 'run-ruby "inf-ruby" "Run an inferior Ruby process")
;; (autoload 'inf-ruby-keys "inf-ruby"
;;  "Set local key defs for inf-ruby in ruby-mode")
;; (add-hook 'ruby-mode-hook
;;          '(lambda ()
;;             (inf-ruby-keys)
;;             ))

;;; Newsticker <http://www.nongnu.org/newsticker>,
;;; <http://lists.gnu.org/archive/html/gnu-emacs-sources/2008-12/msg00009.html>.
;; ;;(setq newsticker-groups-filename "~/MyEmacs/Configure-File/Newsticker/newsticker-groups")
;; ;;(setq newsticker-imagecache-dirname "~/MyEmacs/Configure-File/Newsticker/newsticker-images")
;; ;;(setq newsticker-dir "~/MyEmacs/Configure-File/Newsticker")
;; (setq newsticker-automatically-mark-items-as-old nil)
;; (setq newsticker-automatically-mark-visited-items-as-old nil)
;; ;;(setq newsticker-retrieval-interval 600)
;; (setq newsticker-html-renderer (quote w3m-region))
;; ;;(setq newsticker-retrieval-method (quote extern))
;; ;;(setq newsticker-treeview-treewindow-width 40)
;; ;;(setq newsticker-treeview-listwindow-height 30)
;; ;;(setq newsticker-wget-arguments (quote ("-q" "-O" "-" "--user-agent" "testing")))
;; ;;(run-with-timer 0 newsticker-update-news-repeat 'newsticker-update-news)
;; (setq newsticker-url-list-defaults
;;       '(
;;         ("bzr_day" "http://bzr-day.blogspot.com/feeds/posts/default?alt=rss")
;;         ("emacs_planet_ru" "http://emacs.defun.ru/atom.xml")
;;         ("jquery_blog" "http://feeds.feedburner.com/jquery/")
;;         ("keplerproject_org_unix_installation" "http://keplerproject.org/en/UNIX_Installation.rss")
;;         ("lj_ru_gentoo" "http://community.livejournal.com/ru_gentoo/data/rss")
;;         ("openmoko_planet" "http://planet.openmoko.org/rss10.xml")
;;         ("rail0rz" "http://feeds2.feedburner.com/railorz")
;;         ("railscasts" "http://feeds.feedburner.com/railscasts")
;;         ("railsclub_ru" "http://feeds2.feedburner.com/RailsClubRu")
;;         ("ruby_noname_podcast" "http://ruby.rpod.ru/rss.xml")
;;         ("rubyonrails_planet_ru" "http://planet.rubyonrails.ru/xml/rss")
;;         ("softwaremaniacs_org" "http://softwaremaniacs.org/blog/feed/")
;;         ))

;; ;;; Get Rid of Annoying Backups and Autosaves.
;; ;; Redefining the make-backup-file-name function in order to get
;; ;; backup files in ~/.backups/ rather than scattered around all over
;; ;; the filesystem. Note that you must have a directory ~/.backups/
;; ;; made.  This function looks first to see if that folder exists.  If
;; ;; it does not the standard backup copy is made.
;; (defun make-backup-file-name (file-name)
;;   "Create the non-numeric backup file name for `file-name'."
;;   (require 'dired)
;;   (if (file-exists-p "~/.backups")
;;       (concat (expand-file-name "~/.backups/")
;;               (dired-replace-in-string "/" "!" file-name))
;;     (concat file-name "~")))

;; ;; Redefining the make-auto-save-file-name function in order to get
;; ;; autosave files sent to a single directory.  Note that this function
;; ;; looks first to determine if you have a ~/.autosaves/ directory.  If
;; ;; you do not it proceeds with the standard auto-save procedure.
;; (defun make-auto-save-file-name ()
;;   "Return file name to use for auto-saves of current buffer.."
;;   (if buffer-file-name
;;       (if (file-exists-p "~/.autosaves/")
;;           (concat (expand-file-name "~/.autosaves/") "#"
;;                   (replace-regexp-in-string "/" "!" buffer-file-name)
;;                   "#")
;;          (concat
;;           (file-name-directory buffer-file-name)
;;           "#"
;;           (file-name-nondirectory buffer-file-name)
;;           "#"))
;;     (expand-file-name
;;      (concat "#%" (buffer-name) "#"))))
