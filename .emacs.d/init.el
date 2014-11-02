;;; This file is part of Danil <danil@kutkevich.org> home.

;; Danil <http://emacswiki.org/DotEmacsDotD>,
;; <http://emacs.stackexchange.com/questions/1/are-there-any-advantages-to-using-emacs-d-init-el-instead-of-emacs>.

;;; Truncation of Lines (toggle-truncate-lines)
;;; <http://emacswiki.org/emacs/TruncateLines>.
(set-default 'truncate-lines nil) ;wrap long lines

(setq calendar-week-start-day t)
(setq system-time-locale "C")

(global-font-lock-mode t)

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
(dolist (recipe '(
                  "my-recipe-helpers"
                  "ac-cider"
                  "ac-dabbrev"
                  "ag"
                  "apache-mode"
                  "auto-complete"
                  "auto-complete-chunk"
                  "auto-complete-emacs-lisp"
                  "auto-complete-etags"
                  "auto-complete-nxml"
                  "bash-completion"
                  "browse-kill-ring"
                  "calendar"

                  ;; Clojure.
                  "cider" ;clojure-mode dependency ;manual upgrade
                  "clojure-mode" ;manual upgrade
                  "smartparens"

                  "cc-vars"
                  "coffee-mode"
                  "column-marker"
                  "conf-mode"
                  "crontab-mode"
                  "css"
                  "csv-mode"
                  "deft"
                  "desktop"
                  "diff-mode"
                  "dired"
                  "dired-reuse-directory-buffer"
                  "direx"
                  "discover-my-major"
                  "disp-table"
                  "ebuild-mode"
                  "ediff"
                  "emacs-lisp-mode"
                  "env"
                  "erise"
                  "etags-select"
                  "ethan-wspace"
                  "expand-region"
                  "files"
                  "files-backup"
                  "fill"
                  "findr"
                  "fiplr"
                  "fish-mode"
                  "git-commit-mode"
                  "git-gutter"
                  "git-modes"
                  "git-timemachine"
                  "gitignore-mode"
                  "haml-mode"
                  "helm"
                  "helm-ag"
                  "helm-descbinds"
                  "helm-git-grep"
                  "helm-ls-git"
                  "helm-swoop"
                  "help"
                  "hi-lock"
                  "hideshow"
                  "highlight-current-line"
                  "highlight-symbol"
                  "ibuffer"
                  "ido"
                  "ido-preview"
                  "ido-ubiquitous"
                  "ido-vertical-mode"
                  "ido-yes-or-no"
                  "indent"
                  "indent-guide"
                  "info"
                  "interprogram"
                  "isearch"
                  "jade-mode"
                  "js-mode"
                  "js2-mode"
                  "json-mode"
                  "json-reformat"
                  "kill-emacs"
                  "kill-ring"
                  "kill-ring-ido"
                  "less"
                  "less-css-mode"
                  "linum"
                  "linum-format"
                  "lisp-mode"
                  "lua-mode"
                  "magit"
                  "magit-blame"
                  "markdown-mode"
                  "multiple-cursors"
                  "my-backspace-fix"
                  "my-beginning-of-line"
                  "my-color-theme"
                  "my-project"
                  "my-tags"
                  "nginx-mode"
                  "nodejs-repl"
                  "nvm"
                  "occur-mode"
                  "org-mode" ;manual upgrade
                  "org-reveal"
                  "paren"
                  "password-cache"
                  "point-stack"
                  "pomohist"
                  "pretty-lambdada"
                  "quickrun"
                  "rainbow-delimiters"
                  "rainbow-mode"
                  "rbenv"
                  "re-builder"
                  "recentf"
                  "recentf-ido-find-file"
                  "rich-minority"
                  "rinari"
                  "rspec-compilation-mode"
                  "rspec-mode"
                  "ruby-hash-syntax"
                  "ruby-mode"
                  "ruby-pry"
                  "ruby-refactor"
                  "ruby-tools"
                  "sass-mode"
                  "savehist"
                  "saveplace"
                  "scss-mode"
                  "sgml-mode"
                  "sh-script"
                  "sieve-mode"
                  "simp"
                  "simple"
                  "smart-mode-line"
                  "smex"
                  "sort"
                  "subword-mode"
                  "text-mode"
                  "undo-tree"
                  "uniquify"
                  "web-mode"
                  "window"
                  "window-numbering"
                  "winner-mode"
                  "yaml-mode"
                  "yascroll"
                  "yasnippet"
                  "yasnippets"
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

(transient-mark-mode 1) ;Transient Mark mode <http://emacswiki.org/TransientMarkMode>
;(set-keyboard-coding-system 'mule-utf-8)
;(set-default-coding-systems 'utf-8)
;(set-terminal-coding-system 'utf-8)
;(modify-coding-system-alist 'file "/home/danil/src/vendor/prohq/avers/" 'utf-8)
;(set-language-environment 'cyrillic-koi8)

(menu-bar-mode -1) ;Menu Bar <http://gnu.org/software/emacs/manual/html_node/emacs/Menu-Bars.html>, <http://emacswiki.org/MenuBar>

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

;;; IswitchB <http://emacswiki.org/IswitchBuffers>.
;; (iswitchb-mode 1)
;; (setq iswitchb-buffer-ignore '("^ " "*scratch*" "*Messages*"
;;                                "*Completions*" "*Ibuffer*"))
;(setq iswitchb-default-method 'samewindow)

;;; Server <http://shreevatsa.wordpress.com/tag/emacs/>.
;; (remove-hook 'kill-buffer-query-functions
;;              'server-kill-buffer-query-function)

;;; Browse Url with Epiphany.
;; (setq browse-url-browser-function 'browse-url-epiphany)

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
