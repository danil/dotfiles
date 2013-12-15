(eval-after-load 'git-gutter
  '(progn
     (setq git-gutter:lighter " GG")
     (setq git-gutter:modified-sign "=          ")
     (setq git-gutter:added-sign    "+          ")
     (setq git-gutter:deleted-sign  "-          ")
     (cond ((equal frame-background-mode 'light)
            (set-face-background 'git-gutter:added     "gray90")
            (set-face-background 'git-gutter:deleted   "gray90")
            (set-face-background 'git-gutter:modified  "gray90")
            (set-face-background 'git-gutter:separator "gray90")
            (set-face-background 'git-gutter:unchanged "gray90")
            )
           ((equal frame-background-mode 'dark)
            (set-face-background 'git-gutter:added     "gray15")
            (set-face-background 'git-gutter:deleted   "gray15")
            (set-face-background 'git-gutter:modified  "gray15")
            (set-face-background 'git-gutter:separator "gray15")
            (set-face-background 'git-gutter:unchanged "gray15")
            ))
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
