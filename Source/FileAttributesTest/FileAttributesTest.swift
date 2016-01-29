//
//  FileAttributesTest.swift
//  FileAttributesTest
//
//  Created by Ryan Breaker on 1/27/16.
//  Copyright © 2016 Ryan Breaker. All rights reserved.
//

import XCTest

class FileAttributesTest: XCTestCase {

	let empty = [String: AnyObject]()
	let fileSize = [NSFileSize: NSNumber(unsignedLongLong: 1024) as AnyObject]

	func testEmpty() {
		let fileAttrib = try? FileAttributes(fileName: "Foo", attributes: empty)

		XCTAssertNotNil(fileAttrib)
	}

	func testFileSize() {
		let fileAttrib = try? FileAttributes(fileName: "Foo", attributes: fileSize)

		XCTAssertNotNil(fileAttrib)
		XCTAssertEqual(fileAttrib!.fileSize, UInt64(1024))
		XCTAssertEqual(fileAttrib!.filePermissions, FileAttributes.EmptyPermissions)
	}

}
