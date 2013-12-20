(add-hook 'dired-mode-hook 'rspec-dired-mode)
(eval-after-load 'rspec-mode
  '(progn
     (setq rspec-use-rake-when-possible nil)
     (setq rspec-use-rvm 1)
     ;; (setq rspec-spec-file-name-re "\\(_\\|-\\)\\(?:spec\\|group\\)\\.rb\\'")
     ))
