(* Copyright (C) 2007 SSH Communications Security, Helsinki, Finland
 *
 * This code is released under the MLton license, a BSD-style license.
 * See the LICENSE file or http://mlton.org/License for details.
 *)

signature EXT_GENERIC_INDEX = sig
   type ('a, 'x) t
   val getT : ('a, 'x) t -> 'x
   val mapT : 'x UnOp.t -> ('a, 'x) t UnOp.t

   type ('a, 'x) s
   val getS : ('a, 'x) t -> 'x
   val mapS : 'x UnOp.t -> ('a, 'x) t UnOp.t

   type ('a, 'k, 'x) p
   val getP : ('a, 'k, 'x) p -> 'x
   val mapP : 'x UnOp.t -> ('a, 'k, 'x) p UnOp.t
end
