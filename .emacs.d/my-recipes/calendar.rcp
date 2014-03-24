(my-after-init
  (my-eval-after-load 'calendar
    ;; Week numbers <http://www.emacswiki.org/emacs/CalendarWeekNumbers#toc1>.
    (copy-face font-lock-constant-face 'calendar-iso-week-face)
    (set-face-foreground 'calendar-iso-week-face "gray40")
    (setq calendar-intermonth-text
          '(propertize
            (format "%2d"
                    (car
                     (calendar-iso-from-absolute
                      (calendar-absolute-from-gregorian (list month day year)))))
            'font-lock-face 'calendar-iso-week-face))))
