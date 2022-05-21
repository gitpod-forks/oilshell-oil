# spec/oil-for

#### For loop over expression: list
var mylist = [1, 2, 3]
for item in (mylist) {
  echo "item $item"
}

## STDOUT:
item 1
item 2
item 3
## END

#### For loop over expression: dict

var mydict = {name: 'bob', age: 40}
for key in (mydict) {
  echo "key $key"
} | sort  # TODO: Fix iteration order


## STDOUT:
key age
key name
## END


#### For loop over expression: range (low priority)
var myrange = 0:3
for i in (myrange) {
  echo "i $key"
}

## STDOUT:
i 0
i 1
i 2
## END

#### Shell for loop with index (equivalent of enumerate())
for i item in a b c {
  echo $i $item
}
## STDOUT:
0 a
1 b
2 c
## END

#### Shell for loop can't have 3 indices 
for i bad bad in a b c {
  echo $i $item
}
## status: 2

#### Expression for loop with index: list
for i item in (['spam', 'eggs']) {
  echo "$i $item"
}
## STDOUT:
0 spam
1 eggs
## END

#### Expression for loop with index: dict
for key value in ({name: 'bob', age: 40}) {
  echo "pair $key $value"
}
## STDOUT:
pair name bob
pair age 40
## END

#### dict: index key value loop
for i key value in ({name: 'bob', age: 40}) {
  echo "entry $i $key $value"
}
## STDOUT:
entry 0 name bob
entry 1 age 40
## END

#### Equivalent of zip()

var array = %(1 2 3)

for i item in a b c {
  echo $i $item
  echo $[array[i]]
}

## STDOUT:
1 a
2 b
3 c
## END


#### Iterate over shell data structures

# TODO: use new style

declare array=(one two three)
for item in (array) {
  echo $item
}

echo ---

declare -A A=([k]=v [k2]=v2)  # iterate over keys
for key in (A) {
  echo $key
} | sort
## STDOUT:
one
two
three
---
k
k2
## END



#### parse_unquoted eliminates confusion

shopt --unset parse_unquoted

var mylist = ['foo', 'bar']

for x in mylist {
  echo BAD $x
}

shopt --set parse_unquoted

for x in (mylist) {
  echo $x
}

for x in 'mylist' {
  echo OK $x
}

## STDOUT:
BAD mylist
foo
bar
OK mylist
## END


#### Object that's not iterable

echo hi
for x in (42) {
  echo $x
}

## status: 3
## STDOUT:
hi
## END