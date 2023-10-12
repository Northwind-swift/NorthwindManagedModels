# Getting Started

Using NorthwindManagedModels in SwiftUI.

## Introduction

This article shows how to setup a small SwiftUI Xcode project to work with
NorthwindManagedModels.


## Creating the Xcode Project and Adding NorthwindManagedModels

1. Create a new SwiftUI project in Xcode, e.g. a Multiplatform/App project or an
   iOS/App project. (it does work for UIKit as well!)
2. Choose "None" as the "Storage" (instead of "SwiftData" or "Core Data"),
   NorthwindManagedModels already has the storage setup for you.
3. Select "Add Package Dependencies" in Xcode's "File" menu to add the
  NorthwindManagedModels package.
4. In the **search field** (yes!) of the packages panel,
   paste in the URL of the package:
   `https://github.com/Northwind-swift/NorthwindManagedModels.git`,
   and press "Add Package" twice.


## Configure the App to use Northwind

In the app configuration, add the NorthwindStore as the apps
ModelContainer (`NSPersistentContainer`):

```swift
import NorthwindSwiftData

@main
struct NorthwindApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(try! NorthwindStore.modelContainer())
    }
}
```

This takes the prefilled database contained in the package and copies
that to the users Application Support directory.
So that it can be _edited_ by the user.
The ``NorthwindStore/modelContainer(bootstrapIfMissing:_:)`` function has a few 
options to configure that process.

Alternatively, if readonly access is sufficient,
the ``NorthwindStore/readOnlyModelContainer()`` function can be used to get 
direct access to the database contained within the package.

> At some point when building the project, Xcode is going to ask whether you
> trust the `@Model` macro provided by ManagedModels. Choose yes if you do,
> and no if not. Or review the sources in advance to see what the macro does.


## Write a SwiftUI View that works w/ the Database

A small example view to display all the products in a SwiftUI List.

```swift
import SwiftUI
import NorthwindSwiftData

struct ContentView: View {

    @FetchRequest(sort: \.name)
    private var products: FetchedResults<Product>
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(products) { product in
                    Text(verbatim: product.name)
                }
            }
            .navigationTitle("Products")
        }
    }    
}

#Preview {
    ContentView()
        .modelContainer(try! NorthwindStore.readOnlyModelContainer())
}
```
