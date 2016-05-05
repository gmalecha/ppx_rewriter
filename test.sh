#!/bin/bash

ocamlc -dsource -dparsetree -I _build/src_test/ -c -ppx ./ppx_rewrite.native src_test/test_ppx_rewrite.ml

rm -f src_test/*.cm*
