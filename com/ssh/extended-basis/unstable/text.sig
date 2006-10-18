(* Copyright (C) 2006 SSH Communications Security, Helsinki, Finland
 *
 * MLton is released under a BSD-style license.
 * See the file MLton-LICENSE for details.
 *)

(**
 * Extended {TEXT} signature.
 *)

signature TEXT =
   sig
      structure Char            : CHAR
      structure CharArray       : MONO_ARRAY
      structure CharArraySlice  : MONO_ARRAY_SLICE
      structure CharVector      : MONO_VECTOR
      structure CharVectorSlice : MONO_VECTOR_SLICE
      structure String          : STRING
      structure Substring       : SUBSTRING
      sharing type Char.char
                 = CharArray.elem
                 = CharArraySlice.elem
                 = CharVector.elem
                 = CharVectorSlice.elem
                 = String.char
                 = Substring.char
      sharing type Char.string
                 = CharArray.vector
                 = CharArraySlice.vector
                 = CharVector.vector
                 = CharVectorSlice.vector
                 = String.string
                 = Substring.string
      sharing type CharArray.array
                 = CharArraySlice.array
      sharing type CharArraySlice.vector_slice
                 = CharVectorSlice.slice
   end
