(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))
(add-hook 'coffee-mode-hook
          '(lambda()
             (setq coffee-js-mode ;coffee mode defaults to js2-mode, which is not present in Emacs by default
                   (if (fboundp 'js2-mode) 'js2-mode 'javascript-mode))
             (set (make-local-variable 'tab-width) 2)))
