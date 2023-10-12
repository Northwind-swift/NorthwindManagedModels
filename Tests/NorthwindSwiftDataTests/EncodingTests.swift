//
//  Created by Helge Heß.
//  Copyright © 2023 ZeeZide GmbH.
//

import XCTest
@testable import NorthwindSwiftData
import ManagedModels

final class EncodingTests: XCTestCase {

  private var context : ModelContext!
  
  override func setUp() async throws {
    context = ModelContext(try TestContainer.northwind)
    XCTAssertFalse(context.autosaveEnabled)
  }
  
  func testCategoryEncoding() throws {
    let fd     = NorthwindSchema.Category.fetchRequest(sortBy: \.name)
    let models = try context.fetch(fd)
    let model  = try XCTUnwrap(models.first)
    
    let data   = try JSONEncoder().encode(model)
    #if true
    let string = try XCTUnwrap(String(data: data, encoding: .utf8))
    print(string)
    #endif
    
    let json       = try JSONSerialization.jsonObject(with: data)
    let jsonDict   = try XCTUnwrap(json as? [ String : Any ])
    
    // different to SwiftData which has a dict here, CD has the URL
    let id = try XCTUnwrap(jsonDict["id"] as? String)
    
    XCTAssertTrue(id.hasPrefix("x-coredata://"))
    XCTAssertNotNil(id.range(of: "/Category/"))

    XCTAssertEqual(jsonDict["name"] as? String, "Beverages")
    XCTAssertEqual(jsonDict["info"] as? String,
                   "Soft drinks, coffees, teas, beers, and ales")
    
    let productIDs = try XCTUnwrap(jsonDict["products"] as? [ String ])
    XCTAssertEqual(productIDs.count, 12)
  }
  
  #if true // beta7 forget crash
  func testProductEncoding() throws {
    try autoreleasepool {
      try _testProductEncoding()
    }
  }
  func _testProductEncoding() throws {
    let fd     = Product.fetchRequest(sortBy: \.name)
    let models = try context.fetch(fd)
    let model  = try XCTUnwrap(models.dropFirst(9).first)
    
    let data   = try JSONEncoder().encode(model)
#if false
    let string = try XCTUnwrap(String(data: data, encoding: .utf8))
    print(string)
#endif
    
    let json     = try JSONSerialization.jsonObject(with: data)
    let jsonDict = try XCTUnwrap(json as? [ String : Any ])
    do {
      // different to SwiftData which has a dict here, CD has the URL
      let id = try XCTUnwrap(jsonDict["id"] as? String)
      let url = try XCTUnwrap(URL(string: id))
      
      XCTAssertEqual(url.scheme, "x-coredata")
    }
    
    XCTAssertEqual(jsonDict["discontinued"] as? Int, 1)
    XCTAssertEqual(jsonDict["reorderLevel"] as? Int, 0)
    XCTAssertEqual(jsonDict["unitsInStock"] as? Int, 0)
    XCTAssertEqual(jsonDict["unitsOnOrder"] as? Int, 0)
    XCTAssertEqual(jsonDict["name"] as? String, "Chef Anton's Gumbo Mix")
    XCTAssertEqual(jsonDict["quantityPerUnit"] as? String, "36 boxes")
    XCTAssertEqual(String(describing: try XCTUnwrap(jsonDict["unitPrice"])),
                   "21.35")
    
    // An array of ID strings
    let orderIDs = try XCTUnwrap(jsonDict["orderDetails"] as? [ String ])
    XCTAssertTrue(orderIDs.count > 200)
    
    do {
      let id  = try XCTUnwrap(orderIDs.first)
      let url = try XCTUnwrap(URL(string: id))
      
      XCTAssertEqual(url.scheme, "x-coredata")
    }
  }
  #endif
}
