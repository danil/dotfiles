;;; This file is part of Danil Kutkevich <danil@kutkevich.org> home.
;(add-to-list 'load-path "~/share/emacs/site-lisp")

;;; Truncation of Lines (toggle-truncate-lines)
;;; <http://emacswiki.org/emacs/TruncateLines>.
(set-default 'truncate-lines nil) ;wrap long lines

(setq system-time-locale "C")
(setq calendar-week-start-day 1)
(global-font-lock-mode 1)

;;; Put <http://www.gnu.org/software/emacs/manual/html_node/elisp/Symbol-Plists.html>.
;; Horizontal Scrolling
;; <http://gnu.org/software/emacs/manual/html_node/emacs/Horizontal-Scrolling.html#Horizontal-Scrolling>.
(put 'scroll-left 'disabled nil)
(put 'upcase-region 'disabled nil)

;;; My custom variables.
(setq custom-file "~/.emacs.d/my-custom-variables.el")
(load custom-file)

;;; My packages (el-get <http://github.com/dimitri/el-get>).
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))
(add-to-list 'el-get-recipe-path
             (concat user-emacs-directory "my-el-get/recipes"))
;; (setq el-get-user-package-directory
;;       (concat user-emacs-directory "my-el-get/init-files"))
(setq my-packages (append (mapcar 'el-get-source-name el-get-sources)))

;;; My recipes.
(dolist (recipe
         '(
          "my-recipe-helpers"
          "ag"
          "apache-mode"
          "auto-complete"
          "auto-complete-chunk"
          "auto-complete-css"
          "auto-complete-emacs-lisp"
          "auto-complete-etags"
          "bash-completion"
          "calendar"

          ;; Clojure.
          "cider" ;clojure-mode dependency
          "clojure-mode"

          "coffee-mode"
          "column-marker"
          "conf-mode"
          "crontab-mode"
          "css"
          "csv-mode"
          "dart-mode"
          "deft"
          "desktop"
          "diff-mode"
          "dired"
          "disp-table"
          "ebuild-mode"
          "ediff"
          "emacs-lisp-mode"
          "erise"
          "etags-select"
          "ethan-wspace"
          "expand-region"
          "files"
          "fill"
          "findr"
          "fiplr"
          "git-commit-mode"
          "git-gutter"
          "git-modes"
          "gitignore-mode"
          "go-mode"
          "haml-mode"
          "haskell-mode"
          "help"
          "hi-lock"
          "hideshow"
          "highlight-current-line"
          "highlight-symbol"
          "ibuffer"
          "ido-yes-or-no"
          "interprogram"
          "isearch"
          "jade-mode"
          "js-mode"
          "js2-mode" ;coffee mode defaults to js2-mode, which is not present in Emacs by default
          "json-reformat"
          "less" ;do not remove, used for generic scroll!
          "less-css-mode"
          "linum"
          "linum-format"
          "lisp-mode"
          "lua"
          "lua-mode"
          "magit"
          "magit-blame"
          "markdown-mode"
          "mmm-mode"
          "my-backspace-fix"
          "my-color-theme"
          "my-project"
          "my-tags"
          "nginx-mode"
          "nodejs-repl"
          "nvm"
          "occur-mode"
          "org-mode"
          "org-reveal"
          "php-mode"
          "pomohist"
          "pretty-lambdada"
          "rainbow-delimiters"
          "rainbow-mode"
          "re-builder"
          "replace"
          "rhtml-mode"
          "rinari"
          "rspec-compilation-mode"
          "rspec-mode"
          "ruby-hash-syntax"
          "ruby-mode"
          "ruby-pry"
          "ruby-refactor"
          "ruby-tools"
          "rust-mode"
          "rvm"
          "sass-mode"
          "savehist"
          "scss-mode"
          "sh-script"
          "sieve-mode"
          "simp"
          "simple"
          "slim-mode"
          "smart-mode-line"
          "smartparens"
          "smex"
          "sort"
          "undo-tree"
          "window"
          "window-numbering"
          "yaml-mode"
          ))
  (load-file (concat user-emacs-directory "my-recipes/" recipe ".rcp")))

;;; Install/remove my packages (see above).
(el-get-cleanup my-packages) ;remove all packages absent from `my-packages'
(el-get 'sync my-packages)

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

;;; Transient Mark mode <http://emacswiki.org/TransientMarkMode>.
(transient-mark-mode 1)

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

;;; JavaScript mode.
;;; HTML Components (HTCs or .htc)
;;; <http://en.wikipedia.org/wiki/HTML_Components>.
(add-to-list 'auto-mode-alist '("\\.htc$" . js-mode))
(setq js-indent-level 2)

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
(global-set-key (my-kbd "s i c") 'my-toggle-camelcase-and-underscore-with-repeat)
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

(global-set-key (my-kbd "s i h") 'my-humanize-symbol-with-repeat)
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
(global-set-key (my-kbd "s u") 'uniquify-all-lines-region)
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


;;; Auto Fill Mode
;;; <http://gnu.org/software/emacs/manual/html_node/emacs/Auto-Fill.html>.
;(add-hook 'mail-mode-hook (lambda () (auto-fill-mode t)))

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
