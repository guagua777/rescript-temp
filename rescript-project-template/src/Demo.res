Console.log("Hello, World!")

let a = 1

let add1 = n => n + 1

let rec fib = n =>
  switch n {
  | 0 | 1 => n
  | n => fib(n - 1) + fib(n - 2)
  }

Js.log(fib(10))

let add = (a, b) => a + b
Js.log(add(1, 5))
//Js.log(add(1, "hello"))

let addInt = (a, b) => a + b
let addFloat = (a, b) => a +. b
let addString = (a, b) => a ++ b

Js.log(addInt(1, 3))
Js.log(addFloat(1., 5.2))
Js.log(addString("hello", " world"))

let longStr = "hello world,"
let shortStr = Js.String.slice(~from=2, ~to_=5, longStr)
let shortStr2 = Js.String.slice(~from=0, ~to_=-1, longStr)

Js.log(shortStr)
Js.log(shortStr2)

Js.log("=======================")

//When you create a new record value,
//ReScript tries to find a record type declaration that conforms to the shape of the value
// type org = {
//   mutable name: string,
//   age: int,
// }

type org = {
  name: string,
  age: int,
}

let idea = {
  name: "idea",
  age: 4,
}

Js.log(idea.name)

let immutable_a = 1
//immutable_a =2;

let newIdea = {
  ...idea,
  name: "newidea",
}

Js.log(newIdea.name)

// 底层也是一个record
let myValue = ref(5)
let five = myValue.contents

myValue.contents = 6
myValue := 6

let six = myValue.contents

Js.log(six)

// 模式匹配
let verifyName = ideaRecord =>
  switch ideaRecord {
  | {name: "idea", _} => Js.log("idea")
  | _ => Js.log("other....")
  }

let _ = verifyName(idea)
let _ = verifyName(newIdea)

// list
let myList = list{1, 2, 3}
// switch 大法
let message = switch myList {
| list{} => "this is empty"
| list{head, ..._} => "head is " ++ Js.Int.toString(head)
}
Js.log(message)

let rec printList = list => {
  switch list {
  | list{} => ()
  | list{hd, ...tail} => {
      Js.log(hd)
      printList(tail)
    }
  }
}

printList(myList)

let _ = printList(myList)

let anotherList = list{0, ...myList}

printList(myList)
printList(anotherList)

// 数组array
let myArray = ["hello", "world", "how are you"]
Js.log(myArray[0])

//list是表示and的情况
//variant是表示or的情况

type status = Succ | Fail(string) | Maybe(int)

// let handleStatus = st => {
//   if st == Succ {
//     "nice"
//   } else if st == Fail {
//     "take a look"
//   } else {
//     "try again"
//   }
// }

// Js.log(handleStatus(Succ))

// let matchStatus = st => {
//   switch st {
//   | Succ => "nice"
//   | Fail => "take a look"
//   | Maybe => "try again"
//   }
// }

// Js.log(matchStatus(Fail))

let matchStatus = st => {
  switch st {
  | Succ => "nice"
  | Fail(msg) => msg
  | Maybe(n) => `Try ${Belt.Int.toString(n)} times`
  }
}

Js.log(matchStatus(Maybe(3)))
Js.log(matchStatus(Fail("permission error")))

// loop
for i in 0 to 3 {
  Js.log(i)
}

for i in 3 downto 0 {
  Js.log(i)
}

let break = ref(false)

while !break.contents {
  if Js.Math.random() > 0.3 {
    // 使用可变绑定进行中断 mutable binding
    break := true
  } else {
    Js.log("Still running")
  }
}

// FUNCTION
// 使用let来定义函数
let add1 = n => n + 1

//labeled arguments
// 带标签的参数名
let addCoordinates = (~x, ~y) => {
  let r = x + y
  Js.log(r)
}
// ...
addCoordinates(~x=5, ~y=6)
addCoordinates(~y=5, ~x=6)

let addCoor = (~x, ~y) => {
  `x point : ${Belt.Int.toString(x)}, y is ${Belt.Int.toString(y)}`
}

Js.log(addCoor(~y=10, ~x=11))

//currying
let add = (a, b) => a + b
let add1 = add(1)
Js.log(add1)

//recursive
let rec listHas = (lst, item) => {
  switch lst {
  | list{} => false
  | list{head, ...tail} =>
    if head == item {
      true
    } else {
      listHas(tail, item)
    }
  }
}

Js.log(listHas(list{1, 2, 3, 4}, 3))
Js.log(listHas(list{1, 2, 3, 4}, 5))

//mutually recersive
// 完全就是sml的语法
let rec is_even = x => {
  if x == 0 {
    true
  } else {
    is_odd(x - 1)
  }
}
and is_odd = x => {
  if x == 0 {
    false
  } else {
    is_even(x - 1)
  }
}

Js.log(is_even(5))

// 原来从数学到程序语言是很自然的事情
let add = (a, b) => a + b
let add1 = add(1)
let add10 = add(10)
let add100 = add(100)
let sum1 = add100(add10(add1(5)))

Js.log(sum1)

let sum2 = 5->add1->add10->add100
Js.log(sum2)

//modules
//res建议每一个文件名首字母都大写
// js里面会var Aux = require("./Aux.bs.js");
let n = Aux.module_add(2, 3)

// 通过文件或者是modules来进行模块化

module Helper = {
  let mul = (a, b) => a * b
}

let x = Helper.mul(3, 4)

Js.log(x)
