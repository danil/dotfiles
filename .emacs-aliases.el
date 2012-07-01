;;; This file is part of Danil Kutkevich <danil@kutkevich.org> home.
;(add-to-list 'load-path "~/share/emacs/site-lisp")

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(safe-local-variable-values (quote ((encoding . utf-8)))))

;;; el-get <http://github.com/dimitri/el-get>.
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(require 'el-get)
(setq el-get-sources
      '((:name deft
               :description "Deft is an Emacs mode for quickly browsing, filtering, and editing directories of plain text notes, inspired by Notational Velocity."
               :after (lambda ()
                        (setq
                         deft-extension "org"
                         deft-text-mode 'org-mode))
               :type http
               :url "http://jblevins.org/projects/deft/deft.el"
               :features deft)
        ;; (:name visws
        ;;        :type emacswik)
        (:name markdown-mode
               :after (lambda ()
                        (add-hook 'markdown-mode-hook
                                  (lambda ()(setq truncate-lines t)))
                        (setq auto-mode-alist
                              (cons '("/README\\'" . markdown-mode)
                                    auto-mode-alist))
                        ;; Mutt temporary files.
                        (setq auto-mode-alist
                              (cons
                               '("/mutt[-a-zA-Z0-9]+\\'" . markdown-mode)
                               auto-mode-alist))))
        (:name less
               :after (lambda ()
                        (add-hook 'find-file-hook
                                  '(lambda ()
                                     (when buffer-read-only
                                       (less-minor-mode-on))))
                        (global-set-key (kbd "ESC ESC ESC")
                                        'less-minor-mode))
               :type git
               :url "git://github.com/emacsmirror/less.git")
        (:name haml-mode
               :description "Major mode for editing Haml files"
               :type git
               :url "git://github.com/nex3/haml-mode.git")
        (:name sass-mode
               :description "Major mode for editing Sass files"
               :type git
               :url "https://github.com/nex3/sass-mode.git"
               ;; :post-init (lambda ()
               ;;              (add-to-list 'auto-mode-alist '("\\.scss$" . sass-mode)))
               :features sass-mode)
        (:name scss-mode
               :type git
               :url "git://github.com/antonj/scss-mode.git"
               :after (lambda ()
                        (setq scss-compile-at-save nil))
               :features (scss-mode))
        (:name lua-mode
               :type git
               :url "git://github.com/immerrr/lua-mode.git"
               :after (lambda ()
                        (add-to-list 'auto-mode-alist
                                     '("\\.ws\\'" . lua-mode))
                        ;; <http://lua-users.org/wiki/LuaStyleGuide>,
                        ;; <http://stackoverflow.com/questions/4643206/how-to-configure-indentation-in-emacs-lua-mode#answer-4652043>
                        (setq lua-indent-level 2)))
        (:name lua2-mode
               :type http
               ;; :after (lambda ()
               ;;          (autoload 'lua2-mode "lua2-mode"
               ;;            "semantic highlighting extension for lua-mode" t))
               :url "http://www.enyo.de/fw/software/lua-emacs/lua2-mode.el")
        (:name rinari
               :description "Rinari Is Not A Rails IDE"
               :type git
               :url "http://github.com/eschulte/rinari.git"
               :load-path ("." "util" "util/jump")
               :compile ("\\.el$" "util")
               ;; :build ("rake doc:install_info")
               ;; :info "doc"
               ;; :after (lambda ()
               ;;          (autoload 'rinari-web-server "rinari"
               ;;            "Run Rails script/server." t))
               :features rinari)
        ;; ;; <http://stackoverflow.com/questions/2713096/emacs-rails-vs-rinari>
        ;; (:name emacs-rails
        ;;        :type git
        ;;        :url "git://github.com/remvee/emacs-rails.git")
        (:name jump
               :type git
               :url "git://github.com/emacsmirror/jump.git")
        (:name findr
               :type git
               :url "git://github.com/emacsmirror/findr.git")
        (:name window-numbering
               :type git
               :url "git://github.com/nschum/window-numbering.el.git"
               :after (lambda ()
                        (autoload 'window-numbering-mode
                          "window-numbering"
                          "Numbered window shortcuts" t)
                        (window-numbering-mode 1)))
        ;; ;; <http://www.nongnu.org/color-theme>.
        ;; (:name color-theme)
        ;; (:name color-theme-zenburn
        ;;        :features zenburn
        ;;        :after (lambda ()
        ;;                 (color-theme-zenburn)))
        (:name bongo
               :type git
               :url "git://github.com/dbrock/bongo.git"
               :after (lambda ()
                        (autoload 'bongo "bongo"
                          "Buffer-oriented media player for GNU Emacs." t)))
        ;; (:name highlight-indentation
        ;;        :type git
        ;;        :url "https://github.com/antonj/Highlight-Indentation-for-Emacs"
        ;;        :after (lambda ()
        ;;                 (autoload 'highlight-indentation "highlight-indentation"
        ;;                   "Visual guidelines for indentation (using spaces)" t)))
        (:name rhtml-mode
               :description "Major mode for editing RHTML files"
               :type git
               :url "https://github.com/eschulte/rhtml.git"
               :post-init (lambda ()
                            (autoload 'rhtml-mode "rhtml-mode" nil t)
                            (add-to-list 'auto-mode-alist '("\\.html\.erb$" . rhtml-mode))
                            (add-to-list 'auto-mode-alist '("\\.erb$" . rhtml-mode))))
        (:name rainbow-mode
               :description "Colorize color names in buffers"
               :type git
               :url "git://github.com/emacsmirror/rainbow-mode.git"
               :features rainbow-mode
               :after (lambda ()
                        (add-hook 'css-mode-hook (lambda () (rainbow-mode 1)))
                        (add-hook 'sass-mode-hook (lambda () (rainbow-mode 1)))))
        (:name auto-complete
               :after (lambda ()
                        (add-to-list 'ac-modes 'coffee-mode)
                        (add-to-list 'ac-modes 'conf-mode)
                        (add-to-list 'ac-modes 'conf-space-mode)
                        (add-to-list 'ac-modes 'haml-mode)
                        (add-to-list 'ac-modes 'html-mode)
                        (add-to-list 'ac-modes 'lua-mode)
                        (add-to-list 'ac-modes 'markdown-mode)
                        (add-to-list 'ac-modes 'org-mode)
                        (add-to-list 'ac-modes 'sass-mode)
                        (add-to-list 'ac-modes 'sgml-mode)
                        (add-to-list 'ac-modes 'yaml-mode)
                        (setq ac-disable-faces (quote (font-lock-doc-face)))))
        (:name column-marker
               :type git
               :url "git://github.com/emacsmirror/column-marker.git"
               :after (lambda ()
                        (defun my-column-marker ()
                          (unless buffer-read-only (column-marker-1 79)))
                        ;;(add-hook 'mail-mode-hook (lambda () (interactive) (my-column-marker)))
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
                        (add-hook 'whitespace-mode-hook (lambda () (interactive) (column-marker-1 80)))
                        (add-hook 'xml-mode-hook (lambda () (interactive) (my-column-marker)))
                        (add-hook 'yaml-mode-hook (lambda () (interactive) (my-column-marker)))))
        (:name org-mode
               :after (lambda ()
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
        (:name yasnippet
               :website "https://github.com/capitaomorte/yasnippet.git"
               :description "YASnippet is a template system for Emacs."
               :type git
               :url "https://github.com/capitaomorte/yasnippet.git"
               :features "yasnippet"
               :prepare (lambda ()
                          ;; Set up the default snippets directory
                          ;;
                          ;; Principle: don't override any user settings
                          ;; for yas/snippet-dirs, whether those were made
                          ;; with setq or customize.  If the user doesn't
                          ;; want the default snippets, she shouldn't get
                          ;; them!
                          (unless (or (boundp 'yas/snippet-dirs) (get 'yas/snippet-dirs 'customized-value))
                            (setq yas/snippet-dirs
                                  (list (concat el-get-dir (file-name-as-directory "yasnippet") "snippets")))))

               :post-init (lambda ()
                            ;; Trick customize into believing the standard
                            ;; value includes the default snippets.
                            ;; yasnippet would probably do this itself,
                            ;; except that it doesn't include an
                            ;; installation procedure that sets up the
                            ;; snippets directory, and thus doesn't know
                            ;; where those snippets will be installed.  See
                            ;; http://code.google.com/p/yasnippet/issues/detail?id=179
                            (put 'yas/snippet-dirs 'standard-value
                                 ;; as cus-edit.el specifies, "a cons-cell
                                 ;; whose car evaluates to the standard
                                 ;; value"
                                 (list (list 'quote
                                             (list (concat el-get-dir (file-name-as-directory "yasnippet") "snippets"))))))
               ;; byte-compile load vc-svn and that fails
               ;; see https://github.com/dimitri/el-get/issues/200
               :compile nil
               ;; :after (lambda () (yas/initialize))
               :submodule nil)
        ))

(setq my-packages
      (append
       '(
         auto-complete
         bongo
         coffee-mode
         column-marker
         deft
         findr
         haml-mode
         haskell-mode
         inf-ruby
         jump
         less
         lua-mode
         magit
         markdown-mode
         org-mode
         paredit
         php-mode
         rainbow-mode
         rhtml-mode
         rinari
         ruby-mode
         sass-mode
         scss-mode
         window-numbering
         yaml-mode
         yasnippet
         )
       (mapcar 'el-get-source-name el-get-sources)))

(el-get 'sync my-packages)

(setq system-time-locale "C")
(setq calendar-week-start-day 1)
(global-font-lock-mode 1)

;;; Transient Mark mode <http://emacswiki.org/TransientMarkMode>.
(transient-mark-mode 1)
;; (set-face-background 'region nil)
;; (set-face-attribute 'region nil :inverse-video t)

(set-cursor-color "#aa0000")

;;; Truncation of Lines <http://emacswiki.org/emacs/TruncateLines>.
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
;;; Interactively do things.
(ido-mode t)
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
(set-face-attribute hl-line-face nil :underline t)
;;; <http://emacsblog.org/2007/04/09/highlight-the-current-line/#comment-284>.
(defun local-hl-line-mode-off ()
  (interactive)
  (make-local-variable 'global-hl-line-mode)
  (setq global-hl-line-mode nil))
(add-hook 'ediff-mode-hook 'local-hl-line-mode-off)
(add-hook 'term-mode-hook 'local-hl-line-mode-off)

;;; Column number mode
;;; <http://gnu.org/software/emacs/manual/html_node/emacs/Optional-Mode-Line.html>.
;(setq line-number-mode t)
(setq column-number-mode 1)

;;; IswitchB <http://emacswiki.org/IswitchBuffers>.
(iswitchb-mode 1)
;; (setq iswitchb-buffer-ignore '("^ " "*scratch*" "*Messages*"
;;                                "*Completions*" "*Ibuffer*"))
;(setq iswitchb-default-method 'samewindow)

;;; Ibuffer <http://emacswiki.org/IbufferMode>.
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)
;(setq ibuffer-use-other-window 1)

;;; Server <http://shreevatsa.wordpress.com/tag/emacs/>.
;; (remove-hook 'kill-buffer-query-functions
;;              'server-kill-buffer-query-function)

;;; Uniquify
;;; <http://gnu.org/software/emacs/manual/html_node/emacs/Uniquify.html>.
(require 'uniquify)
;; nil, forward, reverse, post-forward or post-forward-angle-brackets
(setq uniquify-buffer-name-style 'forward)
;(setq uniquify-separator "/")
;; Rename after killing uniquified.
;(setq uniquify-after-kill-buffer-p t)
;; Don't muck with special buffers.
;(setq uniquify-ignore-buffers-re "^\\*")

;;; Browse Url with Epiphany.
;(setq browse-url-browser-function 'browse-url-epiphany)

(setq browse-url-browser-function 'browse-url-generic
  browse-url-generic-program "epiphany"
  browse-url-generic-args '("--new-tab"))

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

;;; JavaScript mode.
;;; HTML Components (HTCs or .htc)
;;; <http://en.wikipedia.org/wiki/HTML_Components>.
(add-to-list 'auto-mode-alist '("\\.htc$" . js-mode))
(setq js-indent-level 2)

;;; CSS mode
;;; <http://emacswiki.org/emacs/css-mode.el>.
(setq css-indent-offset 2)

;;; nginx confs.
(setq auto-mode-alist
      (cons '("/etc/nginx/.*\\.conf\\'" . perl-mode) auto-mode-alist))

;;; Auto Fill Mode
;;; <http://gnu.org/software/emacs/manual/html_node/emacs/Auto-Fill.html>.
;(add-hook 'mail-mode-hook (lambda () (auto-fill-mode t)))

;; ;;; View mode.
;; (setq view-read-only t)
;; ;; (add-hook 'view-mode-hook (lambda () (less-minor-mode t)))
;; (defun my-view-mode () (view-mode t))
;; ;;(add-hook 'mail-mode-hook (lambda () (interactive) (my-view-mode)))
;; (add-hook 'awk-mode-hook (lambda () (interactive) (my-view-mode)))
;; (add-hook 'change-log-mode-hook (lambda () (interactive) (my-view-mode)))
;; (add-hook 'coffee-mode-hook (lambda () (interactive) (my-view-mode)))
;; (add-hook 'conf-mode-hook (lambda () (interactive) (my-view-mode)))
;; (add-hook 'css-mode-hook (lambda () (interactive) (my-view-mode)))
;; (add-hook 'emacs-lisp-mode-hook (lambda () (interactive) (my-view-mode)))
;; (add-hook 'haml-mode-hook (lambda () (interactive) (my-view-mode)))
;; (add-hook 'haskell-mode-hook (lambda () (interactive) (my-view-mode)))
;; (add-hook 'html-mode-hook (lambda () (interactive) (my-view-mode)))
;; (add-hook 'java-mode-hook (lambda () (interactive) (my-view-mode)))
;; (add-hook 'js-mode-hook (lambda () (interactive) (my-view-mode)))
;; (add-hook 'lisp-mode-hook (lambda () (interactive) (my-view-mode)))
;; (add-hook 'lua-mode-hook (lambda () (interactive) (my-view-mode)))
;; (add-hook 'makefile-gmake-mode-hook (lambda () (interactive) (my-view-mode)))
;; (add-hook 'markdown-mode-hook (lambda () (interactive) (my-view-mode)))
;; (add-hook 'nxml-mode-hook (lambda () (interactive) (my-view-mode)))
;; (add-hook 'org-mode-hook (lambda () (interactive) (my-view-mode)))
;; (add-hook 'perl-mode-hook (lambda () (interactive) (my-view-mode)))
;; (add-hook 'php-mode-hook (lambda () (interactive) (my-view-mode)))
;; (add-hook 'ruby-mode-hook (lambda () (interactive) (my-view-mode)))
;; (add-hook 'sass-mode-hook (lambda () (interactive) (my-view-mode)))
;; (add-hook 'sgml-mode-hook (lambda () (interactive) (my-view-mode)))
;; (add-hook 'sh-mode-hook (lambda () (interactive) (my-view-mode)))
;; (add-hook 'sql-mode-hook (lambda () (interactive) (my-view-mode)))
;; (add-hook 'whitespace-mode-hook (lambda () (interactive) (column-marker-1 80)))
;; (add-hook 'xml-mode-hook (lambda () (interactive) (my-view-mode)))
;; (add-hook 'yaml-mode-hook (lambda () (interactive) (my-view-mode)))

;;; Whitespace mode.
(defun my-whitespace-mode ()
  (setq whitespace-style '(face space-after-tab space-before-tab trailing))
  (unless buffer-read-only (whitespace-mode t)))
;;(add-hook 'mail-mode-hook (lambda () (interactive) (my-whitespace-mode)))
(add-hook 'awk-mode-hook (lambda () (interactive) (my-whitespace-mode)))
(add-hook 'change-log-mode-hook (lambda () (interactive) (my-whitespace-mode)))
(add-hook 'coffee-mode-hook (lambda () (interactive) (my-whitespace-mode)))
(add-hook 'conf-mode-hook (lambda () (interactive) (my-whitespace-mode)))
(add-hook 'css-mode-hook (lambda () (interactive) (my-whitespace-mode)))
(add-hook 'emacs-lisp-mode-hook (lambda () (interactive) (my-whitespace-mode)))
(add-hook 'haml-mode-hook (lambda () (interactive) (my-whitespace-mode)))
(add-hook 'haskell-mode-hook (lambda () (interactive) (my-whitespace-mode)))
(add-hook 'html-mode-hook (lambda () (interactive) (my-whitespace-mode)))
(add-hook 'java-mode-hook (lambda () (interactive) (my-whitespace-mode)))
(add-hook 'js-mode-hook (lambda () (interactive) (my-whitespace-mode)))
(add-hook 'lisp-mode-hook (lambda () (interactive) (my-whitespace-mode)))
(add-hook 'lua-mode-hook (lambda () (interactive) (my-whitespace-mode)))
(add-hook 'makefile-gmake-mode-hook (lambda () (interactive) (my-whitespace-mode)))
(add-hook 'markdown-mode-hook (lambda () (interactive) (my-whitespace-mode)))
(add-hook 'nxml-mode-hook (lambda () (interactive) (my-whitespace-mode)))
(add-hook 'org-mode-hook (lambda () (interactive) (my-whitespace-mode)))
(add-hook 'perl-mode-hook (lambda () (interactive) (my-whitespace-mode)))
(add-hook 'php-mode-hook (lambda () (interactive) (my-whitespace-mode)))
(add-hook 'ruby-mode-hook (lambda () (interactive) (my-whitespace-mode)))
(add-hook 'sass-mode-hook (lambda () (interactive) (my-whitespace-mode)))
(add-hook 'sgml-mode-hook (lambda () (interactive) (my-whitespace-mode)))
(add-hook 'sh-mode-hook (lambda () (interactive) (my-whitespace-mode)))
(add-hook 'sql-mode-hook (lambda () (interactive) (my-whitespace-mode)))
(add-hook 'whitespace-mode-hook (lambda () (interactive) (column-marker-1 80)))
(add-hook 'xml-mode-hook (lambda () (interactive) (my-whitespace-mode)))
(add-hook 'yaml-mode-hook (lambda () (interactive) (my-whitespace-mode)))
;; (add-hook 'markdown-mode-hook
;;           (lambda () (if (string-match "/bookmarks\\.md\\'"
;;                                        (buffer-file-name))
;;                          (setq whitespace-style
;;                                '(trailing space-before-tab
;;                                           space-after-tab empty))
;;                        (my-whitespace-mode))))

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
