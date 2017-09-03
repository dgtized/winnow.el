;;; winnow-test.el --- Tests for winnow

(require 'ert)
(require 'winnow)
(require 'ag)

(defun switch-to-output (filename)
  (find-file (expand-file-name filename "test")))

(ert-deftest results-start-ag ()
  (save-excursion
    (switch-to-output "output-ag.txt")
    (should (equal (winnow-results-start) 233))))

;; (ert-deftest results-start-grep ()
;;   (save-excursion
;;     (switch-to-output "output-grep.txt")
;;     (should (equal (winnow-results-start) 103))))

(ert-deftest results-end-ag ()
  (save-excursion
    (switch-to-output "output-ag.txt")
    (should (equal (winnow-results-end) 581))))

;; (ert-deftest results-end-grep ()
;;   (save-excursion
;;     (switch-to-output "output-grep.txt")
;;     (should (equal (winnow-results-end) 401))))

;;; winnow-test.el ends here
