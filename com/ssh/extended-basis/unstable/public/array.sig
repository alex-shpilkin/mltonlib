(* Copyright (C) 2006 SSH Communications Security, Helsinki, Finland
 *
 * MLton is released under a BSD-style license.
 * See the file MLton-LICENSE for details.
 *)

(**
 * Extended {ARRAY} signature.
 *)
signature ARRAY = sig
   include ARRAY

   type 'a t = 'a array
   (**
    * Convenience alias.
    *)

   (** == Conversions == *)

   val fromVector : 'a vector -> 'a array
   (**
    * Creates a new array from the given vector.  Specifically, the
    * expression {fromVector v} is equivalent to the expression
    *
    *> tabulate (Vector.length v, fn i => Vector.sub (v, i))
    *)

   val toList : 'a array -> 'a list
   (**
    * Generates a list from the given array.  Specifically, the result of
    * {toList a} is equivalent to {foldr op :: [] a}.
    *)

   val toVector : 'a array -> 'a vector
   (**
    * Generates a vector from the given array.  Specifically, the result
    * of {toVector a} is equivalent to
    *
    *> Vector.tabulate (length a, fn i => sub (a, i))
    *)

   (** == Isomorphisms == *)

   val isoList : ('a array, 'a list) Iso.t
   (**
    * An isomorphism between arrays and lists.  It is always equivalent to
    * {(toList, fromList)}.  Note that the isomorphism does not preserve
    * identity.
    *)

   val isoVector : ('a array, 'a vector) Iso.t
   (**
    * An isomorphism between arrays and vectors.  It is always equivalent
    * to {(toVector, fromVector)}.  Note that the isomorphism does not
    * preserve identity.
    *)
end
