(* Copyright (C) 2006 Stephen Weeks.
 *
 * This code is released under the MLton license, a BSD-style license.
 * See the LICENSE file or http://mlton.org/License for details.
 *)
structure String: STRING = struct

   open Vector

   type 'a elem = Char.t
   type t = Char.t Vector.t
   type 'a t0 = t

   val ofSeq: Char.t Seq.t -> t = ofSeq

   fun toLower s = map (s, Char.toLower)
   fun toUpper s = map (s, Char.toUpper)

   fun hasPrefix (s, s') = String.isPrefix s' s

   val ofWord8Vector = Byte.bytesToString
   val toWord8Vector = Byte.stringToBytes
end

local
   open String
in
   val concat = concat
end
