;; TODO(czak): This requires proper path.
(defconstant +data+ "test/foo.data")

(eval-when (:compile-toplevel)
  #+sbcl (format t "Compile CWD: ~A~%" (sb-posix:getcwd))
  #+sbcl (format t "Compile arg0: ~A~%" (bazel.sbcl:program-name))
  (format t "Compile default pathname: ~A~%" *default-pathname-defaults*)
  (format t "Compile: FOO: ~A~%" (with-open-file (in +data+) (read in))))

(eval-when (:load-toplevel)
  #+sbcl (format t "Load CWD: ~A~%" (sb-posix:getcwd))
  #+sbcl (format t "Load arg0: ~A~%" (bazel.sbcl:program-name))
  (format t "Load default pathname: ~A~%" *default-pathname-defaults*)
  (format t "Load: FOO: ~A~%" (with-open-file (in +data+) (read in))))

(defun foo (from)
  (format t "Called foo from: ~A~%" from))

(defun foo-data-test ()
  (with-open-file (in +data+)
    (assert (equal 4 (file-length in)))
    (assert (equal 1234 (read in))))) ; NOLINT
