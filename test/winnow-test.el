;;; winnow-test.el --- Tests for winnow

(ert-deftest winnow--results-start ()
  (switch-to-buffer (find-file "output-ag.txt" ))
  (should (equal 273 (winnow-results-start))))

(ert-deftest winnow--results-end ()
  (switch-to-buffer (find-file "output-ag.txt"))
  (should (equal 621 (winnow-results-end))))

;;; winnow-test.el ends here
