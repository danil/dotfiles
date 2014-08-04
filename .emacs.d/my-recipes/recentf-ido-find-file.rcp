(my-after-init (global-set-key (kbd "C-x C-r") 'recentf-ido-find-file))

;; <http://www.emacswiki.org/emacs/RecentFiles#toc5>.
(defun recentf-ido-find-file ()
  "Find a recent file using Ido. A-la recentf-open-files"
  (interactive)
  (let ((file (ido-completing-read "Choose recent file: " recentf-list nil t)))
    (when file
      (find-file file))))
