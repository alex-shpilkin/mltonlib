(* Copyright (C) 2006 SSH Communications Security, Helsinki, Finland
 *
 * This code is released under the MLton license, a BSD-style license.
 * See the LICENSE file or http://mlton.org/License for details.
 *)

(** == Implementation independent extensions == *)

signature ARRAY = ARRAY
signature ARRAY_SLICE = ARRAY_SLICE
signature BIN_OP = BIN_OP
signature BIN_PR = BIN_PR
signature BOOL = BOOL
signature BUFFER = BUFFER
signature CHAR = CHAR
signature CMP = CMP
signature EFFECT = EFFECT
signature EMB = EMB
signature EXIT = EXIT
signature EXN = EXN
signature FIX = FIX
signature FN = FN
signature INTEGER = INTEGER
signature INT_INF = INT_INF
signature ISO = ISO
signature ISO = ISO
signature LIST = LIST
signature MONO_ARRAY = MONO_ARRAY
signature MONO_ARRAY_SLICE = MONO_ARRAY_SLICE
signature MONO_VECTOR = MONO_VECTOR
signature MONO_VECTOR_SLICE = MONO_VECTOR_SLICE
signature OPTION = OPTION
signature ORDER = ORDER
signature PAIR = PAIR
signature PRODUCT = PRODUCT
signature PRODUCT_TYPE = PRODUCT_TYPE
signature PROMISE = PROMISE
signature READER = READER
signature REAL = REAL
signature REF = REF
signature SQ = SQ
signature STRING = STRING
signature SUBSTRING = SUBSTRING
signature SUM = SUM
signature TEXT = TEXT
signature THUNK = THUNK
signature TIE = TIE
signature UNIT = UNIT
signature UNIV = UNIV
signature UN_OP = UN_OP
signature UN_PR = UN_PR
signature VECTOR = VECTOR
signature VECTOR_SLICE = VECTOR_SLICE
signature WITH = WITH
signature WORD = WORD
signature WRITER = WRITER

structure Univ : UNIV = Univ
structure Vector : VECTOR = Vector
structure Writer : WRITER = Writer
structure With : WITH = With

structure Array : ARRAY = Array
structure ArraySlice : ARRAY_SLICE = ArraySlice
structure BinOp : BIN_OP = BinOp
structure BinPr : BIN_PR = BinPr
structure Bool : BOOL = Bool
structure Buffer : BUFFER = Buffer
structure Char : CHAR = Char
structure CharArray : MONO_ARRAY = CharArray
structure CharArraySlice : MONO_ARRAY_SLICE = CharArraySlice
structure CharVector : MONO_VECTOR = CharVector
structure CharVectorSlice : MONO_VECTOR_SLICE = CharVectorSlice
structure Cmp : CMP = Cmp
structure Effect : EFFECT = Effect
structure Emb : EMB = Emb
structure Exit : EXIT = Exit
structure Exn : EXN = Exn
structure Fix : FIX = Fix
structure Fn : FN = Fn
structure Int : INTEGER = Int
structure Iso : ISO = Iso
structure Iso : ISO = Iso
structure LargeInt : INTEGER = LargeInt
structure LargeReal : REAL = LargeReal
structure LargeWord : WORD = LargeWord
structure List : LIST = List
structure Option : OPTION = Option
structure Order : ORDER = Order
structure Pair : PAIR = Pair
structure Position : INTEGER = Position
structure Product : PRODUCT = Product
structure Promise : PROMISE = Promise
structure Reader : READER = Reader
structure Real : REAL = Real
structure Ref : REF where type 'a t = 'a ref = Ref
structure Sq : SQ = Sq
structure String : STRING = String
structure Substring : SUBSTRING = Substring
structure Sum : SUM = Sum
structure Text : TEXT = Text
structure Thunk : THUNK = Thunk
structure Tie : TIE = Tie
structure UnOp : UN_OP = UnOp
structure UnPr : UN_PR = UnPr
structure Unit : UNIT = Unit
structure VectorSlice : VECTOR_SLICE = VectorSlice
structure Word : WORD = Word
structure Word8 : WORD = Word8
structure Word8Array : MONO_ARRAY = Word8Array
structure Word8ArraySlice : MONO_ARRAY_SLICE = Word8ArraySlice
structure Word8Vector : MONO_VECTOR = Word8Vector
structure Word8VectorSlice : MONO_VECTOR_SLICE = Word8VectorSlice