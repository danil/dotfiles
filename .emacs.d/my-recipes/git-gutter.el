(eval-after-load 'git-gutter
  '(progn
     (setq git-gutter:lighter " GG")
     (setq git-gutter:modified-sign "=          ")
     (setq git-gutter:added-sign    "+          ")
     (setq git-gutter:deleted-sign  "-          ")
     (dolist (face '(
                     git-gutter:added
                     git-gutter:deleted
                     git-gutter:modified
                     git-gutter:separator
                     git-gutter:unchanged
                     ))
       (set-face-background face my-line-number-background))
     ))
(dolist (hook '(
                awk-mode-hook
                c-mode-hook
                coffee-mode-hook
                conf-mode-hook
                css-mode-hook
                emacs-lisp-mode-hook
                haml-mode-hook
                haskell-mode-hook
                html-mode-hook
                java-mode-hook
                js-mode-hook
                lisp-mode-hook
                lua-mode-hook
                makefile-gmake-mode-hook
                markdown-mode-hook
                nxml-mode-hook
                org-mode-hook
                perl-mode-hook
                php-mode-hook
                python-mode-hook
                ruby-mode-hook
                sass-mode-hook
                sgml-mode-hook
                sh-mode-hook
                sql-mode-hook
                xml-mode-hook
                yaml-mode-hook
                ))
  (add-hook hook 'git-gutter-mode))
