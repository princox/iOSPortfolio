## iOS portfolio for developer position


>**Note:** Hi, my name is `Jeong Hoon Rhee`. I'm making some apps for my portfolio.

> This is repository for my portfolio. If you have some issues or ideas just let me know. Thanks.


- [ ] Test-Driven Development(켄트 벡) 책 읽고 정리
- [ ] Refactoring(마틴 파울러) 책 읽고 정리
- [ ] Core image
- [ ] Core data
- [ ] Parse
- [ ] How to do TDD with Xcode (Testing tool practice)
- [ ] Protocol, Initialization, Extension 복습
- [ ] 
http://swift.leantra.kr/#initialization

면접질문 : 
https://soooprmx.com/archives/6442
https://www.hooni.net/xe/freetalk/65106

### Test-Driven Development (Kent Beck)
**테스트 주도 개발의 2가지 원칙** :  
- 오직 자동화된 테스트가 실패할 경우만 새로운 코드를 작성한다.
- 중복을 제거한다. 

이 두 가지 원칙에 의해서 프로그래밍 작성 순서는 이렇게 한다.
1. 빨강(Red light) - 실패하는 작은 테스트를 작성한다. 처음에는 컴파일조차 되지 않을 수 있다.
2. 초록 - 빨리 테스트가 통과하게끔 만든다. 이를 위해서 복사 붙여넣기, 무조건 특정 상수 끼워넣기 등의 죄악을 저질러도 좋다.
3. 리팩토링 - 일단 테스트를 통과하게만 하는 와중에 생겨난 모든 중복을 제거한다.

일단 테스트 하나를 작동하게 되면 앞으로도 영원히 작동할 거라 알 수 있다. 그 다음 테스트를 작동하게 하고 그 다음, 또 다음 계속 작은 부분을 커버하며 톱니바퀴의 바퀴처럼 작동하게 해야한다.

하지만 TDD로는 보안 소프트웨어, 동시성(concurrency) 등은 해결하기 어렵다.

이 책의 목표는 **단순하게 시작하고 - 자동화된 테스트를 만들고 - 새로운 설계 결정을 한 번에 하나씩 도입하기 위해 리팩토링을 하는 것**이다.

테스트 주도 개발 방법론은 테스트를 통해서 이 기능을 구현할 수 있다는 자신감을 불어 넣어주고 위에서 말한 2가지 원칙을 구현하는 과정에서 프로그래머의 잠재력을 한껏 발휘할 수 있다.

이 책에서는 화폐 예제를 통해서 TDD의 과정을 경험한다.
1. 재빨리 테스트를 하나 추가한다.
2. 모든 테스트를 실행하고 새로 추가한 것이 실패하는 지 확인한다.
3. 코드를 조금 바꾼다.
4. 모든 테스트를 실행하고 전부 성공하는지 확인한다.
5. 리팩토링을 통해 중복을 제거한다.


다중 통화를 지원하는 Money 객체부터 시작한다.

다음과 같은 보고서가 있다고 하자.

| 종목  |  주 |  가격 |  합계 |
|:--|--:|--:|--:|
|  IBM | 1000  | 25  | 25000  |
| GE  | 400  | 100 | 40000  |
|   |   | 합계  |  65000 |



다중 통화를 지원하는 보고서를 만들려면 통화 단위를 추가해야한다.


| 종목  |  주 |  가격 |  합계 |
|:-|-:|-:|-:|
|  IBM | 1000  | 25USD  | 25000USD  |
| Novartis  | 400  | 150CHF | 6000CHF  |
|   |   | 합계  |  65000USD |

또한 환율도 명시해야한다.

| 기준      |     변환 |   환율   |
| :--------: | :--------:| :------: |
| CHF    |   USD |  1.5  |

새로운 보고서를 생성하려면 다음과 같은 조건이 되어야한다.
- 통화가 다른 두 금액을 더해서 주어진 환율에 맞게 변한 금액을 결과로 얻을 수 있어야 한다.
- 어떤 금액(주가)을 어떤 수(주식)에 곱한 금액을 결과로 얻을 수 있어야 한다.

테스트를 작성하기 전에 살펴 볼 **현재 해야할 일** : 
- [ ] \$5 + 10CHF = $10 (환율이 2:1일 경우)
- [ ] \$5 * 2 = $10
- [ ] amount를 private로 만들기
- [ ] Dollar 부작용? Money 반올림? (이건 나중에)


