(in-package #:mem)

(dolist (a '((#\M fmt-mem-usage-short)))
  (pushnew a *screen-mode-line-formatters* :test 'equal))
(defun fmt-mem-usage-short (ml)
  "Returns a string representing the current percent of used memory."
  (declare (ignore ml))
  (let* ((mem (mem-usage))
         (used-memory (truncate (* 100 (nth 2 mem)))))
    (format nil "~D%" used-memory)))
