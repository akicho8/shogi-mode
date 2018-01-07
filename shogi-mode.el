;;; shogi-mode.el --- メモを集中管理する

;; Copyright (C) 2018 Free Software Foundation, Inc.

;; Author: Akira Ikeda <pinpon.ikeda@gmail.com>
;; Keywords: shogi format color kif ki2 sfen usi csa

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;; (require 'shogi-mode)

;;; Code:

(defun shogi-mode ()
  (interactive)
  (kill-all-local-variables)
  (setq major-mode 'shogi-mode)
  (setq mode-name "将棋棋譜モード")
  (shogi-font-lock)
  (set (make-local-variable 'truncate-lines) t)
  (run-hooks 'shogi-mode-hook))

(defun shogi-font-lock ()
  (font-lock-add-keywords
   nil
   '(
     ;; " 1 "
     ("^ *\\([0-9]+\\) +"
      (1 font-lock-function-name-face t))

     ;; "６八銀"
     ("\\(?:[１-９1-9一二三四五六七八九]\\{2\\}\\)?\\(?:同\\)?[ 　]*\\(?:成[銀桂香]\\|[王玉金銀全桂圭香杏角馬飛龍竜歩と]\\)\\(?:[左右直]?[寄引上]?\\)\\(?:不?成\\|打\\|合\\|生\\)?"
      (0 font-lock-string-face t)
      )

     ;; "(79)"
     ("(\\([1-9]\\{2\\}\\))"
      (1 font-lock-builtin-face t))

     ;; "場所：将棋会館"
     ("^\\(.*\\)：\\(.*\\)"
      (1 font-lock-type-face t)
      (2 font-lock-string-face t))

     ;; "手数----指手---------消費時間--"
     ("^手数.*" 0 font-lock-constant-face t)

     ;; "まで27手で先手の勝ち"
     ("^まで.*" 0 font-lock-warning-face t)

     ;; "*▲戦型：四間飛車"
     ("^\\(#\\|\\*\\)\\(.*\\)"
      (1 font-lock-comment-delimiter-face t)
      (2 font-lock-comment-face t))
     )))

(add-to-list 'auto-mode-alist '("\\.\\(kif\\|ki2\\|sfen\\|usi\\|csa\\)\\'" . shogi-mode))

(provide 'shogi-mode)
;;; shogi-mode.el ends here
