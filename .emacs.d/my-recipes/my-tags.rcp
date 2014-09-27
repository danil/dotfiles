;;; My tags <http://emacswiki.org/BuildTags#toc2>.

(defun my-build-tags ()
  (interactive)
  (let* ((dir (read-string "Directory: " (my-project-root)))
        ;; (command (format "/usr/bin/exuberant-ctags -f %s/TAGS -e -R %s" dir dir))
        (command (format "/usr/bin/etags --output=%s %s/*" dir dir)))
    (shell-command command)
    (message "Building project tags")
    (my-visit-tags dir)))

;; (defun my-build-ruby-tags ()
;;   (interactive)
;;   (let ((executable "ripper-tags")
;;         (dir (my-project-root)))
;;     ;; --exclude=spec
;;     ;; --exclude=test
;;     ;; --force
;;     ;; --format=emacs
;;     ;; --recursive
;;     ;; --tag-file=TAGS
;;     (if (not (executable-find executable))
;;         (message (format "`%s`command not found found" executable)
;;       (message "Building project tags")
;;       (shell-command
;;        (format
;;         "cd %s && %s --format=emacs --recursive --tag-file=TAGS --force"
;;         dir
;;         executable))
;;       (my-visit-tags dir)))))

(defun my-build-ruby-tags ()
  (interactive)
  (message "Building project tags")
  (let ((dir (my-project-root)))
    ;; --exclude=spec
    ;; --exclude=test
    ;; --force
    ;; --format=emacs
    ;; --recursive
    ;; --tag-file=TAGS
    (shell-command
     (format
      "cd %s && ripper-tags --format=emacs --recursive --tag-file=TAGS --force"
      dir))
    (my-visit-tags dir)))

(defun create-tags (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (shell-command
   (format "%s -f %s/TAGS -e -R %s" path-to-ctags dir-name dir-name)))

(defun my-visit-project-tags (dir)
  (interactive (list (read-directory-name "Directory: "
                                          (my-project-root))))
    (my-visit-tags dir))

(defun my-visit-project-tags-np ()
  (interactive)
  (let ((tags-file (my-project-root)))
    (my-visit-tags tags-file)))

(defun my-visit-tags (dir)
  (let ((tags-file (concat dir "TAGS")))
    (visit-tags-table tags-file)
    (message (concat "Loaded " tags-file))))
