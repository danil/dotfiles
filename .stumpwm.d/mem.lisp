(in-package #:mem)

(dolist (a '((#\M fmt-mem-usage-short)
             (#\P fmt-swap-usage-short)))
  (pushnew a *screen-mode-line-formatters* :test 'equal))

(defun swap-usage ()
  "Returns a list containing 3 values:
total, allocated, allocated/total ratio
<https://github.com/grouzen/stumpwm/blob/master/contrib/mem.lisp>"
  (let ((allocated 0))
    (multiple-value-bind (swap-total swap-free)
        (with-open-file
         (file #P"/proc/meminfo" :if-does-not-exist nil)
         (values
          (read-from-string (get-proc-fd-field file "SwapTotal"))
          (read-from-string (get-proc-fd-field file "SwapFree"))))
      (setq allocated (- swap-total swap-free))
      (list swap-total allocated (/ allocated swap-total)))))

(defun fmt-mem-usage-short (ml)
  "Returns a string representing the current percent of used memory."
  (declare (ignore ml))
  (let* ((mem (mem-usage))
         (used-memory (truncate (* 100 (nth 2 mem)))))
    used-memory))

(defun fmt-swap-usage-short (ml)
  "Returns a string representing the current percent of used swap."
  (declare (ignore ml))
  (let* ((swap (swap-usage))
         (used-swap (truncate (* 100 (nth 2 swap)))))
    used-swap))
