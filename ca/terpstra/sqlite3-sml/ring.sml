(*
** 2007 February 18
**
** The author disclaims copyright to this source code.  In place of
** a legal notice, here is a blessing:
**
**    May you do good and not evil.
**    May you find forgiveness for yourself and forgive others.
**    May you share freely, never taking more than you give.
**
*************************************************************************
** $Id$
*)
structure Ring :> RING =
   struct
      datatype 'a t = LINK of { prev: 'a t option ref,
                                next: 'a t option ref,
                                value: 'a }
      fun new x = 
         let
            (* Grrr! Why can't I use val rec??? *)
            val prev = ref NONE
            val next = ref NONE
            val self = LINK { value = x, prev = prev, next = next }
            val () = prev := SOME self
            val () = next := SOME self
         in
            self
         end
      
      fun add (pred as LINK { prev=_, next=pn, value=_ }, x) =
         let
            val succ as LINK { prev=sp, next=_, value=_ } = valOf (!pn)
            val self = LINK { value = x, prev = ref (SOME pred), 
                                         next = ref (SOME succ) }
            val () = pn := SOME self
            val () = sp := SOME self
         in
            self
         end
      
      fun remove (self as LINK { prev, next, value=_ }) =
         let
            val pred as LINK { prev=_, next=pn, value=_ } = valOf (!prev)
            val succ as LINK { prev=sp, next=_, value=_ } = valOf (!next)
            val () = pn := SOME succ
            val () = sp := SOME pred
            val () = prev := SOME self
            val () = next := SOME self
         in
            ()
         end
         
      fun fold f a0 (LINK { prev=_, next, value }) =
         let
            fun loop (l, a) =
               case valOf (!l) of LINK { prev=_, next=nl, value=x } =>
               if nl = next then a else
               loop (nl, f (x, a))
         in
            loop (next, f (value, a0))
         end
      
      fun app f = fold (fn (l, ()) => f l) ()
      
      fun get (LINK { prev=_, next=_, value }) = value
      
(*
      fun test (self as LINK { prev, next, value }) =
         let
            val LINK { prev=_, next=pn, value=_ } = valOf (!prev)
            val LINK { prev=sp, next=_, value=_ } = valOf (!next)
         in
           valOf (!pn) = self andalso valOf (!sp) = self andalso pn <> sp
         end
*)
   end
(*
fun check l = List.foldl (fn (l, a) => Ring.test l andalso a) true l
val sum = Ring.fold (fn (x, a) => a + x) 0 

val a = Ring.new 6
val b = Ring.add (2, a)
val c = Ring.add (5, b)
val d = Ring.add (1, a)
val e = Ring.add (3, d)
val f = Ring.add (4, c)
val all = [ a, b, c, d, e, f ]

val () = print ("Sum: " ^ Int.toString (sum f) ^ "\n")

val true = check all
val 21 = sum a
val 21 = sum e

val () = Ring.remove e
val true = check all
val 18 = sum a
val 3 = sum e

val () = Ring.remove e
val true = check all

val () = Ring.remove c
val true = check all
val 13 = sum a
val 3 = sum e

val () = print "Ring works!\n"
*)
