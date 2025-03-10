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
scalarProd [] [] = 0
scalarProd as bs = [zipWith' (*) as bs | (a, b)]