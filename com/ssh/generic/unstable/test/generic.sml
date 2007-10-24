(* Copyright (C) 2007 SSH Communications Security, Helsinki, Finland
 *
 * This code is released under the MLton license, a BSD-style license.
 * See the LICENSE file or http://mlton.org/License for details.
 *)

(* WARNING: This file was generated by running 'Generate-combination.sh' script as:
 *
 *> Generate-combination.sh test.mlb test/generic.sml
 *)

signature Generic = sig
   include Generic DATA_REC_INFO
end

functor MkGeneric (Arg : Generic) = struct
   structure Open = MkGeneric (Arg)
   open Arg Open
   structure DataRecInfoRep = Open.Rep
end

structure Generic =
   MkGeneric (structure Open = WithDataRecInfo (Generic)
              open Generic Open)

signature Generic = sig
   include Generic SOME
end

functor MkGeneric (Arg : Generic) = struct
   structure Open = MkGeneric (Arg)
   open Arg Open
   structure SomeRep = Open.Rep
end

structure Generic =
   MkGeneric (structure Open = WithSome (Generic)
              open Generic Open)

signature Generic = sig
   include Generic PICKLE
end

functor MkGeneric (Arg : Generic) = struct
   structure Open = MkGeneric (Arg)
   open Arg Open
   structure PickleRep = Open.Rep
end

structure Generic =
   MkGeneric (structure Open = WithPickle (Generic)
              open Generic Open)

signature Generic = sig
   include Generic SEQ
end

functor MkGeneric (Arg : Generic) = struct
   structure Open = MkGeneric (Arg)
   open Arg Open
   structure SeqRep = Open.Rep
end

structure Generic =
   MkGeneric (structure Open = WithSeq (Generic)
              open Generic Open)

signature Generic = sig
   include Generic REDUCE
end

functor MkGeneric (Arg : Generic) = struct
   structure Open = MkGeneric (Arg)
   open Arg Open
   structure ReduceRep = Open.Rep
end

structure Generic =
   MkGeneric (structure Open = WithReduce (Generic)
              open Generic Open)

signature Generic = sig
   include Generic TRANSFORM
end

functor MkGeneric (Arg : Generic) = struct
   structure Open = MkGeneric (Arg)
   open Arg Open
   structure TransformRep = Open.Rep
end

structure Generic =
   MkGeneric (structure Open = WithTransform (Generic)
              open Generic Open)

signature Generic = sig
   include Generic FMAP
end

functor MkGeneric (Arg : Generic) = struct
   structure Open = MkGeneric (Arg)
   open Arg Open
   structure FmapRep = Open.Rep
end

structure Generic =
   MkGeneric (structure Open = WithFmap (Generic)
              open Generic Open)

structure Generic = struct
   structure Rep = ClosePrettyWithExtra
     (open Generic
      structure PrettyRep = Open.Rep)
   open Generic Rep
end

local structure ? = RegBasisExns (Generic) open ? in end
