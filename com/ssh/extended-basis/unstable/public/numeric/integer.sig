(* Copyright (C) 2006-2007 SSH Communications Security, Helsinki, Finland
 *
 * This code is released under the MLton license, a BSD-style license.
 * See the LICENSE file or http://mlton.org/License for details.
 *)

(** Extended {INTEGER} signature. *)
signature INTEGER = sig
   eqtype int

   type t
   (** Convenience alias. *)

   (** == Misc == *)

   val precision : Int.t Option.t

   val minInt : t Option.t
   val maxInt : t Option.t

   (** == Numeric == *)

   val + : t BinOp.t
   val - : t BinOp.t
   val * : t BinOp.t

   val div : t BinOp.t
   val mod : t BinOp.t

   val quot : t BinOp.t
   val rem : t BinOp.t

   val ~ : t UnOp.t

   (** == Predicates == *)

   val isEven : t UnPr.t
   (**
    * Returns true if the given integer is of the form {2*n} for some
    * integer {n}.
    *)

   val isOdd : t UnPr.t
   (**
    * Returns true if the given integer is of the form {2*n+1} for some
    * integer {n}.
    *)

   val isZero : t UnPr.t
   (** Returns true if the given integer is {0}. *)

   (** == Concepts == *)

   include FORMATTABLE_and_SCANNABLE_FROM_FORMAT
           where type formattable_format = BasisStringCvt.radix
   include INTABLE
   include LARGEABLE where type largeable_large = LargeInt.t
   include MAYBE_BOUNDED
   include ORDERED
   include SIGNED
   include STRINGABLE

   sharing type t = int = bounded = formattable = intable = largeable = ordered
                  = signed = stringable
end
