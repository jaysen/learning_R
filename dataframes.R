df <- data.frame()
df
dim(df)

a <- c(5,6,7)
b <- c(10,20,30)
df <- data.frame(a,b)
df
dim(df)
head(df,2)
tail(df,2)
str(df) #structure

mtcars
head(mtcars)
dim(mtcars)
str(mtcars)
summary(mtcars)
names(mtcars) #returns a vector of names 
names(mtcars) <- c("column 1", "column 2") # names vector returns a vector which mutable .. so assign new vector to names(df)
colnames(mtcars)
rownames(mtcars) #don't rely on rownames

names(df) <- new_names_vector

# cbind and rbind
df2 <- data.frame(c(1,2,3),c(10,20,30))
df2 
names(df) <- c("a","b")
df2 
df2 <- rbind(df, c(4,40))
df2
df2 <- cbind(df,c(100,200,300,400))
df2
names(df2) <- c("a","b","c")
df2



### Slicing Dataframes

# Single cell, row or column
col_1 <- c(1,2,3,4)
col_2 <- c(10,15,7,3)
col_3 <- c(TRUE,FALSE,FALSE,FALSE)
df <- data.frame(col_1, col_2, col_3)
df
df[2,1]
df[2,2]
df[3,2]
df[,]
df[2,] # returns the row as a Dataframe
df[,2] # returns the column as a Vector

## Subsets
df[2:3,] #row 2 and 3
df[c(2,4),2:3] # row 2 and 4. columns 2 and 3
mtcars[c(2,7,3,6), ]

## Access columns by name
df$col_1
df$col_1[2]
mtcars$cyl
mtcars$cyl[3]
mtcars$cyl[1:3]


### Filtering Rows by Criteria

mtcars[TRUE,]
mtcars[FALSE,]

df$col_2 >= 10

mtcars$mpg < 20
mpg_20 <- mtcars$mpg < 20
hp_100 <- mtcars$hp < 100

mtcars[mpg_20,]
mtcars[hp_100,]

mtcars[mpg_20 & !hp_100,]

mtcars[mtcars$mpg > 18 & mtcars$cyl ==8,]
mtcars[mtcars$cyl > 1,]
summary(mtcars$mpg)

# Filtering Vectors
mtcars$mpg
mtcars$mpg[mtcars$mpg > 20]

mtcars$disp[mtcars$mpg > 20]

mtcars[mtcars$mpg > 25, c(1,3,2)]
mtcars[mtcars$mpg < 25 & mtcars$cyl <= 4, c(1,3,2)]

mtcars[]


names(mtcars)
# changing names of columns
names(mtcars)[1] <- 'neww'
names(mtcars)[names(mtcars) == 'neww'] <- 'mpg'
names(mtcars)[names(mtcars) == 'vs'] <- 'vs_what?'
names(mtcars)[names(mtcars) == 'vs_what?'] <- 'vs'

mtcars[,names(mtcars) == 'mpg' | names(mtcars) == 'disp']
mtcars[, names(mtcars) %in% c('mpg','disp')]


### Manipulating Dataframes with dplyr 
library(dplyr)
select(mtcars, mpg, cyl, disp, hp, qsec) # select using given columns
select(mtcars, -mpg) #select with columns to drop
mycols <- c("mpg", "cyl", "disp")
select(mtcars, mycols) 
select(mtcars, -mycols) 

select(mtcars, contains('d'))   # select columns that contain 'd'


# RENAME
select(mtcars, mpg, time = qsec)
rename(mtcars, time = qsec)

# FILTER
filter(mtcars, mpg > 20) 
filter(mtcars, mpg > 20, hp > 100)  #multiple conditions
filter(mtcars, mpg > 20 & hp > 100) #equivalent

mtcars$type <- rownames(mtcars)
filter(mtcars, grepl('Mazda|Toyota',type))

# Pipe Operator

mtcars %>% 
    select(mpg,disp,hp,cyl) %>%
    filter(mpg > 15) %>%
    rename(displacement = disp)
