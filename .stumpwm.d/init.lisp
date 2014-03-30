;;; This file is part of Danil Kutkevich <danil@kutkevich.org> home.

(in-package :stumpwm)

(defvar *stumpwm-config-dir* "~/.stumpwm.d/"
  "StumpWM configuration directory.")
;; (defvar *stumpwm-contrib-dir* (concat *stumpwm-source-dir* "contrib/")
;;   "StumpWM contrib directory.")

;; (set-contrib-dir *stumpwm-contrib-dir*)

(load (concat *stumpwm-config-dir* "mem.lisp"))
