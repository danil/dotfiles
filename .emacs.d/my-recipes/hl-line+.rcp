;;; Extended highlight current line.
(eval-after-load 'hl-line+ ;'hl-line
  '(progn
     (cond ((equal frame-background-mode 'dark)
            ;; Highlight current line
            ;; <http://emacs-fu.blogspot.com/2008/12/highlighting-current-line.html>,
            ;; <http://stackoverflow.com/questions/2718189/emacshighlight-the-current-line-by-underline-it#answer-2718543>.
            (defface hl-line '((t (:background nil))) ;#222
              "Face to use for `hl-line-face`." :group 'hl-line)
            (setq hl-line-face 'hl-line)
            ;; (set-face-attribute hl-line-face nil :underline t) ;looks inconsistent with fill-column-indicator
            (set-face-background hl-line-face "gray15") ;nil ;<http://stackoverflow.com/questions/4495406/hl-line-mode-emacs-color-change#4504223>
            ))
     ))
(global-hl-line-mode 1)
(dolist (hook '(
                ediff-mode-hook
                term-mode-hook
                ))
  ;; <http://emacsblog.org/2007/04/09/highlight-the-current-line/#comment-284>.
  (add-hook hook (lambda ()
                   (interactive)
                   (make-local-variable 'global-hl-line-mode)
                   (setq global-hl-line-mode nil))))
;; (dolist (hook '(
;;                 awk-mode-hook
;;                 change-log-mode-hook
;;                 coffee-mode-hook
;;                 conf-mode-hook
;;                 css-mode-hook
;;                 emacs-lisp-mode-hook
;;                 haml-mode-hook
;;                 haskell-mode-hook
;;                 html-mode-hook
;;                 java-mode-hook
;;                 js-mode-hook
;;                 lisp-mode-hook
;;                 lua-mode-hook
;;                 makefile-gmake-mode-hook
;;                 markdown-mode-hook
;;                 nxml-mode-hook
;;                 org-mode-hook
;;                 perl-mode-hook
;;                 php-mode-hook
;;                 ruby-mode-hook
;;                 sass-mode-hook
;;                 sgml-mode-hook
;;                 sh-mode-hook
;;                 sql-mode-hook
;;                 xml-mode-hook
;;                 yaml-mode-hook
;;                 ))
;;   (add-hook hook (lambda () (interactive) (toggle-hl-line-when-idle))))
