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

boolToCool x
    | x == True