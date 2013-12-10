;;; This file is part of Danil Kutkevich <danil@kutkevich.org> home.
;(add-to-list 'load-path "~/share/emacs/site-lisp")

;;; My recipes.
(mapc 'load (directory-files
             (concat user-emacs-directory "my-recipes") t "^[^#].*el$"))

;;; My custom variables.
(setq custom-file "~/.emacs.d/my-custom-variables.el")
(load custom-file)

;;; Put <http://www.gnu.org/software/emacs/manual/html_node/elisp/Symbol-Plists.html>.
;; Horizontal Scrolling
;; <http://gnu.org/software/emacs/manual/html_node/emacs/Horizontal-Scrolling.html#Horizontal-Scrolling>.
(put 'scroll-left 'disabled nil)
(put 'upcase-region 'disabled nil)

;;; el-get <http://github.com/dimitri/el-get>.
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
;; (require 'el-get)
(unless (require 'el-get nil t)
  (url-retrieve
   "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
   (lambda (s)
     (let ;(el-get-master-branch)
       (goto-char (point-max))
       (eval-print-last-sexp)))))
;; (setq el-get-sources
;;       '(
;;         ))
(add-to-list 'el-get-recipe-path "~/.emacs.d/my-el-get/recipes")
(setq my-packages
      (append
       '(
         ;; auto-complete-ruby ;buggy(
         ;; bongo
         ;; color-theme-ir-black
         ;; color-theme-vivid-chalk
         ;; command-t
         ;; fiplr
         ;; helm
         ;; ido-better-flex
         ;; ido-ubiquitous
         ;; jump
         ;; package
         ;; smartparens
         ;; vline
         ag
         apache-mode
         auto-complete-chunk
         auto-complete-css
         auto-complete-emacs-lisp
         auto-complete-etags
         bash-completion
         coffee-mode
         column-marker
         crontab-mode
         csv-mode
         dart-mode
         deft
         ebuild-mode
         egg
         erise
         etags-select
         ethan-wspace
         evil
         expand-region
         findr
         flycheck
         git-gutter
         go-mode
         haml-mode
         haskell-mode
         highlight-parentheses
         highlight-symbol ;try replace with idle highlight mode, due to curren symbol highlighting face
         hl-line+
         idle-highlight-mode
         ido-yes-or-no
         inf-ruby
         less ;do not remove, used for generic scroll!
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
         ruby-end
         ruby-hash-syntax
         ruby-pry
         ruby-refactor
         ruby-tools
         rvm
         sass-mode
         scss-mode
         simp
         slim-mode
         slime
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

;;; Setting key with repeat
;;; <http://stackoverflow.com/questions/7560094/two-key-shortcut-in-emacs-without-repressing-the-first-key#7560416>.
(defmacro my-with-repeat-while-press-last-key (&rest body)
  "Execute BODY and repeat while the user presses the last key."
  (declare (indent 0))
  `(let* ((repeat-key (and (> (length (this-single-command-keys)) 1)
                           last-input-event))
          (repeat-key-str (format-kbd-macro (vector repeat-key) nil)))
     ,@body
     (while repeat-key
       (message "Type %s to repeat again" repeat-key-str)
       (let ((event (read-event)))
         (clear-this-command-keys t)
         (if (equal event repeat-key)
             (progn ,@body
                    (setq last-input-event nil))
           (setq repeat-key nil)
           (push last-input-event unread-command-events))))))

(global-set-key (kbd "C-c d s l") 'sort-lines)
(global-set-key (kbd "C-c d s f") 'sort-fields)

;;; BackspaceKey <http://emacswiki.org/BackspaceKey>.
;; (global-set-key [(control h)] 'delete-backward-char)
(defun my-backspace-fix ()
  (keyboard-translate ?\C-h ?\C-?)
  (define-key key-translation-map [?\C-h] [?\C-?]))
(my-backspace-fix)
(eval-after-load 'term-mode '(progn (my-backspace-fix)))

;;; Transient Mark mode <http://emacswiki.org/TransientMarkMode>.
(transient-mark-mode 1)

;;; Truncation of Lines (toggle-truncate-lines) <http://emacswiki.org/emacs/TruncateLines>.
(set-default 'truncate-lines t)
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
;; (eval-after-load 'show-paren
;;   '(progn
;;      (cond ((equal frame-background-mode 'dark)
;;             (set-face-background 'show-paren-match "#002b36")
;;             ))
;;      ))

;;; Session Management <http://emacswiki.org/SessionManagement>.
(savehist-mode 1)
;;; Desktop <http://emacswiki.org/DeskTop>.
;;(desktop-save-mode 1)
;; <http://stackoverflow.com/questions/4477376/some-emacs-desktop-save-questions-how-to-change-it-to-save-in-emacs-d-emacs#answer-4485083>.
(defun save-my-desktop ()
  "Save the desktop"
  (interactive)
  (desktop-save-in-desktop-dir))
(defun load-my-desktop ()
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

;;; Environment variables.
(setenv "DISABLE_PRY_RAILS" "1")
(setenv "GIT_PAGER" "")
(setenv "RAILS_TRUSTED_IP" "192.168.0.18") ;<https://github.com/charliesome/better_errors#security>.
;; (setenv "ESHELL" (expand-file-name "/bin/zsh")) ;terminal <http://stackoverflow.com/questions/1568987/getting-emacs-to-respect-my-default-shell-options#1570246>

;; ;;; <http://emacswiki.org/ScrollBar>.
;; (scroll-bar-mode -1)
;; <http://stackoverflow.com/questions/3155451/emacs-scrollbar-customize#3159618>.
(cond ((equal frame-background-mode 'dark)
       (set-face-background 'scroll-bar "white")
       (set-face-foreground 'scroll-bar "gray")
       ))

;;; AnsiColor (Emacs terminal related stuff)
;;; <http://emacswiki.org/AnsiColor>.
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
;; (add-hook 'shell-mode-hook 'compilation-shell-minor-mode) ;filenames with line numbers linkable

;;; Comint mode (which shell mode and sql mode based on)
;;; <http://www.emacswiki.org/emacs/ComintMode#toc3>.
(setq comint-input-ring-size 10000)
;; (add-hook 'sql-interactive-mode-hook
;;           (function (lambda () (setq comint-input-ring-size 10000))))

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

;;; Dired.
;;; Reuse directory buffer
;;; <http://www.emacswiki.org/emacs/DiredReuseDirectoryBuffer>.
(put 'dired-find-alternate-file 'disabled nil)
(add-hook 'dired-mode-hook
          (lambda ()
            (define-key dired-mode-map (kbd "^")
              (lambda () (interactive) (find-alternate-file "..")))
                                        ; was dired-up-directory
            ))

;;; Get rid of annoying backups, temporary files and autosaves.
;; Built-in backup settings
;; <http://www.emacswiki.org/emacs/BackupDirectory#toc2>.
(setq
 backup-by-copying t           ;don't clobber symlinks
 backup-directory-alist
 '(("." . "~/.emacs-backups")) ;don't litter my fs tree
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)            ;use versioned backups
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

;;; Cua mode <http://www.emacswiki.org/emacs/CuaMode>.
(setq cua-enable-cua-keys nil) ;change case of a rectangle <http://stackoverflow.com/questions/6154545/emacs-change-case-of-a-rectangle#comment-7167904>.

;;; Line numbers
;;; Linum
(eval-after-load 'linum
  '(progn
     ;; (setq linum-format "%4d ") ;separating line numbers from text <http://www.emacswiki.org/emacs/LineNumbers#toc7>
     (cond ((equal frame-background-mode 'light)
            (set-face-attribute 'linum nil
                                :foreground "DimGray"
                                :background "gray85")
            )
           ((equal frame-background-mode 'dark)
            (set-face-attribute 'linum nil
                                :foreground "DimGray"
                                :background "gray15")
            ))
     ))
(defun my-linum-mode-hook ()
  (linum-mode 1))
(add-hook 'awk-mode-hook 'my-linum-mode-hook)
(add-hook 'c-mode-hook 'my-linum-mode-hook)
(add-hook 'coffee-mode-hook 'my-linum-mode-hook)
(add-hook 'conf-mode-hook 'my-linum-mode-hook)
(add-hook 'css-mode-hook 'my-linum-mode-hook)
(add-hook 'emacs-lisp-mode-hook 'my-linum-mode-hook)
(add-hook 'haml-mode-hook 'my-linum-mode-hook)
(add-hook 'haskell-mode-hook 'my-linum-mode-hook)
(add-hook 'html-mode-hook 'my-linum-mode-hook)
(add-hook 'java-mode-hook 'my-linum-mode-hook)
(add-hook 'js-mode-hook 'my-linum-mode-hook)
(add-hook 'lisp-mode-hook 'my-linum-mode-hook)
(add-hook 'lua-mode-hook 'my-linum-mode-hook)
(add-hook 'makefile-gmake-mode-hook 'my-linum-mode-hook)
(add-hook 'markdown-mode-hook 'my-linum-mode-hook)
(add-hook 'nxml-mode-hook 'my-linum-mode-hook)
(add-hook 'org-mode-hook 'my-linum-mode-hook)
(add-hook 'perl-mode-hook 'my-linum-mode-hook)
(add-hook 'php-mode-hook 'my-linum-mode-hook)
(add-hook 'python-mode-hook 'my-linum-mode-hook)
(add-hook 'ruby-mode-hook 'my-linum-mode-hook)
(add-hook 'sass-mode-hook 'my-linum-mode-hook)
(add-hook 'sgml-mode-hook 'my-linum-mode-hook)
(add-hook 'sh-mode-hook 'my-linum-mode-hook)
(add-hook 'sql-mode-hook 'my-linum-mode-hook)
(add-hook 'xml-mode-hook 'my-linum-mode-hook)
(add-hook 'yaml-mode-hook 'my-linum-mode-hook)
;; (add-hook 'compilation-mode-hook 'my-linum-mode-hook)
;; (add-hook 'shell-mode-hook 'my-linum-mode-hook)

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
      (cons '("/hosts\\'" . conf-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("\\.pkla\\'" . conf-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("\\.cnf\\'" . conf-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("\\.theme\\'" . conf-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("/.gtkrc-2.0\\'" . conf-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("/\\.tigrc\\'" . conf-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("/locale.gen\\'" . conf-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("/sudoers\\'" . conf-mode) auto-mode-alist))

;;; Lisp.
(setq auto-mode-alist
      (cons '("/\\.stumpwmrc\\'" . lisp-mode) auto-mode-alist))

;;; Cucumber features.
(setq auto-mode-alist
      (cons '("\\.features\\'" . conf-mode) auto-mode-alist))

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
(add-to-list 'auto-mode-alist '("var/lib/portage/world\\'" . conf-mode))

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
(setq auto-mode-alist
      (cons '("\\.atex\\'" . ruby-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("\\.gemspec\\'" . ruby-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("\\.irbrc\\'" . ruby-mode) auto-mode-alist))

;; Ruby indentation fix
;; <https://github.com/mlapshin/dotfiles/blob/2531616385b9fd3bef4b6418a5f024fd2f010461/.emacs.d/custom/ruby.el#L49>.
(eval-after-load 'ruby-mode
  '(progn
     (defadvice ruby-indent-line (after line-up-args activate)
       (let (indent prev-indent arg-indent)
         (save-excursion
           (back-to-indentation)
           (when (zerop (car (syntax-ppss)))
             (setq indent (current-column))
             (skip-chars-backward " \t\n")
             (when (eq ?, (char-before))
               (ruby-backward-sexp)
               (back-to-indentation)
               (setq prev-indent (current-column))
               (skip-syntax-forward "w_.")
               (skip-chars-forward " ")
               (setq arg-indent (current-column)))))
         (when prev-indent
           (let ((offset (- (current-column) indent)))
             (cond ((< indent prev-indent)
                    (indent-line-to prev-indent))
                   ((= indent prev-indent)
                    (indent-line-to arg-indent)))
             (when (> offset 0) (forward-char offset))))))))

;;; Haml.
(eval-after-load 'haml-mode
  '(progn
     (define-key haml-mode-map (kbd "C-c d r h")
       'ruby-toggle-hash-syntax)
     ))

;;; JavaScript mode.
;;; HTML Components (HTCs or .htc)
;;; <http://en.wikipedia.org/wiki/HTML_Components>.
(add-to-list 'auto-mode-alist '("\\.htc$" . js-mode))
(setq js-indent-level 2)

;;; CSS mode
;;; <http://emacswiki.org/emacs/css-mode.el>.
(setq css-indent-offset 2)

;;; Hide Show minor mode <http://www.emacswiki.org/emacs/HideShow>.
(add-hook 'ruby-mode-hook 'hs-minor-mode)
;; (eval-after-load 'hs-minor-mode
;;   '(progn (define-key hs-minor-mode-map (kbd \"TAB\") 'hs-toggle-hiding)))

;;; Folding Ruby code (hide show minor mode).
(add-to-list 'hs-special-modes-alist
                  '(ruby-mode
                           "\\(def\\|do\\|{\\)" "\\(end\\|end\\|}\\)" "#"
                                  (lambda (arg) (ruby-end-of-block)) nil))

;;; Prompts and run command with file (associated to current buffer)
;;; path as argument
;;; <http://superuser.com/questions/360427/emacs-equivalent-of-this-vim-command-to-run-my-tests#360512>.
(defun my-do-shell-command-on-buffer-file ()
  "Prompts for a command and executes that command on to the associated
 file of current buffer. If no buffer is associated gives an error"
  (interactive)
  (or (buffer-file-name) (error "no file is associated file to this buffer"))
  (let* ((my-cmd (read-shell-command "Command to run: "))
         (cmd-to-run (concat my-cmd " " (buffer-file-name))))
    (shell-command cmd-to-run)))
(defun my-do-shell-command-on-current-path ()
  "Prompts for a command and executes that command"
  (interactive)
  (let* ((my-cmd (read-shell-command "Command to run: "))
         (cmd-to-run (concat my-cmd)))
    (shell-command cmd-to-run)))

;;; ANSI SGR (Select Graphic Rendition) escape sequences
;;; <http://www.emacswiki.org/emacs/AnsiColor>
(require 'ansi-color)
(defun my-show-ansi-color ()
  "Process ANSI color codes in region."
  (interactive)
  (ansi-color-apply-on-region (region-beginning) (region-end)))
;;; ANSI SRG in shell command output
;:; <http://stackoverflow.com/questions/5819719/emacs-shell-command-output-not-showing-ansi-colors-but-the-code#5821668
(defadvice display-message-or-buffer (before ansi-color activate)
  "Process ANSI color codes in shell output."
  (let ((buf (ad-get-arg 0)))
    (and (bufferp buf)
         (string= (buffer-name buf) "*Shell Command Output*")
         (with-current-buffer buf
           (ansi-color-apply-on-region (point-min) (point-max))))))

;;; Move point to beginning of line or "back to indentation"
;;; <http://stackoverflow.com/questions/6035872/moving-to-the-start-of-a-code-line-emacs#7250027>.
(defun my-beginning-of-line ()
  "Move point to the beginning of the line; if that is already
the current position of point, then move it to the beginning of text on the current line."
  (interactive)
  (let ((pt (point)))
    (beginning-of-line)
    (when (eq pt (point))
      (beginning-of-line-text))))
(global-set-key (kbd "C-a") 'my-beginning-of-line)
;; (eval-after-load "cc-mode"
;;      '(define-key c-mode-base-map (kbd "C-a") 'my-beginning-of-line))

;;; CamleCase and underscore inflection toggle
;;; <http://superuser.com/questions/126431/is-there-any-way-to-convert-camel-cased-names-to-use-underscores-in-emacs/126473#300048>,
;;; <https://bunkus.org/blog/2009/12/switching-identifier-naming-style-between-camel-case-and-c-style-in-emacs>,
;;; <http://api.rubyonrails.org/classes/ActiveSupport/Inflector.html>.
(global-set-key (kbd "C-c d i c") 'my-toggle-camelcase-and-underscore-with-repeat)
(defun my-toggle-camelcase-and-underscore-with-repeat ()
  (interactive)
  (my-with-repeat-while-press-last-key
    (my-toggle-camelcase-and-underscore)))
(defun my-toggle-camelcase-and-underscore ()
  "Toggles the symbol at point between C-style naming,
e.g. `hello_world_string', and camel case,
e.g. `HelloWorldString'."
  (interactive)
  (let* ((symbol-pos (bounds-of-thing-at-point 'symbol))
         case-fold-search symbol-at-point cstyle regexp func)
    (unless symbol-pos
      (error "No symbol at point"))
    (save-excursion
      (narrow-to-region (car symbol-pos) (cdr symbol-pos))
      (setq cstyle (string-match-p "_" (buffer-string))
            regexp (if cstyle "\\(?:\\_<\\|_\\)\\(\\w\\)" "\\([A-Z]\\)")
            func (if cstyle
                     'capitalize
                   (lambda (s)
                     (concat (if (= (match-beginning 1)
                                    (car symbol-pos))
                                 ""
                               "_")
                             (downcase s)))))
      (goto-char (point-min))
      (while (re-search-forward regexp nil t)
        (replace-match (funcall func (match-string 1))
                       t nil))
      (widen))))

(global-set-key (kbd "C-c d i h") 'my-humanize-symbol-with-repeat)
(defun my-humanize-symbol-with-repeat ()
  (interactive)
  (my-with-repeat-while-press-last-key
    (my-humanize-symbol)))
(defun my-humanize-symbol ()
  "Humanize the symbol at point from
C-style naming, e.g. `hello_world_string',
and camel case, e.g. `HelloWorldString',
and Lisp-style nameing, e.g. `hello-world-string'."
  (interactive)
  (let* ((symbol-pos (bounds-of-thing-at-point 'symbol))
         case-fold-search symbol-at-point cstyle regexp func)
    (unless symbol-pos
      (error "No symbol at point"))
    (save-excursion
      (narrow-to-region (car symbol-pos) (cdr symbol-pos))
      (setq cstyle (string-match-p "_" (buffer-string))
            lisp-style (string-match-p "-" (buffer-string))
            regexp (cond (cstyle "\\(?:\\_<\\|_\\)\\(\\w\\)")
                         (lisp-style "\\(?:\\-<\\|-\\)\\(\\w\\)")
                         (t "\\([A-Z]\\)"))
            func (lambda (s)
                     (concat (if (= (match-beginning 1)
                                    (car symbol-pos))
                                 ""
                               " ")
                             (downcase s))))
      (goto-char (point-min))
      (while (re-search-forward regexp nil t)
        (replace-match (funcall func (match-string 1))
                       t nil))
      (widen))))

;;; Duplicate lines <http://www.emacswiki.org/emacs/DuplicateLines#toc2>.
(global-set-key (kbd "C-c d d l") 'uniquify-all-lines-region)
(defun uniquify-all-lines-region (start end)
  "Find duplicate lines in region START to END keeping first occurrence."
  (interactive "*r")
  (save-excursion
    (let ((end (copy-marker end)))
      (while
          (progn
            (goto-char start)
            (re-search-forward "^\\(.*\\)\n\\(\\(.*\n\\)*\\)\\1\n" end t))
        (replace-match "\\1\n\\2")))))
(defun uniquify-all-lines-buffer ()
  "Delete duplicate lines in buffer and keep first occurrence."
  (interactive "*")
  (uniquify-all-lines-region (point-min) (point-max)))

;;; Sql mode history <http://www.emacswiki.org/emacs/SqlMode#toc3>.
(defun my-sql-save-history-hook ()
  (let ((lval 'sql-input-ring-file-name)
        (rval 'sql-product))
    (if (symbol-value rval)
        (let ((filename
               (concat "~/.emacs.d/sql/"
                       (symbol-name (symbol-value rval))
                       "-history.sql")))
          (set (make-local-variable lval) filename))
      (error
       (format "SQL history will not be saved because %s is nil"
               (symbol-name rval))))))
(add-hook 'sql-interactive-mode-hook 'my-sql-save-history-hook)

;;; Mew is a mail reader for Emacs <http://mew.org>, <http://emacswiki.org/Mew>.
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
(fset 'my-kbd-macro-ruby-string-to-symbol
   "\C-[\C-s\\(\"\\|'\\)\C-s\C-m\C-?\C-[\C-r\\(\"\\|'\\)\C-m\C-d:")
;; (fset 'my-kbd-macro-ruby-new-hash-syntax
;;    "\C-s =>\C-m\C-r:\C-m\C-d\C-s =>\C-m\C-?\C-?\C-?:")

(eval-after-load 'ruby-mode
  '(progn
     (define-key ruby-mode-map (kbd "C-c d r b") 'my-ruby-toggle-block)
     (define-key ruby-mode-map (kbd "C-c d r h") 'ruby-toggle-hash-syntax)
     ))
(defun my-ruby-brace-to-do-end (orig end)
  (let (beg-marker end-marker)
    (goto-char end)
    (when (eq (char-before) ?\})
      (delete-char -1)
      (when (save-excursion
              (skip-chars-backward " \t")
              (not (bolp)))
        (insert "\n"))
      (insert "end")
      (setq end-marker (point-marker))
      (when (and (not (eobp)) (eq (char-syntax (char-after)) ?w))
        (insert " "))
      (goto-char orig)
      (delete-char 1)
      (when (eq (char-syntax (char-before)) ?w)
        (insert " "))
      (insert "do")
      (setq beg-marker (point-marker))
      (when (looking-at "\\(\\s \\)*|")
        (unless (match-beginning 1)
          (insert " "))
        (goto-char (1+ (match-end 0)))
        (search-forward "|"))
      (unless (looking-at "\\s *$")
        (insert "\n"))
      (indent-region beg-marker end-marker)
      (goto-char beg-marker)
      t)))
(defun my-ruby-do-end-to-brace (orig end)
  (let (beg-marker end-marker beg-pos end-pos)
    (goto-char (- end 3))
    (when (looking-at ruby-block-end-re)
      (delete-char 3)
      (setq end-marker (point-marker))
      (insert "}")
      (goto-char orig)
      (delete-char 2)
      (insert "{")
      (setq beg-marker (point-marker))
      (when (looking-at "\\s +|")
        (unless (match-beginning 1)
          (insert " "))
        (delete-char (- (match-end 0) (match-beginning 0) 1))
        (forward-char)
        (re-search-forward "|" (line-end-position) t))
      (save-excursion
        (skip-chars-forward " \t\n\r")
        (setq beg-pos (point))
        (goto-char end-marker)
        (skip-chars-backward " \t\n\r")
        (setq end-pos (point)))
      (when (or
             (< end-pos beg-pos)
             (and (= (line-number-at-pos beg-pos) (line-number-at-pos end-pos))
                  (< (+ (current-column) (- end-pos beg-pos) 2) fill-column)))
        (just-one-space -1)
        (goto-char end-marker)
        (just-one-space -1))
      (goto-char beg-marker)
      t)))
(defun my-ruby-toggle-block ()
  "Toggle block type from do-end to braces or back.
The block must begin on the current line or above it and end after the point.
If the result is do-end block, it will always be multiline."
  (interactive)
  (my-with-repeat-while-press-last-key
  (let ((start (point)) beg end)
    (end-of-line)
    (unless
        (if (and (re-search-backward "\\({\\)\\|\\_<do\\(\\s \\|$\\||\\)")
                 (progn
                   (setq beg (point))
                   (save-match-data (ruby-forward-sexp))
                   (setq end (point))
                   (> end start)))
            (if (match-beginning 1)
                (my-ruby-brace-to-do-end beg end)
              (my-ruby-do-end-to-brace beg end)))
      (goto-char start)))))

;; ;;; Inf ruby mode (irb) history <http://www.emacswiki.org/emacs/SqlMode#toc3>.
;; (defun my-irb-save-history-hook ()
;;   (let ((lval 'sql-input-ring-file-name)
;;         (rval 'sql-product))
;;     (if (symbol-value rval)
;;         (let ((filename
;;                (concat "~/.emacs.d/irb/"
;;                        (symbol-name (symbol-value rval))
;;                        "-history.sql")))
;;           (set (make-local-variable lval) filename))
;;       (error
;;        (format "IRB history will not be saved because %s is nil"
;;                (symbol-name rval))))))
;; (add-hook 'inf-ruby-mode-hook 'my-irb-save-history-hook)

;;; Auto Fill Mode
;;; <http://gnu.org/software/emacs/manual/html_node/emacs/Auto-Fill.html>.
;(add-hook 'mail-mode-hook (lambda () (auto-fill-mode t)))

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
