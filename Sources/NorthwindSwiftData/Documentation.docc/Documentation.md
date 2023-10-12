# ``NorthwindManagedModels``

A CoreData + ManagedModels version of Microsoft's Northwind database.

@Metadata {
  @DisplayName("Northwind for ManagedModels")
}

## Overview

From [Northwind-SQLite3](https://github.com/jpwhite3/northwind-SQLite3):

The Northwind sample database was provided with Microsoft Access as a 
tutorial schema for managing small business customers, orders, inventory, 
purchasing, suppliers, shipping, and employees. 
Northwind is an excellent tutorial schema for a small-business ERP, with
customers, orders, inventory, purchasing, suppliers, shipping, employees, and 
single-entry accounting.

## NorthwindManagedModels

This package provides the Northwind database imported into a 
[CoreData](https://developer.apple.com/documentation/coredata)
store, using the
[ManagedModels](https://github.com/Data-swift/ManagedModels/)
library.
I.e. it doesn't just provide the model classes for Northwind,
but also a **prefilled database**.

It can be useful in the context to play with CoreData, for tutorials
and demos, to learn CoreData etc.

> The Northwind database is a little old, but still useful to get started w/ an 
> actual dataset. The advantage is that the database is available across 
> different systems, hence allow for a comparison on how things can be 
> implemented.

The data in the database is a management system for the operations of a
fictional trading company called "Northwind".
Northwind buys ``Product``s from ``Supplier``s and sells them to ``Customer``s.
Those ``Order``s are sent to them using ``Shipper``s.
All of the models are connected using relationships. E.g. all ``Order``s
of a ``Customer`` can be retrieved using the ``Customer/orders`` relationship.
Or all ``Product``s a specific ``Supplier`` provides, using the
``Supplier/products`` relationship.


## Getting Started

Checkout the detailed instructions in <doc:GettingStarted>.
The TL;DR is:
- Add the package `https://github.com/Northwind-swift/NorthwindManagedModels.git`
  to a project.
- Setup the ManagedModels `ModelContainer` (`NSPersistentContainer`)
  in the SwiftUI application:
  ```swift
  import NorthwindSwiftData

  WindowGroup { ContentView() }
      .modelContainer(try! NorthwindStore.modelContainer())
  ```
- Use the provided models in a SwiftUI View:
  ```swift
  @FetchRequest(sort: \Product.name) var products : [ Product ]

  ForEach(products) { product in 
      Text(verbatim: product.name) 
  }
  ```

More details: <doc:GettingStarted>.


## Topics

### Getting Started

- <doc:GettingStarted>

### Support

- <doc:FAQ>
- <doc:Links>
- <doc:Who>

### Database Access

- ``NorthwindStore``
- ``NorthwindSchema``

### Persistent Models

- ``Category``
- ``Customer``
- ``Employee``
- ``Product``
- ``Order``
- ``OrderDetail``
- ``Shipper``
- ``Supplier``
- ``Region``
- ``Territory``
- ``CustomerDemographic``

### Addresses

- ``StructuredAddress``
- ``StructuredAddressProvider``
- ``AddressHolder``

### Helper Types

- ``Photo``
- ``Money``
- ``YMDDate``
