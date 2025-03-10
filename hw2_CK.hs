{-
-------------------------------------------------------------------------------------------------------------------
Exercise 1
-------------------------------------------------------------------------------------------------------------------
-}

-- Implement map' :: (a -> b) -> [a] -> [b] using pattern matching
map' :: (a -> b) -> [a] -> [b]
map' f xs = [f a | a <- xs]

{-
-------------------------------------------------------------------------------------------------------------------
Exercise 2
-------------------------------------------------------------------------------------------------------------------
-}

-- Implement filter' :: (a -> Bool) -> [a] -> [a] using pattern matching.
filter' :: (a -> Bool) -> [a] -> [a]
filter' f as = [a | a <- as, f a]

{-
--------------------------------------------------------------------------------------------------------------------
Exercise 3
--------------------------------------------------------------------------------------------------------------------
-}

-- (i) zip' :: [a] -> [b] -> [(a, b)], which takes two list and produces a list of pairs, starting from the left.
zip' :: [a] -> [b] -> [(a, b)]
zip' [] _ = []
zip' _ [] = []
zip' (a : as) (b : bs) = (a, b) : zip' as bs

-- (ii) zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c], which takes a function and two lists, and applies the
-- function to each pair of elements in the lists, starting from the left.
zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' f as bs = [f a b | (a, b) <- zip' as bs]

-- (iii) A function scalarProd :: (Num a) => [a] -> [a] -> a that returns the scalar product of two lists of numbers.
scalarProd :: (Num a) => [a] -> [a] -> a
scalarProd [a] [] = 0
scalarProd [a] [b] = a * b
scalarProd as bs = head (zipWith' (*) as bs) + scalarProd (tail as) (tail bs)

{-
--------------------------------------------------------------------------------------------------------------------
Exercise 4
--------------------------------------------------------------------------------------------------------------------
-}

-- Implement flatten' :: [[a]] -> [a], that flattens a list of lists
flatten' :: [[a]] -> [a]
flatten' [[]] = []
flatten' xss = [x | xs <- xss, x <- xs]

{-
--------------------------------------------------------------------------------------------------------------------
Exercise 5
--------------------------------------------------------------------------------------------------------------------
-}

-- Implement a function doubleEveryOther :: [Integer] -> [Integer], that doubles every second element of a list of
-- integers, starting from the left.
doubleEveryOther :: [Integer] -> [Integer]
doubleEveryOther [] = []
doubleEveryOther [x, y] = [2 * x, y]
doubleEveryOther (x : y : ints) = 2 * x : y : doubleEveryOther ints

{-
--------------------------------------------------------------------------------------------------------------------
Exercise 5
--------------------------------------------------------------------------------------------------------------------
-}

-- Implement a function toDigits :: Integer -> [Integer], that takes an integer and returns a list of its digits.
-- For example, toDigits 123 = [1,2,3]. It should return an empty list if the number is zero or negative
