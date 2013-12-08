;;;###autoload
(dolist (pattern (list (rx "/.gitignore_global" string-end)))
  (add-to-list 'auto-mode-alist (cons pattern 'gitignore-mode)))
