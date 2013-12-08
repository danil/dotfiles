;;; My tags <http://emacswiki.org/BuildTags#toc2>.

;;;###autoload
(defun my-build-tags ()
  (interactive)
  (let ((command "/usr/bin/ctags")
        ;; (command  "/usr/bin/exuberant-ctags")
        (dir-name (read-string "Directory: " (my-project-root))))
    (shell-command (format "%s -f %s/TAGS -e -R %s" command dir-name dir-name))
    (message "Building project tags")
    (my-visit-project-tags)))

;;;###autoload
(defun my-build-ruby-tags ()
  (interactive)
  (message "Building project tags")
  (let ((root (my-project-root)))
    (shell-command (format "cd %s && ripper-tags --format=emacs --exclude=spec --exclude=test --recursive --tag-file TAGS --force"
                           root)))
  (my-visit-project-tags))

;;;###autoload
(defun my-visit-project-tags-prompt ()
  (interactive)
  (let ((tags-file (read-string "Directory: " (my-project-root))))
    (my-visit-tags tags-file)))

;;;###autoload
(defun my-visit-project-tags ()
  (interactive)
  (let ((tags-file (my-project-root)))
    (my-visit-tags tags-file)))

(defun my-visit-tags (dir)
  (let ((tags-file (concat dir "TAGS")))
    (visit-tags-table tags-file)
    (message (concat "Loaded " tags-file))))
