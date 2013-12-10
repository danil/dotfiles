;;; My projects.

;;;###autoload
(defun my-project-root ()
  (if (fboundp 'ffip-project-root)
      (ffip-project-root)
    (projectile-project-root)))
