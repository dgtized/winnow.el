;;; winnow.el --- filter compilation/ag results by matching/excluding lines -*- lexical-binding: t; -*-

;; Copyright (C) 2017  Charles L.G. Comstock

;; Author: Charles L.G. Comstock <dgtized@gmail.com>
;; Created: 3 Sept 2017
;; Version: 0.1
;; URL: https://github.com/dgtized/winnow.el
;; Keywords: matching

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Winnow `compilation-mode' results by matching or excluding lines from the
;; results. Normally these buffers are `read-only-mode', preventing the use of
;; editing commands, but `winnow-mode' commands inhibits this to apply
;; `flush-line' or `keep-lines' on the command output.
;;
;; As the edits are to the buffer, `recompile' is the recommended way to
;; regenerate the search.
;;
;; The main use case for this is filtering `ag-mode' search results in the
;; buffer to separate the wheat from the chaff.

;;; Usage:

;; Enable the package in `ag-mode' with the following:
;;
;;  (add-hook 'ag-mode-hook 'winnow-mode)

;;; Todo:

;; * Possibly use grep on ag command output?
;; * Expand to work on ack, git-grep, rgrep results

;;; Code:

(defun winnow-results-start ()
  "Find the start position of the compilation output"
  (save-excursion
    (goto-char (point-min))
    (forward-line 4) ;; TODO: replace ballistic offset with search
    (point)))

(defun winnow-results-end ()
  "Find the end position of the compilation output"
  (save-excursion
    (goto-char (point-max))
    (forward-line -7) ;; TODO: replace ballistic offset with search
    (point)))

(defun winnow-exclude-lines (regexp &optional rstart rend interactive)
  "Exclude the matching lines from the compilation results."
  (interactive (keep-lines-read-args "Flush lines containing match for regexp"))
  (let ((inhibit-read-only t)
        (start (or rstart (winnow-results-start)))
        (end (or rend (winnow-results-end))))
    (flush-lines regexp start end nil)
    (goto-char (point-min))))

(defun winnow-match-lines (regexp &optional rstart rend interactive)
  "Limit the compilation results to the matching lines."
  (interactive (keep-lines-read-args "Keep lines containing match for regexp"))
  (let ((inhibit-read-only t)
        (start (or rstart (winnow-results-start)))
        (end (or rend (winnow-results-end))))
    (keep-lines regexp start end nil)
    (goto-char (point-min))))

;;;###autoload
(define-minor-mode winnow-mode
  "Filter compilation results by matching/excluding lines.

This is invaluable for excluding or limiting to matching `ag-mode' results.

\\{winnow-mode-map}"
  :keymap (let ((map (make-sparse-keymap)))
            (define-key map (kbd "x") 'winnow-exclude-lines)
            (define-key map (kbd "m") 'winnow-match-lines)
            map))

(provide 'winnow)
;;; winnow.el ends here
