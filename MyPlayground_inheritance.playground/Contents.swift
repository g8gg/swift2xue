//: Playground - noun: a place where people can play

import Cocoa

/**
*  继承（Inheritance）
*/
//一个类可以继承(inherit)另一个类的方法(methods),属性(properties)和其它特性。
//当一个类继承其它 类时,继承类叫子类(subclass),被继承类叫超类(或父类,superclass)
//在 Swift 中,继承是区 分「类」与其它类型的一个基本特征。
// Swift 中,类可以调用和访问超类的方法,属性和下标脚本(subscripts),并且可以重写(override)这些 方法,属性和下标脚本来优化或修改它们的行为。
//Swift 会检查你的重写定义在超类中是否有匹配的定义,以此确 保你的重写行为是正确的。
//可以为类中继承来的属性添加属性观察器(property observers),这样一来,当属性值改变时,类就会被通知 到。可以为任何属性添加属性观察器,无论它原本被定义为存储型属性(stored property)还是计算型属性(computed property)。



//定义一个基类(Base class)
//不继承于其它类的类,称之为基类(base calss)
//注意:
//Swift 中的类并不是从一个通用的基类继承而来。如果你不为你定义的类指定一个超类的话,这个类就自动成为 基类。
class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        // 什么也不做-因为车辆不一定会有噪音
    }
}
let someVehicle = Vehicle()
print("Vehicle: \(someVehicle.description)")

//Vehicle 类定义了一个通用特性的车辆类,实际上没什么用处。为了让它变得更加有用,需要改进它能够描述一 个更加具体的车辆类。

//子类生成(Subclassing)
//子类生成(Subclassing)指的是在一个已有类的基础上创建一个新的类。子类继承超类的特性,并且可以优化 或改变它。你还可以为子类添加新的特性。
class Bicycle: Vehicle {
    var hasBasket = false
}
let bicycle = Bicycle()
bicycle.hasBasket = true
bicycle.currentSpeed = 15.0
print("Bicycle: \(bicycle.description)")

//子类还可以继续被其它类继承,下面的示例为 ￼ 创建了一个名为Tandem(双人自行车)的子类
class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}

let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 22.0
print("Tandem: \(tandem.description)")

//重写(Overriding)
//子类可以为继承来的实例方法(instance method),类方法(class method),实例属性(instance proper ty),或下标脚本(subscript)提供自己定制的实现(implementation)。我们把这种行为叫重写(overridin g)。

//如果要重写某个特性,你需要在重写定义的前面加上 ￼ 关键字。这么做,你就表明了你是想提供一个重写 版本,而非错误地提供了一个相同的定义。意外的重写行为可能会导致不可预知的错误,任何缺少 ￼ 关键 字的重写都会在编译时被诊断为错误。

//override 关键字会提醒 Swift 编译器去检查该类的超类(或其中一个父类)是否有匹配重写版本的声明。这个检 查可以确保你的重写定义是正确的。

//访问超类的方法,属性及下标脚本
//当你在子类中重写超类的方法,属性或下标脚本时,有时在你的重写版本中使用已经存在的超类实现会大有裨益。比如,你可以优化已有实现的行为,或在一个继承来的变量中存储一个修改过的值。
//在合适的地方,你可以通过使用 super 前缀来访问超类版本的方法,属性或下标脚本:
//1. 在方法 someMethod 的重写实现中,可以通过 super.someMethod() 来调用超类版本的 someMethod 方 法。
//2. 在属性 someProperty 的 getter 或 setter 的重写实现中,可以通过 super.someProperty 来访问超类版本 的 someProperty 属性。
//3. 在下标脚本的重写实现中,可以通过 super[someIndex] 来访问超类版本中的相同下标脚本。


//重写方法
//在子类中,你可以重写继承来的实例方法或类方法,提供一个定制或替代的方法实现。
class Train: Vehicle {
    override func makeNoise() {
        print("Choo Choo")
    }
}
let train = Train()
train.makeNoise()

//重写属性
//你可以重写继承来的实例属性或类属性,提供自己定制的getter和setter,或添加属性观察器使重写的属性可以观 察属性值什么时候发生改变。
//重写属性的Getters和Setters
//你可以提供定制的 getter(或 setter)来重写任意继承来的属性,无论继承来的属性是存储型的还是计算型的属 性。子类并不知道继承来的属性是存储型的还是计算型的,它只知道继承来的属性会有一个名字和类型。你在重 写一个属性时,必需将它的名字和类型都写出来。这样才能使编译器去检查你重写的属性是与超类中同名同类型 的属性相匹配的。
//你可以将一个继承来的只读属性重写为一个读写属性,只需要你在重写版本的属性里提供 getter 和 setter 即 可。但是,你不可以将一个继承来的读写属性重写为一个只读属性。
/**
*  注意:
如果你在重写属性中提供了 setter,那么你也一定要提供 getter。如果你不想在重写版本中的 getter 里修改继 承来的属性值,你可以直接通过 super.someProperty 来返回继承来的值,其中 someProperty 是你要重写的 属性的名字。
*/

//以下的例子定义了一个新类,叫 Car ,它是 Vehicle 的子类。这个类引入了一个新的存储型属性叫做 gear ,默 认为整数1。 Car 类重写了继承自 Vehicle 的description属性,提供自定义的,包含当前档位的描述:
class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + " in gear \(gear)" }
}
let car = Car()
car.currentSpeed = 25.0
car.gear = 3
print("Car: \(car.description)")

//重写属性观察器(Property Observer)
//你可以在属性重写中为一个继承来的属性添加属性观察器。这样一来,当继承来的属性值发生改变时,你就会被 通知到,无论那个属性原本是如何实现的。
/**
*  注意: 你不可以为继承来的常量存储型属性或继承来的只读计算型属性添加属性观察器。这些属性的值是不可以被设置 的,所以,为它们提供 willSet 或 didSet 实现是不恰当。此外还要注意,你不可以同时提供重写的 setter 和重 写的属性观察器。如果你想观察属性值的变化,并且你已经为那个属性提供了定制的 setter,那么你在 setter 中就可以观察到任何值变化了。
*/
//下面的例子定义了一个新类叫 AutomaticCar ,它是 Car 的子类。 AutomaticCar 表示自动挡汽车,它可以根据 当前的速度自动选择合适的挡位:
class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1 }
    }
}
let automatic = AutomaticCar()
automatic.currentSpeed = 35.0
print("AutomaticCar: \(automatic.description)")

//防止重写
//你可以通过把方法,属性或下标脚本标记为 final 来防止它们被重写,只需要在声明关键字前加上 final 特性即可。(例如: final var , final func , final class func , 以及 final subscript )

//如果你重写了final方法,属性或下标脚本,在编译时会报错。
//在类扩展中的方法,属性或下标脚本也可以在扩展的定义里标记为final。
//你可以通过在关键字class前添加final特性(final class)来将整个类标记为final的,这样的类是不可被继承的,任何子类试图继承此类时,在编译时会报错。
class TestFinal {
    var test = 1.0
    final func testFunc(){
        print("testFunc invoked.")
    }
}

class TestUnit: TestFinal {
    func printTest(){
        print(self.test)
    }
 /*   override func testFunc(){
        //error
    }
    */
}

var myTest = TestUnit()
myTest.printTest()


