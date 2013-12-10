(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))
(add-hook 'coffee-mode-hook
          '(lambda()
             ;; (setq coffee-js-mode 'javascript-mode) ;coffee mode defaults to js2-mode, which is not present in Emacs by default
             (set (make-local-variable 'tab-width) 2)))
