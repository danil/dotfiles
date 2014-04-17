(my-after-init
  (global-set-key (my-kbd "b h r") 'my-highlight-regexp))

(defun my-highlight-regexp (&optional arg)
  (interactive "P")
  (if arg (call-interactively 'unhighlight-regexp)
    (call-interactively 'highlight-regexp)))
