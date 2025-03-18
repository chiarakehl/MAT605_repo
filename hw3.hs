import Data.Time.Format.ISO8601 (yearFormat)
import Distribution.Simple.Utils (xargs)

{-
-------------------------------------------------------------------------------------------------------------------
Exercise 1
-------------------------------------------------------------------------------------------------------------------
-}

data CoolBool = Nope | Yup deriving (Show, Eq, Ord)

{-
-------------------------------------------------------------------------------------------------------------------
Exercise 2
-------------------------------------------------------------------------------------------------------------------
-}

boolToCool :: Bool -> CoolBool
boolToCool x
    | x = Yup
    | otherwise = Nope

coolToBool :: CoolBool -> Bool
coolToBool x
    | x == Nope = False
    | otherwise = True

coolToBool' :: CoolBool -> Bool
coolToBool' Yup = True
coolToBool' Nope = False

{-
-------------------------------------------------------------------------------------------------------------------
Exercise 3
-------------------------------------------------------------------------------------------------------------------
-}

coolNot :: CoolBool -> CoolBool
coolNot x
    | x == Nope = Yup
    | otherwise = Nope

coolBoth :: CoolBool -> CoolBool -> CoolBool
coolBoth Yup Yup = Yup
coolBoth _ _ = Nope

coolEither :: CoolBool -> CoolBool -> CoolBool
coolEither x y
    | x == Yup = Yup
    | y == Yup = Yup
    | otherwise = Nope

coolEither' :: CoolBool -> CoolBool -> CoolBool
coolEither' Nope Nope = Nope
coolEither' _ _ = Yup

{-
-------------------------------------------------------------------------------------------------------------------
Exercise 4
-------------------------------------------------------------------------------------------------------------------
-}

coolAnd :: [CoolBool] -> CoolBool
coolAnd [] = Yup
coolAnd [Yup] = Yup
coolAnd (x : xs)
    | x == Yup = coolAnd xs
    | otherwise = Nope

coolOr :: [CoolBool] -> CoolBool
coolOr [] = Nope
coolOr [Yup] = Yup
coolOr (x : xs)
    | x == Nope = coolOr xs
    | otherwise = Yup

{-
-------------------------------------------------------------------------------------------------------------------
Exercise 5
-------------------------------------------------------------------------------------------------------------------
-}

coolElem :: (Eq a) => a -> [a] -> CoolBool
coolElem y [] = Nope
coolElem y (x : xs)
    | y == x = Yup
    | coolToBool (coolElem y xs) = Yup
    | otherwise = Nope

coolElem' e [] = Nope
coolElem' e (x : xs)
    | e == x = Yup
    | otherwise = coolElem' e xs

{-
-------------------------------------------------------------------------------------------------------------------
Exercise 6
-------------------------------------------------------------------------------------------------------------------
-}

coolAll :: (a -> CoolBool) -> [a] -> CoolBool
coolAll p [] = Yup
coolAll p (x : xs)
    | p x == Nope = Nope
    | otherwise = coolAll p xs

coolAny :: (a -> CoolBool) -> [a] -> CoolBool
coolAny p [] = Nope
coolAny p (x : xs)
    | p x == Yup = Yup
    | otherwise = coolAny p xs
