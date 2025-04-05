;;; test-helper.el --- Helper for tests              -*- lexical-binding: t; -*-

;; Copyright (C) 2017-2025 Charles L.G. Comstock

;; Author: Charles L.G. Comstock <dgtized@gmail.com>

;;; Code:

(require 'ert)

(defun directory-parent (dir)
  (unless (equal "/" dir)
    (file-name-directory (directory-file-name dir))))

(let ((winnow-dir (directory-parent (file-name-directory load-file-name))))
  (add-to-list 'load-path winnow-dir))

(require 'winnow)

;;; test-helper.el ends here
