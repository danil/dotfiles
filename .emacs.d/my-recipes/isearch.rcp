(add-hook 'isearch-mode-hook
          (lambda ()
            (cond ((equal frame-background-mode 'light)
                   (set-face-attribute 'isearch nil
                                       :foreground "lightskyblue1"
                                       :background "red1")
                   (set-face-attribute 'isearch-fail nil
                                       :foreground "lightskyblue1"
                                       :background "red1"))
                  ((equal frame-background-mode 'dark)
                   (set-face-attribute 'isearch nil
                                       :foreground "lightskyblue1"
                                       :background "red")
                   (set-face-attribute 'isearch-fail nil
                                       :foreground "lightskyblue1"
                                       :background "red")))))
