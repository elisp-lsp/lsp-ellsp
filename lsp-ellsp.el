;;; lsp-ellsp.el --- LSP Clients for Ellsp  -*- lexical-binding: t; -*-

;; Copyright (C) 2023-2026  Shen, Jen-Chieh

;; Author: Shen, Jen-Chieh <jcs090218@gmail.com>
;; Maintainer: Shen, Jen-Chieh <jcs090218@gmail.com>
;; URL: https://github.com/elisp-lsp/lsp-ellsp
;; Version: 0.2.0
;; Package-Requires: ((emacs "28.1") (lsp-mode "6.1"))
;; Keywords: convenience

;; This file is not part of GNU Emacs.

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; LSP Clients for Ellsp.
;;

;;; Code:

(require 'lsp-mode)

(defgroup lsp-ellsp nil
  "LSP Clients for Ellsp."
  :prefix "lsp-ellsp-"
  :group 'tool
  :link '(url-link :tag "Repository" "https://github.com/elisp-lsp/lsp-ellsp"))

(defun lsp-ellsp--executable ()
  "Return the language server executable name."
  (pcase system-type
    (`windows-nt "ellsp.exe")
    (_           "ellsp")))

(add-to-list 'lsp-language-id-configuration '(emacs-lisp-mode . "emacs-lisp"))

(lsp-register-client
 (make-lsp-client
  :new-connection
  (lsp-stdio-connection
   (lambda ()
     (cond ((locate-dominating-file (buffer-file-name) "Eask")
            (list "eask" "exec" (lsp-ellsp--executable)))
           (t (error "Ellsp Language Server can only run with Eask")))))
  :major-modes '( emacs-lisp-mode)
  :priority 1
  :server-id 'ellsp))

(provide 'lsp-ellsp)
;;; lsp-ellsp.el ends here
