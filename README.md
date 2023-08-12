# Sushi-Lane

# Architecture & Tools

- [x] iOS 16.4
- [x] iPhoneOS, tvOS
- [x] ViewModel + Clean
- [x] Swift 5
- [x] SwiftUI
- [x] Factory
- [x] Unit tested

# Approach

1. Chose `SwiftUI` To develop the UI more faster.
2. Used `ViewModel`, as the States behind the Views were not complicated, and just needed to be seperated.
3. Used `Factory` to handle dependency managment as it is great tools for testing and handling dependencies.
4. Used light `Clean-Architecture` to keep layer seperated and follow **seperation of concerns**.
5. Followed `TDD` to write several Unit Tests for Viewmodels and UseCases, and integrated test.

## 3th-Party Descision

I just used `Factory` to handle depedencies, of course I could write simple container, but then I should have to drill the dependencies and share everything everywhere, and make it hard to manage and test in units, on the other hand if I wanted to avoid drilling that would become a system just like `Factory`, So writing it myself created some boilerplate code which could be avoided.

Using this library create some complexity to understand and make the project dependent on an outsider community, but inventing the wheel itself and considering the issues explained above, It worthed to use it. The library has simple APIs which are common across Injection approaches in iOS with  Swift, so it is not something new or alien for other developers.

## Architecture Descision

I have decided to use `ViewModel` concept in order to seperate some user interface logic from `Views`, in order to test them in units, and not to depend on view on testing, also keep layers separated and let the view's concern only be rendenring with provided data. ViewModel's responsibilty is to hold View's state, send and receive updates whenever user has interaction or vice versa. ViewModel acts as an StateObject or StateStore here and mange to change state and trigger side effects and apply the results.

As I mentioned, alongside Viewmodel, I consider using layer architecture(clean), to separate some non-UI logics and data fetching from Viewmodels, or anything which is scoped in business logic domain or data layer, as an example the image url should has specific format, this is not the viewModel concern how to build url of an image based on some logic, so I have separated this concern inside an `UseCase`. Furthermore, this logic could be shared if we have a detail page which will also show image again.

By mentioning light clean, I meant the layers are separated, but not all components have concrete implementation in their own layer, as they did not contain specific logic or proccessing, instead I have implemented them in an outer layer which they use as dependency. As an example, `FetchVideoAssetsUseCaseProtocol` could have implementation which then use network layer(as injected dependency with interface) to fetch data, but as it has no logic, I did not created a concrete class for `FetchVideoAssetsUseCaseProtocol`, instead I have implemented `FetchVideoAssetsUseCaseProtocol` on `NetworkServices`.

> I also considered using TCA for presentation layer, but this framework and redux pattern is more applicable for complex state managment purposes, create high learning curve to use and teach(to new joiners) it and uses lots of depedencies itself to operate which made it not a good choice for using it on this task.

## Readability / Maintainability Approaches

1. Structured folders.
2. Descriptive names(classes, functions, etc.).
3. Using extensions, to reduce lines of code in one file.
4. Used native apis and libraries, without any extensions and complicated proccessing.
5. Keep concerns separated, so developers will keep looking in one layer or set of files to find something, they don't need to search every file or folder and get lost in project.
6. Did not use complex 3th-party dependencies(except Factory), so project is dependent from any changes and wired bugs from outside world.
7. The architecture I used itself, made project more expandable, so if the logic change, modularizing, using specific framework in each layer and... won't take lots of time to adopt.
8. Easy for new joiner to understand how project operates as it has pre-defined structure.
9. Easy to test and make sure almost everything operate correctly, as layers depend on abstraction(made it easy to test each part independently and integratedly).
10. Simplified view hierarchy, as complex views have breaked down into small views or modifiers(also for reuse purposes).