테스트를 작성할 때는 작은 것부터 시작해야하고, 오퍼레이션의 완벽한 인터페이스에 대해 상상해보는 것이 좋다.

간단한 곱셈의 예)
```java
public void testMultiplication(){
	Dollar five = new Dollar(5);
	five.times(2);
	assertEquals(10, five.amount);
}
```
이와 같은 코드는 public field에 예기치 못한 부작용이 있을 수 있지만, 먼저 작은 것부터 시작하고 우선 초록 막대를 띄우는 것으로 시작한다.



이렇게 테스트를 작성하면 다음 4가지의 오류가 뜬다.
- Dollar 클래스가 없음 (위는 테스트 코드이므로 내 원본 코드에는 현재 아무 것도 작성되어 있지 않는다.)
- 생성자가 없음
- times(int) 메소드가 없음
- amount 필드가 없음

이는 다음 4단계를 통해 모두 없앨 수 있다.

```java
// 클래스 생성
class Dollar

// 생성자 생성
Dollar(int amount) {
}

// times 스텁(stub)생성
// stub이란, 테스트 코드가 간신히 컴파일만 될 수 있을 정도로 껍데기만 만드는 것을 말한다.
void times(int multiplier) {
}

// amount 필드 추가
int amount;
```

이렇게 할 경우 amount가 10이 아니라 0으로 뜨기 때문에 우리가 예상했던 결과와 다르게 나온다. 
초록색을 띄우기 위해서 10을 강제할당한다.

```java
int amount = 10;
```

이런 식으로 진행한다.

이제 중복을 제거한다. (리팩토링)
우리가 할 일에 적어둔 10은 다른 어딘가에서 넘어온 10이므로 times() 메소드 안에 정의하여 중복을 없애도록 한다.

```java
int amount;

void times(int multiplier) {
	amount = 5 * 2;
}
```

계속 중복을 제거하자면, 저기에서 5는 생성자에서 넘어온 것으로 볼 수 있기 때문에 이걸 다음과 같이 amount 변수에 저장하면,

```java
Dollar(int amount) {
	this.amount = amount;
}
```

그걸 time에서 사용할 수 있다.

```java
int amount;

void times(int multiplier) {
	amount = amount * 2;
}
```

여기서 인자(parameter) multiplier값이 2 이므로 상수를 이 인자로 대체한다.

```java
int amount;

void times(int multiplier) {
	// 이것은 amount *= multiplier로 쓸 수 있다.
	amount = amount * multiplier;
	
}
```

이렇게 되면 1개의 할 일이 마무리 된다.
- [ ]  \$5 + 10CHF = $10 (환율이 2:1일 경우)
- [x]  \$5 * 2 = $10
- [ ] amount를 private로 만들기
- [ ] Dollar 부작용? Money 반올림? (이건 나중에)


### 메모리 관리
#### ARC
##### Apple Swift 3.1 Language Guide - Automatic Reference Counting
http://kka7.tistory.com/21
Swift는 앱의 메모리 사용량을 추적하기 위해서 *자동 참조 개수(ARC - Automatic Reference Counting)*를 사용한다. 대부분의 경우는 Swift에서 메모리 관리는 그냥 사용되고 메모리 관리에 대해서 생각할 필요가 없다. ARC는 인스턴스가 더 이상 필요 없을 때 클래스 인스턴스를 자동으로 메모리에서 해제하기 때문이다.

하지만 몇 가지 경우에서 ARC는 메모리 관리를 위한 코드 일부와 관련있는 더 많은 정보가 필요하다. Swift에서 ARC 사용은 매우 단순하다.
> **주의**
> 참조 개수는 클래스의 인스턴스에만 적용된다. 구조체와 열거형은 값(value) 타입이기 때문에 참조로 저장되거나 전달되지 않는다.

클래스의 새로운 인스턴스를 생성할 때 마다, ARC는 인스턴스에 관한 정보를 저장하기 위해서 메모리 덩어리(chunk)를 할당한다. 이 메모리는 인스턴스의 저장 프로퍼티(stored property)와 연관된 값과 함께 인스턴스 타입에 대한 정보를 유지한다.

그뿐만 아니라 인스턴스가 더 이상 필요하지 않을 때 ARC는 메모리를 다른 목적으로 사용할 수 있도록 인스턴스에 의해 사용된 메모리를 해제한다. (클래스 인스턴스가 더 이상 필요하지 않을 때 메모리 공간을 가지지 않는 것을 보장한다.)

