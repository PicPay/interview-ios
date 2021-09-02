## Interview iOS Project
#### It is an iOS app project used in the iOS Developer technical interview at PicPay .

<p/>

   - Here is my linkedin profile: [lucas-ferreira-machado](https://www.linkedin.com/in/lucas-ferreira-machado) .  <p/>

   - Feel free to have a look at my [iOS MoviesApp repository](https://github.com/lucasferreiramachado/ios-movie-app) developed using : <p/>
     - Swift 5 + SwiftUI + Combine
     - Clean Architecture, Dependency Injection, MVVM and  Coordinator patterns
     - Quick/Nimble framework for Tests
     - Features modularization
<p/>

## Project Improvement Steps

**Note: Current Code Coverage is 94,3% _(was 42% before)_**

I followed this steps to improve the app project: <p/>
<br />
#### 1. [Fix] Missing list contacts screen title.  _[(more...)](https://github.com/lucasferreiramachado/interview-ios/pull/1)_
First, I created an **UI test** to validate the failure. Then I fixed it in the code and the test passed successfully.

- **Given** that application is launched 
- **When** the Contact List screen appears
- **Then** It should display the screen title "Lista de contatos"

<br />

#### 2. [Fix] Crash when selecting first contact in the list. _[(more...)](https://github.com/lucasferreiramachado/interview-ios/pull/2)_
**UI test** created to validate the failure. Then I fixed it in the code and the test passed successfully.

- **Given** that application is launched and the Contact List screen is displayed
- **When** User clicks on the first contact's name in the list
- **Then** It should display an dialog with the selected contact's name

<br />

#### 3. [Feature] Create an UI test to select a legacy contact from list. _[(more...)](https://github.com/lucasferreiramachado/interview-ios/pull/3)_
**UI test** created to select a legacy contact in the list. UI Test passed successfully.

- **Given** that application is launched and the Contact List screen is displayed
- **When** User clicks on a legacy contact in the list
- **Then** It should display an dialog with text "Você tocou no contato sorteado"

<br />

#### 4. [Feature] Apply Clean Architecture pattern (Data, Domain, Presentation Layers + Use Cases, Repository, Data Sources, Mappers) _[(more...)](https://github.com/lucasferreiramachado/interview-ios/pull/4)_
- ListContacts module separated between Data, Domain and Presentation layers.
- FetchContactsUseCase protocol created on Domain layer.
- NetworkPlatform module created to handle network data using HTTPClient, API, Mappers and DTO's classes.
- Repository and DataSources created to handle data from different sources (remote or local) such as REST APIs, CoreData, Firebase, Realm, etc.

###### About Clean Architecture:
Created by (Robert C. Martin, known as Uncle Bob) is an architecture that aims decoupled components, testable and easy maintenance. In that way, new features can be added quickly. <p />
<img src="https://www.objective.com.br/wp-content/uploads/2020/01/The-Clean-Architecture.jpg" width="40%" > <p />
**Communication flow between layers:** <p />
<img src="https://www.objective.com.br/wp-content/uploads/2020/01/fluxo-de-comunicacao.png" width="40%"  border="1px solid #aaaaaa" />

<br />

#### 5. [Feature] Asynchronously loading images into table view cells _[(more...)](https://github.com/lucasferreiramachado/interview-ios/pull/5)_
- I noticed that scrolling through the contact list was slow so I created **UI test** to measure and assert it. 
  - **Given** that application is launched and the Contact List screen is displayed
  - **When** User scroll up the contact list
  - **Then** It should take no more than 300 milli seconds
  - 
- **Scrolling event time was ~ 552 milliseconds** because photos of the contacts were downloaded on the main thread.
- Apple Developer Documentation recommends [Asynchronously Loading Images into Table and Collection Views](https://developer.apple.com/documentation/uikit/views_and_controls/table_views/asynchronously_loading_images_into_table_and_collection_views).
- ImageCache and ImageUrlProtocol created to store and fetch images asynchronously to make the app more responsive.
- **Current Scrolling event time is ~ 24 milliseconds**
- Then UI Test passed successfully. 

<br />

#### 6. [Feature] Review and improve MVVM pattern implementation _[(more...)](https://github.com/lucasferreiramachado/interview-ios/pull/6)_

- Check legacy user ids logic removed from **ListContactsViewController** and moved to a new use case class (CheckLegacyUserIdsUseCase) on Domain layer.
- Create **ContactCellViewModel** to provide the presentation data to the ContactCell view class.
- Refactor **ContactCell** class. Add bindViewModel and setPhotoImage methods.
- Refactor **ListContactsViewController** to display presentation data and bind the events only. Any business logic was moved to **ListContactsViewModel** class.

###### About MVVM pattern:

Model-View-ViewModel (MVVM) is a structural design pattern that separates objects into three distinct groups:

* **Models** 
  * hold application data. They’re usually structs or simple classes.
* **Views** 
  * display visual elements and controls on the screen.
* **View Models** 
  * transform model information into values that can be displayed on a view. This behavior is traditionally implemented using a paradigm known as [Functional Reactive Programming](https://en.wikipedia.org/wiki/Functional_reactive_programming). Libraries such as [ReactiveSwift](https://github.com/ReactiveCocoa/ReactiveSwift) and [RxSwift](https://github.com/ReactiveX/RxSwift) define a standard interface for events that views may want to react to, such as button taps, incoming network data, etc. They rely heavily on the [Observer pattern](https://en.wikipedia.org/wiki/Observer_pattern), in which views and/or view controllers observe/subscribe to observables and are “notified” appropriately whenever some event of interest occurs.

<br />

#### 7. [Feature] Apply Dependency Injection pattern _[(more...)](https://github.com/lucasferreiramachado/interview-ios/pull/7)_

- Classes were prepared to use Dependency Injection pattern. 
  - Dependencies are no longer initialized within classes. 
  - Dependencies are received in the initializer methods.
- Create ListContactsViewAssembler to assemble the module, 

###### About Dependency Injection pattern:
It's a software design pattern that implements Inversion of Control (IoC) for resolving dependencies. 
This pattern helps your app split into loosely-coupled components, which can be developed, tested and maintained more easily. <p/>

In the [VIPER pattern](https://medium.com/geekculture/battle-of-the-ios-architecture-patterns-view-interactor-presenter-entity-router-viper-8f76f1bdc960) its common to see the ** assembleModule method**  inside the Router or AppModule class. <p/>
I usually use the [SWInject framework](https://github.com/Swinject/Swinject) in my projects. Swinject is a lightweight dependency injection framework for Swift.

<br />

#### 8. [Feature] Add Integration Tests _[(more...)](https://github.com/lucasferreiramachado/interview-ios/pull/8)_

- Remove empty ListContactServiceTests class.
- Create mock class for FetchContactsUseCaseOutput.
- Add Integration Tests:
  - test async fecth contacts
  - test load images from network
  - test cancel load image request
  
 - Apple Documentation: [Testing Your Apps in Xcode](https://developer.apple.com/documentation/xcode/testing-your-apps-in-xcode)

###### About Integration Tests:
Integration tests examines the behavior of a larger subsystem, or combination of classes and functions. In the Arrange step of an integration test, widen the scope of real project code that’s under test, using fewer stub objects.

<br />

#### 9. [Feature] Add Unit tests _[(more...)](https://github.com/lucasferreiramachado/interview-ios/pull/9)_

Code Coverage: 94,3%

- Add Unit Tests:

  - Contact:
    - test decode valid contact json data
    - test decode invalid contact jsondata
  - FetchContactsUseCase:
    - test fetch contacts success
    - test fetch contacts  not connected to Internet
  - ListContactsViewModel:
    - test fetch contacts  not connected to Internet.

- Create Mocks:
  - ContactMock
  - FetchContactsUseCaseMock
  - FetchContactsRepositoryMock
  
- Apple Documentation: [Testing Your Apps in Xcode](https://developer.apple.com/documentation/xcode/testing-your-apps-in-xcode)

###### About Unit Tests:
Each unit test should assert the expected behavior of a single path through a method or function in your project. To cover multiple paths, write one test for each scenario. 
For example, if a function receives an optional parameter, you’d write a test in which the parameter is nil and a test in which it takes a non-nil value. Identify the boundary cases and logical branches in your code, and write a unit test to cover each combination of these cases.

<br />

#### More

- [The Clean Coder](https://en.wikipedia.org/wiki/Robert_C._Martin)
- [SOLID principles](https://en.wikipedia.org/wiki/SOLID)
- [BDD - Behavior Driven Development](https://wikipedia.org/wiki/Behavior_Driven_Development)
- [Test strategy: Pyramid distribution of tests](https://developer.apple.com/documentation/xcode/testing-your-apps-in-xcode)
  - a large number of fast, well-isolated unit tests to cover your app’s logic, 
  - a smaller number of integration tests to demonstrate that smaller parts are connected together properly, 
  - and UI tests to assert the correct behavior of common use cases.
<img src="https://docs-assets.developer.apple.com/published/ef95ee6af585ccd974aa64b61db87a7a/10500/testing-your-apps-in-xcode-1@2x.png" width="46%" >

<br />

## Next Steps ...

- Modularization using Pods or Swift Package Manager to separate application code into smaller modules.
- Add the Coordinator pattern to allow you to easily manage and expand the app's navigation flows.
- Use Quick + Nimble + Snapshots to generate screenshots of the tested screens and avoid any future changes impacting the UI screen layouts.
- Use the SwiftGen tool to automatically generate code and map and fail to use reources such as images, colors, fonts, and localizable strings.
- Use any code generation tool to automatically generate Mockable classes for application project. This allows you to create new unit tests quickly and efficiently.
- Use the Alamofire framework to easily make HTTP network requests.
- Use RXSwift (and RxCocoa) to implement [Functional Reactive Programming] (https://en.wikipedia.org/wiki/Functional_reactive_programming) .
