# GQSwiftCoreSDK

This is an SDK that provides some very useful helper properties and objects to make it much more easier to work with Swift and SwiftUI on your day-to-day coding.

## 🧱 Installation
This SDK is only available in Swift Package Manager. 
Please follow the steps below to add GQSwiftCoreSDK with Swift Package Manager.

- Select your project and navigate to `Package Dependencies`.
- Click on the `+` button at the bottom-left of the `Packages` section.
- Paste https://github.com/geoo993/GQSwiftCoreSDK.git into the Search Bar.
- Press `Add Package`.
- Xcode will download the package and prompt you to add the package in your project.

## 👩‍💻 Usage

### Extention Properties
The following are the different properties available as extension of Swift value types.

#### 1. Safe Array subscript
Sometimes when subscripting in an Array, you might feel uncertain that the index used is within the bounds of the array.
This `safe:` subscript allow you to return an optional value if a given index is out of bounds of the array.

```swift
    guard let value = array[safe: index] else {
        return
    }
    ...
```

#### 2. Option Boolean
Sometimes you just want to know if an optional value is nil or not without unwrapping it.

```swift
    var value: Int? = nil
    .....
    
    if value.isNil {
        ...
    } else {
        ...
    }
```

For strings, you can even go further by checking if the string is nil or empty.

```swift
    var value: String? = nil
    ...
    
    if value.isNilOrEmpty {
        ...
    } else {
        ...
    }
```


#### 3. String to URL
Sometimes you want to quickly map a string to URL, this often occurs when you decoded a URL as string and then want to convert it back to a URL.

```swift
    var imageUrl: URL?
    .....
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let urlString = try container.decode(String.self, forKey: .image)
        imageUrl = urlString.toUrl
        ...
    }
```

#### 4. Blank String
Sometimes you want to check if a string is not only empty but if its blank, without any tabs or whitespaces.

```swift
    var value: String = "      "
    ...
    
    if value.isBlank {
        ...
    } else {
        ...
    }
```
    
#### 5. Using Booleans in a declarative way
When working with Booleans, there are much more pleasant ways of working with them that makes your code much easier to read.
Using `Then` helps achieve a more declarative handling of side effects. Instead of nesting the effect in a branched if-else, it reads as a simple closure, removing the extra depth.

```swift
    var isTodayMonday: Bool = true
    ...
    isTodayMonday.then { runSideEffect() }
    ...
```

Similarly, we can `isFalse` instead of `!` to make working with Bool much easier to read.

```swift
    var isTodayMonday: Bool = false
    ...
    if isTodayMonday.isFalse {
        ...
    }
    ...
```

### New Object
The following are the some very useful objects that address some very common stumbling blocks when working with Swift and SwiftUI.

#### 1. With closure
In our day-to-day tasks, we often have to instantiate or initialise objects with their values in multiple places and perhaps multiple times. This is very commone when working with UIViews.
`With` allows you to combine the initialisation and injection of initial values of an object all at once.

```swift

extension UIView: With {}
...

class RedVieWController: UIViewController {
    let container = UIView().with {
        $0.backgroundColor = UIColor.red
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray.cgColor
    }
    ...
}

```

#### 2. Unwrap ViewBuilder
Sometimes when composing your View in SwiftUI, you might notice that its not easy to work with optional values.
`Unwrap` makes it easy to build your Views with optionals using a `ViewBuilder` that unwraps your optional and returns the value in the closure.

```swift
final class ViewModel: ObservableObject {
    @Published var product: Product?
    ...
}

struct ContentView: View {
    @StateObject var viewModel: ViewModel
 
    var body: some View {
        VStack {
            Unwrap(viewModel.product) { product in
                Text(product.name)
                    .font(.title3)
                    .fontWeight(.semibold)
            }
            ...
        }
    }
}
    
```

#### 2. AnyError Type Erasure
It is very common that our app encounters many errors, the more errors at your disposal the harder it is to map or transfer those errors to relevant parts of your code. 
`AnyError` is a type erasure that makes it easy to work with mutliple implementation of errors, by wrapping them so they can be easily moved around your code.

```swift
enum APIError: Error {
    case responsefailed
}
 
final class ProductRepository {
    ...
    func products() -> AnyPublisher<Product, APIError> {
        ...
    }
}

final class ViewModel: ObservableObject {
    private var repository: ProductRepository
    private var subscriptions: Set<AnyCancellable> = []
    @Published var product: Result<Product, AnyError>
    ...
    
    func getProducts() {
        repository.products()
            .receive(on: self.queue)
            .mapError(AnyError.init)
            .sink { completion in
                switch completion {
                case let .failure(error):
                    self.product = .failure(error)
                default: break
                }
            } receiveValue: { value in
                self.product = .success(value)
            }
            .store(in: &subscriptions)
    }
}
    
```

#### 2. Loading Enum
Most of the time, we make long running tasks such as server calls or loading resources from cache and we will often run them in a background queue. `Loading` is a perfect `Type` to set on your properties that are awaiting the results of our long running tasks. It allows you to set the status of your property throughout the different stages of your long running task.

```swift
enum APIError: Error {
    case responsefailed
}
 
final class ProductRepository {
    ...
    func products() -> AnyPublisher<Product, APIError> {
        ...
    }
}

final class ViewModel: ObservableObject {
    private var repository: ProductRepository
    private var subscriptions: Set<AnyCancellable> = []
    @Published var product: Loading<Product> = .idle
    ...
    
    func getProducts() {
        product = .loading()
        repository.products()
            .receive(on: self.queue)
            .mapError(AnyError.init)
            .sink { completion in
                switch completion {
                case let .failure(error):
                    self.product = .error(error)
                default: break
                }
            } receiveValue: { value in
                self.product = .loaded(value)
            }
            .store(in: &subscriptions)
    }
}
    
```

## Conclusion

As Swift and SwiftUI evolves, there will be more and more properties that will emerge and turn out to be extremely usually as part of this toolkit, but for now I wish you happy coding. 🎉