하지만 ARC가 아직 사용하고 있는 인스턴스의 메모리를 해제할 경우 더는 인스턴스의 프로퍼티에 접근할 수 없거나 인스턴스의 메소드를 호출 할 수 없다. 이 경우에 인스턴스에 접근하려 하면 앱 크래쉬(crash)가 일어난다.

필요한 인스턴스가 사라지지 않는지 확인해야 하고, ARC는 각 클래스 인스턴스에 현재 참조 중인 많은 프로퍼티, 상수, 변수를 추적한다. ARC는 인스턴스에 대해 활성화된 참조가 1개라도 있으면 메모리를 해제하지 않는다.

이를 가능하게 하기 위해서 프로퍼티, 상수, 변수에 클래스 인스턴스를 할당할 때마다 그 프로퍼티, 상수, 변수는 인스턴스에 *강한 참조(strong reference)*를 만든다. 강한 참조로 호출되는 것은 인스턴스를 강하게 유지하며 강한 참조가 남아있는 경우에는 메모리를 해제하지 않는다.

#### ARC in Action
다음은 ARC 작동 방식에 대한 예제이다.
```swift
class Person { 
	let name: String 
		init(name: String) { 
		self.name = name print("\(name) is being initialized") 
	} 
	deinit { 
		print("\(name) is being deinitialized") 
	} 
}
```
`Person` 클래스는 인스턴스의 `name` 프로퍼티를 설정하고 초기화 진행 중을 나타내는 메시지를 출력하는 초기화(initializer)를 가지고 있다. 또한 `Person` 클래스는 클래스의 인스턴스가 메모리에서 해제될 때 메시지를 출력을 하는 해제(deinitializer)도 가지고 있다.

다음 코드는 바로 다음 코드 일부(snippet)에서 새로운 `Person` 인스턴스에 여러 개의 참조 설정에 사용되는 `Person?` 타입의 일부를 정의한다. 이러한 변수들이 옵셔널 타입이기 때문에 자동으로 값이 nil로 초기화 되고 현재 `Person` 인스턴스를 참조하지 않는다.

```swift
var reference1: Person?
var reference2: Person? 
var reference3: Person?
```
새로운 `Person` 인스턴스를 생성하고 3개의 변수들 중 하나에 할당할 수 있습니다.

```swift
reference1 = Person(name: "John Appleseed")
// prints "John Appleseed is being initialized"
```
Person 클래스의 초기화를 호출하는 시점에 John Appleseed is being initialized가 출력 된다는 것을 인식할 수 있다. 이것이 초기화가 일어났다는 것을 확인시켜준다.

새로운 `Person` 인스턴스가 `reference1` 변수에 할당되기 때문에, 이제 새로운 `Person` 인스턴스에 `reference1`은 강한 참조가 된다. 강한 참조가 1개 이상이기 때문에 ARC는 `Person`이 메모리에 유지되고 할당해제 되지 않는다.

두 개 이상의 변수에 동일한 `Person` 인스턴스를 할당하면 인스턴스에 두 개 이상의 강한 참조가 된다.
```swift
reference2 = reference1
reference3 = reference1
```
현재 하나의 `Person` 인스턴스에 3개의 강한 참조가 있다.

두 개의 변수에 `nil` 을 할당해서 두 개의 강한 참조가 깨지면, 하나의 강한 참조만 남고, `Person` 인스턴스는 메모리에서 해제되지 않는다.

```swift
reference1 = nil
reference2 = nil
```

ARC는 `Person` 인스턴스가 더 이상 사용하지 않는 것이 명확해진 시점인 3번째와 마지막 강한 참조가 깨지기 전까지 `Person` 인스턴스를 메모리에서 해제하지 않는다.

```swift
reference3 = nil
// Prints "John Appleseed is being deinitialized"
```

#### 클래스 인스턴스 간의 강한 순환 참조(Strong Reference Cycles Between Class Instances)
위의 예제에서 ARC는 새로운 `Person` 인스턴스의 참조 횟수를 추적할 수 있고 `Person` 인스턴스가 더 이상 필요하지 않을 때 메모리에서 해제한다.



---

https://www.raywenderlich.com/134411/arc-memory-management-swift
https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html
http://njir.github.io/2015/03/19/memori-gwanriarc/index.html
https://medium.com/@enricopiovesan/arc-swift-tutorial-d42dea53eddb
https://stackoverflow.com/questions/31346518/how-to-work-with-automatic-reference-counting-arc

