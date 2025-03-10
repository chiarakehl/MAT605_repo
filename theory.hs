{-
====================================================================================================
Lecture Week 2
====================================================================================================
-}

{-
----------------------------------------------------------------------------------------------------
Arithmetic
----------------------------------------------------------------------------------------------------
-}

{-
multiplication, division and addition work normally (power works with ^)
brackets are important
\** for power returns a float

logical operators:
&& - and
\|| - or
not - negation

comparison:
==
/=
<=
(5.0 == 5 works, )

force something to have a type (e.g. Int, Float), 5 :: Float
(5 :: Int) == (5 :: Float) runs an error because different types cannot be compared

types aren't automatically adjusted -> very strict with types -> runs a lot of errors

functions can be partially evaluated

convert infix f to prefix by (f)
e.g. 4 + 4 can be converted to (+) 4 4

convert prefix to invix `f`
e.g. 4 `min` 5

elem 5 [2,4,5] checks if 5 is in the list
5 `elem` [2,4,5] also works and might be better

-}

{-
----------------------------------------------------------------------------------------------------
Basic functions
----------------------------------------------------------------------------------------------------
-}

doubleMe :: (Num a) => a -> a
doubleMe x = x + x

doubleUs :: (Num a) => a -> a -> a
doubleUs x y = doubleMe x + doubleMe y

doubleSmallNumber :: (Ord a, Num a) => a -> a
doubleSmallNumber x = if x > 100 then x else 2 * x

-- naming convention: start lowercase, new word is capitalized

-- strings

seven = "seven"

{-
----------------------------------------------------------------------------------------------------
Lists
----------------------------------------------------------------------------------------------------
-}

{-
lists [1, 2, 3], all elements need to have the same type
concatenation ++ combines lists
Cons: (every list [1, 2, 3] == 1 : 2 : 3 : [])

indexing: [1, 2, 3] !! 2 will give 3

head (first element), tail (everything except the first element), last (last elememt), init (initial segment = everything but the last element)
head is an unsafe function (head [] runs an error!)

maximum, minimum, sum, product (e.g. sum [1,4,7]) -> max != maximum, max only works on 2 elements (max 4 2)

elem checks if something is in a list
-}

-- ranges [1..10] integers from 1 to 10
-- [1,4..12] progression in steps of 3, cuts off at the last value <= 12
-- [1..] gives all natural numbers, control + C interrupts
-- haskell is lazy!

-- take 10 [1..] takes the first 10 elements of an infinite set

{-
----------------------------------------------------------------------------------------------------
List Comprehension
----------------------------------------------------------------------------------------------------

[2 * x | x <- [1,2,3]] goes through all elements of the list and calculates the expression
[x + 5 | x <- [1..20], even x] gives the xs a condition

'a' this is a character
"a" this is a string (list of characters)

['a'] == "a" by definition -> can manipulate strings using list funcitons

-}

add5 :: (Integral a) => [a] -> [a]
add5 xs = [x + 5 | x <- xs, even x] -- returns a list where each even element += 5

isVowel :: Char -> Bool
isVowel x = x `elem` ['a', 'e', 'i', 'o', 'u']

removeVowels :: [Char] -> [Char]
removeVowels xs = [letter | letter <- xs, not (isVowel letter)]

a :: [(Integer, Char)]
a = zip [1 .. 5] ['a' .. 'z'] -- this stops when the first list ends -> can zip finite and infinite collections

-- List comprehensions can range over several variables ([x+y | x <- [1..3], y <- [1..3]])

{-
----------------------------------------------------------------------------------------------------
Tuples
----------------------------------------------------------------------------------------------------

(1 ,'a'), (1, 2, 3) can contain different types

fst - first element
snd - second element
zip [1..5] ['a' .. 'z'] -> returns [(1,'a'),(2,'b'),(3,'c'),(4,'d'),(5,'e')]

-}

-- Exercise: Create a list of triples (a, b, c) where a^2 + b^2 = c^2

pythagorean :: (Num a, Eq a) => a -> a -> a -> Bool
pythagorean a b c = a ^ 2 + b ^ 2 == c ^ 2

