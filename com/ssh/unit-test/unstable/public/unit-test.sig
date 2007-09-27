(* Copyright (C) 2007 SSH Communications Security, Helsinki, Finland
 *
 * This code is released under the MLton license, a BSD-style license.
 * See the LICENSE file or http://mlton.org/License for details.
 *)

(**
 * Signature for a simple unit testing framework.
 *)
signature UNIT_TEST = sig
   structure Rep : OPEN_REP
   (** Substructure specifying the representation of generics. *)

   type t
   (** Type of unit test fold state. *)

   type 'a s = (t, t, Unit.t, t, t, Unit.t, 'a) Fold.s
   (** Type of a unit test fold step. *)

   (** == Test Specification Interface == *)

   val unitTests : (t, t, Unit.t, 'a) Fold.f
   (** Begins test specification. *)

   val title : String.t -> 'a s
   (** {title string} specifies the title for subsequent tests. *)

   (** === Test Registration === *)

   val test : Unit.t Effect.t -> 'a s
   (**
    * Registers a test.  A test is just an arbitrary unit effect that
    * should indicate failure by raising an exception.
    *)

   val testEq : ('a, 'x) Rep.t -> {actual : 'a, expect : 'a} Thunk.t -> 'b s
   (** Tests that the expected and actual values are equal. *)

   val testRaises' : Exn.t Effect.t -> 'a Thunk.t -> 'b s
   val testRaises : Exn.t UnPr.t -> 'a Thunk.t -> 'b s
   (** Tests that the thunk raises an exception satisfying the predicate. *)

   val testFails : 'a Thunk.t -> 'b s
   (** Tests that the thunk raises an exception. *)

   (** == Random Testing == *)

   val testAll : ('a, 'x) Rep.t -> 'a Effect.t -> 'b s
   (** {testAll ty body} is equivalent to {test (fn () => all ty body)}. *)

   val all : ('a, 'x) Rep.t -> 'a Effect.t Effect.t
   (**
    * Procedurally, tries to fault the given test effect by calling it
    * with randomly generated data.
    *
    * Declaratively, specifies that a law must hold for all values of type
    * {'a}.  For example,
    *
    *> all int (fn x => that (x = x))
    *
    * specifies that all integers must be equal to themselves.
    *)

   val skip : 'a Thunk.t
   (**
    * Calling {skip ()} specifies that the premises of a conditional law
    * aren't satisfied so the specific test case of the law should be
    * ignored.  For example,
    *
    *> all (sq int)
    *>     (fn (x, y) =>
    *>         if x <= y
    *>         then that (Int.max (x, y) = y)
    *>         else skip ())
    *
    * specifies that if {x <= y} then {Int.max (x, y) = y}.
    *
    * Skipping tests is inefficient.  If a lot of tests are being skipped,
    * you should implement a better test data generator or a more
    * comprehensive law.
    *)

   (** == Collecting Statistics == *)

   type table
   val withFreq : table Effect.t Effect.t
   val collect : ('a, 'x) Rep.t -> table -> 'a Effect.t

   (** == Assertions == *)

   exception Failure of Prettier.t
   (**
    * Exception for reporting prettier errors from tests.  Unlike other
    * exceptions, the unit test framework just prints the document
    * contained by a {Failure} exception with a dot at the end.
    *)

   val that : Bool.t Effect.t
   (** Verifies that the given value is {true}. *)

   val thatNot : Bool.t Effect.t
   (** Verifies that the given value is {false}. *)

   val thatEq : ('a, 'x) Rep.t -> {actual : 'a, expect : 'a} Effect.t
   (** Verifies that the expected and actual values are equal. *)

   val thatRaises' : Exn.t Effect.t -> 'a Thunk.t Effect.t
   val thatRaises : Exn.t UnPr.t -> 'a Thunk.t Effect.t
   (**
    * Verifies that the thunk fails with an exception satisfying the
    * predicate.
    *)

   val thatFails : 'a Thunk.t Effect.t
   (** Verifies that the given thunk fails with an exception. *)
end
