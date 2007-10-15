#!/bin/sh

# Copyright (C) 2007 SSH Communications Security, Helsinki, Finland
#
# This code is released under the MLton license, a BSD-style license.
# See the LICENSE file or http://mlton.org/License for details.

source="$1"
target="$2"

echo "(* Copyright (C) 2007 SSH Communications Security, Helsinki, Finland
 *
 * This code is released under the MLton license, a BSD-style license.
 * See the LICENSE file or http://mlton.org/License for details.
 *)

(* WARNING: This file was generated by running '$(basename $0)' script as:
 *
 *> $(basename $0) $source $target
 *)" > "$target"

grep -e '[ /]with/.*\.sml' "$source" \
 | xargs cat                         \
 | grep -v -e '^[( ]\*'              \
 >> "$target"
