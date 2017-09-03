(require 'ert)
(require 'winnow)

(ert-deftest winnow--results-start ()
  (switch-to-buffer (find-file "output-ag.txt"))
  (should (= 273 (winnow-results-start))))

(ert-deftest winnow--results-end ()
  (switch-to-buffer (find-file "output-ag.txt"))
  (should (= 621 (winnow-results-end))))