pyTriple :: [(Integer, Integer, Integer)]
pyTriple = [(a, b, c) | a <- [0 .. 10], b <- [0 .. 10], c <- [0 .. 10], pythagorean a b c]

{-
----------------------------------------------------------------------------------------------------
Types
----------------------------------------------------------------------------------------------------

numbers: Int, Integer, Float, Double (int is bounded (has a laaarge maximum), Integer unbound)
pi is a constant -> pi Float has lesser precision compared to pi Double (more Nachkommastellen)
Bool (T/F)
Char ('a')
String ("hi" == ['h', 'i'])
List ([1,2,3] :: [Int]) i.e. list of integers
Tuples ((1, 'a') :: (Int, Char))
Function types: (a -> b)

:t 'a' returns 'a' :: Char -> :t returns the type of something

need to always declare types for functions

:t followed by some argument returns the type of the argument (:: indicates the type)

to define the types for a function: function :: type -> type

the right most type is the return, everything to the left is the input type
e.g. addUs Int -> Int -> Int
     addUs x y = x + y

to use arbituary types, we can use a
e.g. doubleMe :: a -> a
     doubleMe x = x + x

this doesn't work because not every type can be added (e.g. string or bool) -> restrict a

doubleMe :: Num a => a -> a (includes int, integer, float, double) this is an example of typeclass constraint

:t (==) returns (==) :: Eq a => a -> a -> Bool (Eq is a typeclass that includes Num)

----------------------------------------------------------------------------------------------------
Typeclasses
----------------------------------------------------------------------------------------------------

-- Eq, Ord  (all types that support equality or order relations, Ord is included in Eq)
-- Show, Read (show includes things that can be converted to strings (?), read converts strings to ints (?))
-- Enum (types that have a successor, i.e. can be enumerated)
-- Num (includes numbers) :t 5 returns Num a not Int
-- Integral, Floating (int or float)

fromIntegral converts ints to

giving multiple type constraints to a function:

fromIntegral :: (Integral a, Num b) => a -> b (converts the int a to some type b that is in Num)

used to convert ints to floats
e.g. (fromIntegral (length [2,4])) / 3 returns 0.666 rather than the error you get by just using length

-}

doubleMe' :: Int -> Int -- analogous to defining domain and codomain
doubleMe' x = x + x -- adding ' is a new name -> no overwriting

addUs :: Int -> (Int -> Int) -- uses both integers (right = output, separate each input type with an arrow) kind of iterates through a function of functions (fix x, evaluate f(x,_) for all y -> returns f(x,y) so R -> (R -> R))
addUs x y = x + y

doubleMe'' :: (Num a) => a -> a -- type class num, can take any type, conserves it
doubleMe'' x = x + x

{-
====================================================================================================
Lecture Week 3
====================================================================================================
-}

doubleMe''' :: (Num a) => a -> a
doubleMe''' x = x + x

{-
----------------------------------------------------------------------------------------------------
Pattern matching
----------------------------------------------------------------------------------------------------
-}

sayNumber :: Int -> String
sayNumber x =
     if x == 1
          then "This is 1"
          else "This is a number"

sayNumber' :: Int -> String
sayNumber' 1 = "This is one"
sayNumber' 2 = "This is two"
sayNumber' x = "This is a number"

-- this is case distinction, it goes from top to bottom, checking if the number is one or two, if not it uses x

sayNumber'' :: Int -> String
sayNumber'' 1 = "This is one"
sayNumber'' 2 = "This is two"
sayNumber'' _ = "This is a number"

-- _ is a place holder

factorial :: Int -> Int
factorial 0 = 1
factorial n = n * factorial (n - 1)

--  this is how you define a recursion
-- for very large n, this becomes weird because Ints are bounded -> use Integer for larger n

factorial' :: Integer -> Integer
factorial' 0 = 1
factorial' n = n * factorial' (n - 1)

addVectors :: (Double, Double) -> (Double, Double) -> (Double, Double)
addVectors x y = (fst x + fst y, snd x + snd y)

addVectors' :: (Double, Double) -> (Double, Double) -> (Double, Double)
addVectors' (x_1, x_2) (y_1, y_2) = (x_1 + y_1, x_2 + y_2)

