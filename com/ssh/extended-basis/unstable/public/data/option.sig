(* Copyright (C) 2006 SSH Communications Security, Helsinki, Finland
 *
 * This code is released under the MLton license, a BSD-style license.
 * See the LICENSE file or http://mlton.org/License for details.
 *)

(** Extended {OPTION} signature. *)
signature OPTION = sig
   include OPTION

   type 'a t = 'a option
   (** Convenience alias. *)

   val isNone : 'a t UnPr.t
   (** Returns {true} if given option is {NONE}; otherwise returns {false}. *)

   val collate : 'a Cmp.t -> 'a t Cmp.t
   (** 
     * Returns {EQUAL} if given {(NONE,NONE)}; {GREATER} if given 
     * {(SOME _, NONE)}; {LESS} if given {(NONE, SOME _)}; for 
     * {(SOME _, SOME _)} it uses the provided comparison function. *)

end
