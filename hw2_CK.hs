{-
-------------------------------------------------------------------------------------------------------------------
Exercise 1
-------------------------------------------------------------------------------------------------------------------
-}

-- Implement map' :: (a -> b) -> [a] -> [b] using pattern matching (l.c.: map' f xs = [f a | a <- xs])
map' :: (a -> b) -> [a] -> [b]
map' f [] = []
map' f (x : xs) = f x : map' f xs

{-
-------------------------------------------------------------------------------------------------------------------
Exercise 2
-------------------------------------------------------------------------------------------------------------------
-}

-- Implement filter' :: (a -> Bool) -> [a] -> [a] using pattern matching. (filter' f as = [a | a <- as, f a])
filter' :: (a -> Bool) -> [a] -> [a]
filter' p [] = []
filter' p (x : xs) = [x | p x] ++ filter' p xs

filter'' :: (a -> Bool) -> [a] -> [a]
filter'' p [] = []
filter'' p (x : xs)
    | p x = x : filter'' p xs
    | otherwise = filter'' p xs

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
zipWith' f [] _ = []
zipWith' f _ [] = []
zipWith' f (a : as) (b : bs) = f a b : zipWith' f as bs

zipWith'' :: (t1 -> t2 -> a) -> [t1] -> [t2] -> [a] -- uses list comprehension -> not what was asked
zipWith'' f as bs = [f a b | (a, b) <- zip' as bs]

-- f :: (a -> b -> c) is not the same as f' :: ((a,b) -> c)
zipWith''' :: ((a, b1) -> b2) -> [a] -> [b1] -> [b2]
zipWith''' f xs ys = map' f (zip' xs ys)

zipWith'''' :: (a -> b1 -> b2) -> [a] -> [b1] -> [b2]
zipWith'''' f xs ys = map' (uncurry f) (zip' xs ys)

-- (iii) A function scalarProd :: (Num a) => [a] -> [a] -> a that returns the scalar product of two lists of numbers.
scalarProd :: (Num a) => [a] -> [a] -> a
scalarProd [a] [] = 0
scalarProd [a] [b] = a * b
scalarProd (a : as) (b : bs) = a * b + scalarProd as bs -- this works for sets of different sizes...

scalarProd' :: (Num a) => [a] -> [a] -> a
scalarProd' xs ys
    | length xs == length ys = sum (zipWith' (*) xs ys)
    | otherwise = error "Lists must be of the same length"

{-
--------------------------------------------------------------------------------------------------------------------
Exercise 4
--------------------------------------------------------------------------------------------------------------------
-}

-- Implement flatten' :: [[a]] -> [a], that flattens a list of lists
flatten' :: [[a]] -> [a]
flatten' [[]] = []
flatten' xss = [x | xs <- xss, x <- xs]

flatten'' :: [[a]] -> [a]
flatten'' [] = []
flatten'' (x : xs) = x ++ flatten'' xs

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
Exercise 6
--------------------------------------------------------------------------------------------------------------------
-}

-- Implement a function toDigits :: Integer -> [Integer], that takes an integer and returns a list of its digits.
-- For example, toDigits 123 = [1,2,3]. It should return an empty list if the number is zero or negative
toDigits :: Integer -> [Integer]
toDigits n
    | n <= 0 = []
    | otherwise = toDigits firstDigits ++ [lastDigit]
  where
    lastDigit = n `mod` 10
    firstDigits = n `div` 10