#### Weak, strong, unowned
https://krakendev.io/blog/weak-and-unowned-references-in-swift


### Core image
#### Image crop app

### Core data
#### Shopping wish list app
1. project 생성 -> use core data -> 프로젝트명.xcdatamodeld 파일 확인

2. Appdelegate.swift에 2가지 함수를 확인
- **persistentContainer**
Manage Object Model, NSPersistenceStoreCoordinator, NSManagedObjectContext 을 관리한다. 

- **saveContext**
NS Managed Objects를 database로 보낼 때 부르는 함수이다.

3. xcdatamodeld에서 Entity를 생성하고 -> Attributes(property)를 세팅한다.(title과 type도 설정한다.)

4. model을 정의한 후에 relationship을 정의한다.

5. 오른쪽 사이드바를 열어서 일대다, 다대일 관계를 정의한다. 이를 테이블 관계표로 보면 화살표가 1개면 **일대일**, 화살표가 2개가 있으면 **일대다**임을 알 수 있다.

6. 이제 Editor 탭에 create NSManagedObject subclasses..로 swift 파일을 생성해야한다. 
만들어야할 entity를 선택하고 해당 프로젝트 group에서 프로젝트가 아닌 아래 폴더로 바꿔서 저장한다. 그 후 무더기로 생성되는 모델 관련 swift 파일들을 New group으로 폴더를 생성해서 정리한다.
>**Note** : 오류가 난다면 entity의 class탭에서 module : Current Product Module, Codegen : Manual/None로 설정하고 다시 generate한다.
7. 관련 메소드
awakeFromInsert() - entity에서 해당 아이템을 생성하면 이 함수가 불려진다.


### TDD practice
#### Making calculator app with Test-Driven Development (TDD)

### 객체지향 프로그래밍
#### **Setter, Getter 이유**
http://qna.iamprogrammer.io/t/encapsulation-getter-setter/193
#### 원칙 5가지
- SRP
- OCP
- LSP
- ISP
- DIP
#### 특성
- 추상화
- 캡슐화
- 상속성
- 다형성

### Protocol, Initialization, Extension
#### Protocol

#### Initialization
초기화는 클래스, 구조체, 또는 열거형의 인스턴스를 사용하기 위한 준비 과정다. 이 과정은 해당 인스턴스의 각각의 저장된 속성의 초기값을 설정하는 것과 그 외의 다른 설정 또는 새 인스턴스를 사용하기 전에 필요한 초기화를 한다. 이 초기화 과정을 이니셜라이저(initializer)를 정의함으로서 구현할 수 있다. 이니셜라이저는 특정 타입의 새 인스턴스를 만들때 호출될 수 있는 특수 메소드이다. 

다른 오브젝티브 C의 이니셜라이저와는 달리 스위프트의 이니셜라이저는 값을 반환하지 않는다. 이니셜라이저의 주 역할은 새 인스턴스가 처음 사용되기 전에 잘못된 곳이 없이 초기화가 되었는지 보장하는 것이다. 또한 클래스 타입의 인스턴스는 디이니셜라이저(deinitializer)를 정의 할 수 있다. 디이니셜라이저는 할당 해제되기 바로 직전에 맞춤 정리를 수행한다. 
(디이니셜라이저에 대해 더 많은 정보를 원하시면 Deinitialization을 보도록 한다.)

**저장 속성에 초기값 설정하기**
클래스와 구조체의 인스턴스가 생성될때에 맞춰서 인스턴스내의 저장된 속성은 적절한 초기값으로 설정이 되어야 합니다. 저장된 속성은 정해지지 않은 상태로 남아있을 수 없습니다. 이니셜라이저를 통해 저장 속성에 초기값을 설정하거나, 속성의 정의의 일부분으로서 기본 속성값을 지정 할 수 있습니다. 이 행동들은 뒤따르는 섹션에 설명되어 있습니다.
>**NOTE**: 저장 속성에 기본값을 지정하거나, 이니셜라이저에서 초기값을 설정할 때, 어떠한 속성 감시자(observer)도 호출하지 않고 속성의 값이 직접 설정 됩니다.

가장 기본적인 형태로 `init` 키워드를 사용하며, 파라메터가 없는 인스턴스 메소드의 형태입니다. 밑의 예제는 `Fahrenheit` 


### Xcode 단축키
option + 클릭 -> 스토리보드 오른쪽 옆에 assistant editor 화면으로 코드가 분할하여 뜬다.
