(* Copyright (C) 2008 Vesa Karvonen
 *
 * This code is released under the MLton license, a BSD-style license.
 * See the LICENSE file or http://mlton.org/License for details.
 *)

functor MkParsec (Arg : MK_PARSEC_DOM) :> PARSEC
   where type Sequence.t      = Arg.Sequence.t
   where type Sequence.Elem.t = Arg.Sequence.Elem.t
   where type Sequence.Pos.t  = Arg.Sequence.Pos.t
   where type State.t         = Arg.State.t =
struct
   (* <-- SML/NJ workaround *)
   open TopLevel
   infix  7 *`
   infix  6 +`
   infixr 6 <^> <+>
   infixr 5 <$> <$$> </> <//>
   infix  4 <\ \>
   infixr 4 </ />
   infix  2 >| andAlso
   infixr 2 |<
   infix  1 orElse >>= ->> >>-
   infix  0 & <|>
   infixr 0 -->
   (* SML/NJ workaround --> *)

   open Arg
   open Sequence
   type 'a etaexp_dom = Sequence.t * State.t
   type msg = Sequence.Pos.t
   datatype 'a reply =
      OK   of 'a * 'a etaexp_dom * msg
    | FAIL of msg
   datatype 'a etaexp_cod =
      TASTE of 'a reply Thunk.t
    | EMPTY of 'a reply
   type 'a etaexp = 'a etaexp_dom -> 'a etaexp_cod
   type 'a t = 'a etaexp

   fun get (s, t) = Option.map (fn (e, s) => (e, (s, t))) (Sequence.get s)
   fun pos (s, _) = Sequence.pos s

   fun getState (s, t) = EMPTY (OK (t, (s, t), Sequence.pos s))
   fun setState t (s, _) = EMPTY (OK ((), (s, t), Sequence.pos s))

   fun taste r = TASTE (const r)

   fun parse p s =
       case case p s
             of EMPTY r  => r
              | TASTE th => th ()
        of FAIL p       => INL p
         | OK (x, s, _) => INR (x, s)

   fun fromReader reader (s, t) =
       case reader s
        of SOME (x, s) => taste (OK (x, (s, t), Sequence.pos s))
         | NONE        => EMPTY (FAIL (Sequence.pos s))

   fun fromScan scan = fromReader (scan Sequence.get)

   fun merge m =
    fn OK (x, s, _) => OK (x, s, m)
     | FAIL _       => FAIL m

   fun bindSome m =
    fn EMPTY r  => merge m r
     | TASTE th => th ()

   fun replyNone m =
    fn EMPTY r => EMPTY (merge m r)
     | other   => other

   fun return x s = EMPTY (OK (x, s, pos s))

   fun (xM >>= x2yM) s =
       case xM s
        of EMPTY (FAIL m)       => EMPTY (FAIL m)
         | EMPTY (OK (x, s, m)) => replyNone m (x2yM x s)
         | TASTE th             =>
           TASTE (fn () => case th ()
                            of FAIL m       => FAIL m
                             | OK (x, s, m) => bindSome m (x2yM x s))

   fun zero s = EMPTY (FAIL (pos s))

   fun (p <|> q) s =
       case p s
        of EMPTY (FAIL m) => replyNone m (q s)
         | other          => other

   structure Monad = MkMonadP
     (type 'a monad = 'a t
      val return = return
      val op >>= = op >>=
      val zero = zero
      val op <|> = op <|>)

   open Monad

   fun guess p s =
       case p s
        of EMPTY r  => EMPTY r
         | TASTE th => case th ()
                        of FAIL _ => EMPTY (FAIL (pos s))
                         | result => taste result

   fun elem s =
       case get s
        of NONE        => EMPTY (FAIL (pos s))
         | SOME (c, s) => taste (OK (c, s, pos s))

   local
      fun mk isZero zero plus finish req1 q p s = let
         fun ok v s = OK (finish v, s, pos s)
         fun done v =
             if isZero v
             then EMPTY o (if req1 then FAIL o pos else ok v)
             else taste o ok v
         fun step p es s =
             case get s
              of NONE        => done es s
               | SOME (e, t) => if p e then body (plus (e, es)) t else done es s
         and body es = step p es
      in
         case q
          of NONE   => body zero s
           | SOME q => step q zero s
      end
      val mkMany = mk null [] op :: rev
      val mkSkip = mk id true (const false) General.ignore
   in
      val many1Satisfy = mkMany true NONE
      val many1Satisfy2 = mkMany true o SOME
      val manySatisfy = mkMany false NONE
      val manySatisfy2 = mkMany false o SOME
      val skipMany1Satisfy = mkSkip true NONE
      val skipMany1Satisfy2 = mkSkip true o SOME
      val skipManySatisfy = mkSkip false NONE
      val skipManySatisfy2 = mkSkip false o SOME
   end

   fun sat p s =
       case get s
        of NONE         => EMPTY (FAIL (pos s))
         | SOME (c, s') =>
           if p c then taste (OK (c, s', pos s')) else EMPTY (FAIL (pos s))

   fun peek p s =
       case p s
        of EMPTY (OK (x, _, m)) => EMPTY (OK (x, s, m))
         | EMPTY (FAIL m)       => EMPTY (FAIL m)
         | TASTE th             => case th ()
                                    of OK (x, _, m) => taste (OK (x, s, m))
                                     | FAIL m       => taste (FAIL m)

   fun foldMany g f s p = let
      fun lp s = p >>= (fn x => lp (f (x, s))) <|> (fn ? => return (g s) ?)
   in
      lp s
   end

   fun manyRev p = foldMany id op :: [] p
   fun many p = foldMany rev op :: [] p

   fun oneMany p q = p >>= (fn x => foldMany rev op :: [x] q)

   fun many1 p = oneMany p p

   val op ->> = op >>
   fun p >>- s = p >>= (fn x => map (const x) s)

   fun between b a p = b ->> (p >>- a)

   fun foldCount g f s p n = let
      fun lp s n =
          if 0 < n
          then p >>= (fn x => lp (f (x, s)) (n-1))
          else return (g s)
   in
      if n < 0 then raise Domain else lp s n
   end

   fun count p = foldCount rev op :: [] p

   fun skip p = map General.ignore p
   fun skipCount p = foldCount General.ignore General.ignore () p
   fun skipMany p = skipMany1 p <|> return ()
   and skipMany1 p = p >>= (fn _ => skipMany p)

   fun option alt p = p <|> return alt
   fun opt p = option NONE (map SOME p)
   fun optional p = skip p <|> return ()

   fun endBy p = many o p <\ op >>-
   fun endBy1 p = many1 o p <\ op >>-

   fun sepBy1 p s = oneMany p (s ->> p)
   fun sepBy p s = sepBy1 p s <|> return []

   fun sepEndBy' p s = let
      fun done xs ? = return (rev xs) ?
      fun pee xs = p >>= (fn x => ess (x::xs)) <|> done xs
      and ess xs = s >>= (fn _ => pee xs) <|> done xs
   in
      pee
   end

   fun sepEndBy p s = sepEndBy' p s []

   fun sepEndBy1 p s =
       p >>= (fn x => s >>= (fn _ => sepEndBy' p s [x]) <|> return [x])
end
