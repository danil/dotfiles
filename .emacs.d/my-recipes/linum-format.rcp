;;; Linum (line numbers) format.
;;; Separating line numbers from text
;;; <http://www.emacswiki.org/emacs/LineNumbers#toc7>.

(my-after-init
  (my-eval-after-load 'linum
    (unless window-system
      (setq linum-format 'my-linum-format))

    (defgroup my-line-numbers nil
      "Custom line numbers in the left margin."
      :group 'linum
      :prefix "my-line-numbers-")
    (defface my-line-numbers-separator
      '((t :inherit linum))
      "Face for separation between the line number display and the buffer contents."
      :group 'my-line-numbers)
    (set-face-background 'my-line-numbers-separator
                         my-line-numbers-background)))

(unless window-system
  (add-hook 'linum-before-numbering-hook
            (lambda ()
              (setq-local linum-format-fmt
                          (let ((w (length
                                    (number-to-string
                                     (count-lines (point-min)
                                                  (point-max))))))
                            (concat "%" (number-to-string w) "d"))))))

(defun my-linum-format (line)
  (concat
   (propertize (format linum-format-fmt line) 'face 'linum)
   (propertize " " 'face 'my-line-numbers-separator)))
