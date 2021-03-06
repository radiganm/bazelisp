# Copyright 2015 Google Inc.  All rights reserved.
# Author: andrzejwalczak@google.com (Andrzej Walczak)
# Description:
# Test directory for the Lisp Skylark build rules.

licenses(["unencumbered"])  # New BSD, Google-authored

exports_files(["LICENSE"])

# TODO(czak): Need to provide a proper path here.
load(
    "@lisp__bazel//:bazel/rules.bzl",
    "lisp_library",
    "lisp_binary",
    "lisp_test",
)

lisp_library(
    name = "foo",
    srcs = ["foo.lisp"],
    cdeps = [":foo-ci"],
    compile_data = ["foo.data"],
    data = ["foo.data"],
)

lisp_library(
    name = "bar",
    srcs = [
        "bar.lisp",
        "bar2.lisp",
    ],
    deps = [":foo"],
)

cc_library(
    name = "foo-ci",
    srcs = ["foo.cc"],
)

lisp_binary(
    name = "baz",
    srcs = ["baz.lisp"],
    deps = [":bar"],
)

lisp_test(
    name = "foo-data-test",
    main = "cl-user::foo-data-test",
    deps = [":bar"],
)

lisp_library(
    name = "lib1",
    srcs = [
        # Ordered
        "a.lisp",
        "b.lisp",
        "c.lisp",
        "d.lisp",
    ],
    order = None,
    # setup = ["a.lisp"],
)

lisp_library(
    name = "lib2",
    srcs = ["test.lisp"],
    nowarn = [
        "optional-and-key",
        "implicit-generic",
    ],
    deps = [":lib1"],
)

lisp_library(
    name = "e",
    srcs = ["e.lisp"],
    deps = [":lib1"],
)

lisp_binary(
    name = "test",
    save_runtime_options = False,
    deps = [
        ":e",
        ":lib1",
        ":lib2",
    ],
)

# The SRCS files need .sh or .bash extension.
#sh_test(
#    name = "run-test",
#    srcs = ["test"],
#)

sh_test(
    name = "check_symbols",
    srcs = ["check_symbols.sh"],
    data = ["test"],
)

cc_library(
    name = "empty",
    srcs = ["empty.cc"],
)

lisp_binary(
    name = "lisp-test-image",
    cdeps = [":empty"],
    main = None,
    # verbose = 1,
    deps = [
        # Sequential
        ":lib2",
        ":e",
    ],
)

# Fails because of missing C dependencies in the image.
#lisp_test(
#    name = "lisp-test",
#    size = "small",
#    srcs = ["empty.lisp"],
#    image = ":lisp-test-image",
#)

CIRCULAR_SRCS = [
    "circular1.lisp",
    "circular2.lisp",
    "circular3.lisp",
    "test-circular.lisp",
]

lisp_test(
    name = "circular",
    srcs = CIRCULAR_SRCS,
    order = "multipass",
)

lisp_library(
    name = "undefined-macro-error",
    srcs = [
        # Ordered
        "undefined-macro-reference.lisp",
        "undefined-macro-definition.lisp",
    ],
)

lisp_test(
    name = "undefined-macro-test",
    srcs = ["undefined-macro-test.lisp"],
    deps = [":undefined-macro-error"],
)

lisp_test(
    name = "args-test",
    srcs = ["args-test.lisp"],
    args = ["--foo"],
)

lisp_library(
    name = "features",
    features = ["features"],
)

lisp_test(
    name = "features-test",
    srcs = ["features-test.lisp"],
    features = ["features-test"],
    deps = [":features"],
)

lisp_library(
    name = "wrong-arg-count-lib",
    srcs = ["wrong-arg-count.lisp"],
)

lisp_test(
    name = "wrong-arg-count-test",
    srcs = ["wrong-arg-count-test.lisp"],
    nowarn = ["wrong-argument-count"],
    deps = [":wrong-arg-count-lib"],
)

# For demonstration purposes.
lisp_test(
    name = "compilation-mode",
    srcs = ["compilation-mode.lisp"],
)
