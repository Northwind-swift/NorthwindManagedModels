# Frequently Asked Questions

A collection of questions and possible answers.

## Overview

Any question we should add: [info@zeezide.de](mailto:info@zeezide.de),
file a GitHub
[Issue](https://github.com/Northwind-swift/NorthwindManagedModels/issues),
or submit a GitHub PR w/ the answer. Thank you!


## General

### What is ManagedModels, is that the same as SwiftData?

No, 
[ManagedModels](https://github.com/Data-swift/ManagedModels/) 
provides a SwiftData like `@Model` and other APIs for
[CoreData](https://developer.apple.com/documentation/coredata),
and backports to earlier OS versions.
The API is similar to
[SwiftData](https://developer.apple.com/documentation/swiftdata),
but different in various things.

If the deployment target of iOS 17+ is OK, SwiftData is probably the better
option. If an earlier deployment target is required, ManagedModels is for that.


### How is the database created?

The upstream database is available at GitHub:
[jpwhite3/northwind-SQLite3](https://github.com/jpwhite3/northwind-SQLite3).
This repository contains the full filled database w/ all records.

That SQLite database is then packaged as Swift using 
[Lighter](https://github.com/Lighter-swift) as
[NorthwindSQLite.swift](https://github.com/Northwind-swift/NorthwindSQLite.swift.git).
This uses the original database, and Swift functions to access the database are
generated automatically.

Finally that database is imported into CoreData using an importer tool.
The resulting store is packaged as a resource as part of this
[NorthwindSwiftData](https://github.com/Northwind-swift/NorthwindManagedModels.git)
package.


### How big is the database?

The upstream SQLite database isn't very big, just about 24MB.
The CoreData variant of the store is a little larger at ~29MB.
(Yes, the CoreData store is _also_ just a SQLite store, but carries additional
 metadata within.)

| Model           | Count  |
|-----------------|--------|
| ``Product``     |     77 |
| ``Category``    |      8 |
| ``Supplier``    |     29 |
| ``Shipper``     |      3 |
| ``Territory``   |     53 |
| ``Customer``    |     93 |
| ``Order``       |  16515 |
| ``OrderDetail`` | 613964 |


### Does this require SwiftUI or can I use it in UIKit as well?

The database works with both, SwiftUI and UIKit.
Or in AppKit, in a Swift tool or on the server side.
As long as 
[CoreData](https://developer.apple.com/documentation/coredata)
is available, e.g. not on Linux.


### Is it possible to use the database in SwiftUI Previews?

Yes. E.g. a preview can use the readonly container contained in the package:
```swift
#Preview {
    ContentView()
        .modelContainer(try! NorthwindStore.readOnlyModelContainer())
}
```

### Something isn't working right, how do I file a Radar?

Please file a GitHub
 [Issue](https://github.com/Northwind-swift/NorthwindManagedModels.git/issues).
Thank you very much.
