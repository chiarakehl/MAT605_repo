import Data.Char (toLower)

{-
----------------------------------------------------------------------------------------------------
Exercise 2
----------------------------------------------------------------------------------------------------
-}

-- fl :: [Double] -> [Int] that floors (rounds down) each number in a list.
fl :: [Double] -> [Int]
fl xs = [floor x | x <- xs]

floor' :: [Double] -> [Int]
floor' = map floor

floor'' :: [Double] -> [Int]
floor'' [] = []
floor'' (x : xs) = floor x : floor'' xs

-- d11 :: Int -> Bool that takes a number and checks if it is divisible by 11
d11 :: Int -> Bool
d11 x = (x `mod` 11) == 0

-- toLowerCase :: String -> String that converts a string to lower case.
toLowerCase :: String -> String
toLowerCase str = [toLower x | x <- str]

-- (according to hoogle, toLower is included in the base package, i had to import Data.Char to actually use it though)

{-
----------------------------------------------------------------------------------------------------
Exercise 3
----------------------------------------------------------------------------------------------------
-}

map' :: (a -> b) -> [a] -> [b]
map' f as = [f a | a <- as]

{-
----------------------------------------------------------------------------------------------------
Exercise 4
----------------------------------------------------------------------------------------------------
-}

filter' :: (Eq a) => (a -> Bool) -> [a] -> [a]
filter' p xs = [x | x <- xs, p x]

{-
----------------------------------------------------------------------------------------------------
Exercise 5
----------------------------------------------------------------------------------------------------
-}

-- i. i :: (a,b) -> (b,a)
i :: (a, b) -> (b, a)
i (a, b) = (b, a)

-- ii. ii :: a -> (a -> b) -> b
ii :: a -> (a -> b) -> b
ii x f = f x

-- iii. iii :: (a -> b) -> (b -> c) -> a -> c
iii :: (a -> b) -> (b -> c) -> a -> c
iii f g x = g (f x)

compose :: (a -> b) -> (b -> c) -> a -> c
compose f g x = g $ f x -- in place of brackets, means it needs to evaluate everything on the right first

compose' :: (a -> b) -> (b -> c) -> a -> c
compose' f g = g . f

{-
----------------------------------------------------------------------------------------------------
Exercise 6
----------------------------------------------------------------------------------------------------

i. f :: Eq a => a -> [a] -> Bool => hoogle: elem, notElem
    - a function that checks if every element of a list is >, >=,  to some a
        - f a xs = length [x | x <- xs, x > a] = length xs
    - a function that checks if a is contained in a list (unnecessary because elem exists, but fits the exercise)
        - f a xs = length [x | x <- xs, x = a] > 0

ii. g :: (a -> b) -> [a] -> [b] => hoolge: map, fmap
    - a function like in exercise 3
        - g (*3) [list]
        - g (+6) [list]

iii. h :: Ord a => [a] -> [a]   => hoogle: sort
    - a function that filters a list based on some order relation (<, >, =, >=, <=)
        - h xs = [x | x <- xs, x > minimum xs] (defined for any type in Ord)
        - h xs = [x | x <- xs, x == maximum xs]

-}
