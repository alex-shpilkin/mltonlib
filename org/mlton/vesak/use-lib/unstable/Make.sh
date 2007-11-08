#!/bin/bash

# Copyright (C) 2007 Vesa Karvonen
#
# This code is released under the MLton license, a BSD-style license.
# See the LICENSE file or http://mlton.org/License for details.

set -e

code="$(cat public/use-lib.sig detail/use-lib.sml public/export.sml)"

function gen {
    echo "(* Copyright (C) 2007 Vesa Karvonen
 *
 * This code is released under the MLton license, a BSD-style license.
 * See the LICENSE file or http://mlton.org/License for details.
 *)

(* WARNING: This file was generated by the $(basename $0) script. *)" > "$1.use"

    echo "$code"                                \
  | grep -v '^ *(\?\*'                          \
  | sed -e "s/\\\$(SML_COMPILER)/\"$1\"/g"      \
        -e "s/\\\$(SILENT)/$(echo -n $2)/g"     \
        -e "s/\\\$(VERBOSE)/$(echo -n $3)/g"    \
        -e "s/\\\$(PRELUDE)/$(echo -n $4)/g"    \
  >> "$1.use"
    echo "Wrote $1.use"
}

gen polyml                                      \
    '(PolyML.get_print_depth ()                 \
      before PolyML.print_depth 0)'             \
    'PolyML.print_depth'                        \
    ''

gen smlnj                                       \
    'let                                        \
        open Control.Print                      \
     in                                         \
        {depth = !printDepth,                   \
         sigs  = !signatures}                   \
        before (printDepth := 0                 \
              ; signatures := 0)                \
     end'                                       \
    'let                                        \
        open Control.Print                      \
     in                                         \
        fn old => (printDepth := #depth old     \
                 ; signatures := #sigs old)     \
     end'                                       \
    ''

gen mosml '()' 'ignore' 'val () = load "OS" ;'