first :: (x, y, z) -> x
first (x, _, _) = x -- using blanks avoids definition errors (e.g. (x, y, y) wouldn't work because they are assigned different types)

second :: (x, y, z) -> y
second (x, y, z) = y

head' :: [a] -> a
head' [] = error "Empty" -- defines that it should run an error with the defined message
head' (x : xs) = x -- (x : xs) defines a list with the first element x and remaining elements xs (lists are defined as (1:(2:(3:[]))), where ':' appends the elements so x : xs appends x to xs)

unCon :: [a] -> (a, [a])
unCon (x : xs) = (x, xs)

tail' :: [a] -> (a, a)
tail' (x : y : xs) = (x, y)

-- unCon [2,5,6,7] returns (2,[5,6,7])

sayLength :: [a] -> String
sayLength [] = "Zero"
sayLength [x] = "One"
sayLength [x, y] = "Two"
sayLength _ = "More than Two" -- could also use (x:xs) because if it is one or two it stops earlier

sayLength' :: [a] -> String -- this is worse than the other version
sayLength' [] = "Zero"
sayLength' (x : []) = "One"
sayLength' (x : y : []) = "Two"
sayLength' (x : y : _) = "More than Two"

length' :: [a] -> Int -- recursive definition of the length function for lists
length' [] = 0
length' (x : xs) = length' xs + 1

length'' :: [a] -> Int
length'' [] = 0
length'' xs = length'' (tail xs) + 1

sum' :: (Num a) => [a] -> a
sum' [] = 0
sum' (x : xs) = x + sum' xs

sum'' :: (Num a) => [a] -> a -- this is equivalent resp. it is used so often that there is a seperate function
sum'' xs = sum'''' xs

sum''' :: (Num a) => [a] -> a -- this is even shorter
sum''' = sum''''

sum'''' :: (Num a) => [a] -> a -- this is even shorter, still sums up all elements of a list
sum'''' = sum

firstLetter :: String -> String
firstLetter "" = "Empty String"
firstLetter (x : xs) = "The first letter of " ++ (x : xs) ++ " is " ++ [x]

firstLetter' :: String -> String
firstLetter' "" = "Empty String"
firstLetter' s@(x : xs) = "The first letter of " ++ s ++ " is " ++ [x] -- defines s as the entire pattern

-- ++ is concatination of lists -> make one long string because strings are also lists

{-
----------------------------------------------------------------------------------------------------
Guards
----------------------------------------------------------------------------------------------------
-}

grade :: Double -> String
grade p
     | p <= 5 = "Fail"
     | p <= 10 = "C"
     | p <= 15 = "B"
     | otherwise = "A"

abs' :: (Ord a, Num a) => a -> a
abs' x
     | x >= 0 = x
     | x < 0 = -x

dist :: (Ord a, Num a) => a -> a -> a
dist x y
     | (x - y) >= 0 = (x - y)
     | (x - y) < 0 = (y - x)

dist' :: (Ord a, Num a) => a -> a -> a
dist' x y
     | diff >= zero = diff
     | diff < zero = -diff
    where
     diff = x - y
     zero = 0

dist'' :: (Ord a, Num a) => a -> a -> a
dist'' x y = abs' diff
    where
     diff = x - y

{-
----------------------------------------------------------------------------------------------------
Let
----------------------------------------------------------------------------------------------------
-}

cylinder :: Double -> Double -> Double
cylinder r h = 2 * topArea + sideArea
    where
     topArea = pi * r
     sideArea = h * 2 * pi * r

cylinder' :: Double -> Double -> Double
cylinder' r h =
     let
          topArea = pi * r
          sideArea = h * 2 * pi * r
      in
          2 * topArea + sideArea

{-
----------------------------------------------------------------------------------------------------
Case
----------------------------------------------------------------------------------------------------
-}

head'' :: [a] -> a
head'' xs = case xs of
     [] -> error "empty list" -- case (what you use) of (what you match it to)
     (x : xs) -> x

{-
====================================================================================================
Lecture Week 4
====================================================================================================
-}