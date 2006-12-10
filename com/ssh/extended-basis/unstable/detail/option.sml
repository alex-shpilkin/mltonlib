(* Copyright (C) 2006 SSH Communications Security, Helsinki, Finland
 *
 * This code is released under the MLton license, a BSD-style license.
 * See the LICENSE file or http://mlton.org/License for details.
 *)

structure Option : OPTION = struct
   open Option
   val isNone = fn NONE   => true
                 | SOME _ => false
end