{- 
Arithmetic:
multiplication, division and addition work normally (power works with ^)
brackets are important
** for power returns a float

logical operators:
&& - and
|| - or
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

-- basic functions

doubleMe x = x + x

doubleUs x y = doubleMe x + doubleMe y

doubleSmallNumber x = if x > 100 then x else 2*x
-- naming convention: start lowercase, new word is capitalized

-- strings

seven = "seven"


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

Comprehension

[2 * x | x <- [1,2,3]] goes through all elements of the list and calculates the expression
[x + 5 | x <- [1..20], even x] gives the xs a condition

'a' this is a character
"a" this is a string (list of characters)

['a'] == "a" by definition -> can manipulate strings using list funcitons

-}

add5 xs = [x + 5 | x <- xs, even x] -- returns a list where each even element += 5

isVowel x = x `elem` ['a', 'e', 'i', 'o', 'u']
removeVowels xs = [letter | letter <- xs, not (isVowel letter)]

{-
Tuples

(1 ,'a'), (1, 2, 3) can contain different types

fst - first element
snd - second element
zip [1..5] ['a' .. 'z'] -> returns [(1,'a'),(2,'b'),(3,'c'),(4,'d'),(5,'e')] 

-}

a = zip [1..5] ['a' .. 'z'] -- this stops when the first list ends -> can zip finite and infinite collections


-- List comprehensions can range over several variables ([x+y | x <- [1..3], y <- [1..3]])

-- Exercise: Create a list of triples (a, b, c) where a^2 + b^2 = c^2

pythagorean a b c = a^2 + b^2 == c^2
pyTriple = [(a,b,c) | a <- [0..10], b <- [0..10], c <- [0..10], pythagorean a b c]



-- Chapter 3 (learnyouhaskell) Types / Typeclass

doubleMe' :: Int -> Int -- analogous to defining domain and codomain
doubleMe' x = x + x -- adding ' is a new name -> no overwriting

addUs :: Int -> (Int -> Int) -- uses both integers (right = output, separate each input type with an arrow) kind of iterates through a function of functions (fix x, evaluate f(x,_) for all y -> returns f(x,y) so R -> (R -> R))
addUs x y = x + y

doubleMe'' :: Num a => a -> a -- type class num, can take any type, conserves it
doubleMe'' x = x + x


{-
types

numbers: Int, Integer, Float, Double (int is bounded (has a laaarge maximum), Integer unbound)
pi is a constant -> pi Float has lesser precision compared to pi Double (more Nachkommastellen)
Bool (T/F)
Char ('a')
String ("hi" == ['h', 'i'])
List ([1,2,3] :: [Int]) i.e. list of integers
Tuples ((1, 'a') :: (Int, Char))
Function types: (a -> b)

:t 'a' returns 'a' :: Char -> :t returns the type of something



-}

--------------------------------------------------------------------------------------------------

{-
Types and Typeclasses

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


Typeclasses:

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


