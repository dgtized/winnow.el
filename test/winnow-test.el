;;; winnow-test.el --- Tests for winnow

(require 'ert)
(require 'winnow)
(require 'ag)

(defun setup-ag-buffer ()
  (switch-to-buffer (find-file (expand-file-name "output-ag.txt" "test"))))

(ert-deftest results-start ()
  (setup-ag-buffer)
  (should (equal (winnow-results-start) 273)))

(ert-deftest results-end ()
  (setup-ag-buffer)
  (should (equal (winnow-results-end) 621)))

;;; winnow-test.el ends here
