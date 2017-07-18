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




### 메모리 관리
#### ARC
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
초기화는 클래스, 구조체, 또는 열거형의 인스턴스를 사용하기 위한 준비 과정입니다. 이 과정은 해당 인스턴스의 각각의 저장된 속성의 초기값을 설정하는 것과 그 외의 다른 설정 또는 새 인스턴스를 사용하기 전에 필요한 초기화를 합니다. 이 초기화 과정을 이니셜라이저(initializer)를 정의함으로서 구현할 수 있습니다. 이니셜라이저는 특정 타입의 새 인스턴스를 만들때 호출될 수 있는 특수 메소드입니다. 

다른 오브젝티브 C의 이니셜라이저와는 달리 스위프트의 이니셜라이저는 값을 반환하지 않습니다. 이니셜라이저의 주 역할은 새 인스턴스가 처음 사용되기 전에 잘못된 곳이 없이 초기화가 되었는지 보장하는 것입니다. 또한 클래스 타입의 인스턴스는 디이니셜라이저(deinitializer)를 정의 할 수 있습니다. 디이니셜라이저는 할당 해제되기 바로 직전에 맞춤 정리를 수행합니다. 디이니셜라이저에 대해 더 많은 정보를 원하시면 Deinitialization을 보세요.

**저장 속성에 초기값 설정하기**
클래스와 구조체의 인스턴스가 생성될때에 맞춰서 인스턴스내의 저장된 속성은 적절한 초기값으로 설정이 되어야 합니다. 저장된 속성은 정해지지 않은 상태로 남아있을 수 없습니다. 이니셜라이저를 통해 저장 속성에 초기값을 설정하거나, 속성의 정의의 일부분으로서 기본 속성값을 지정 할 수 있습니다. 이 행동들은 뒤따르는 섹션에 설명되어 있습니다.
>**NOTE**: 저장 속성에 기본값을 지정하거나, 이니셜라이저에서 초기값을 설정할 때, 어떠한 속성 감시자(observer)도 호출하지 않고 속성의 값이 직접 설정 됩니다.

가장 기본적인 형태로 `init` 키워드를 사용하며, 파라메터가 없는 인스턴스 메소드의 형태입니다. 밑의 예제는 `Fahrenheit` 


### Xcode 단축키
option + 클릭 -> 스토리보드 오른쪽 옆에 assistant editor 화면으로 코드가 분할하여 뜬다.