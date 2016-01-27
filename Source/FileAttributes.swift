//
//  FileAttributes.swift
//  SwiftUtils
//
//  Created by Ryan Breaker on 1/26/16.
//  Copyright © 2016 Ryan Breaker. All rights reserved.
//

import Foundation


private func numberCheck(key: String, object: AnyObject) throws -> NSNumber {
	guard let num = object as? NSNumber else {
		throw FileAttributesError.NumberError(key: key)
	}

	return num
}


struct FileAttributes {
	let fileName: String
	let fileSize: UInt64
	let filePermissions: String

	init(name: String, attributes: [String: AnyObject]) {
		var numbers = [String: NSNumber]()

		for (key, object) in attributes {

			do {
				switch key {

				// Pick out the numbers
				case NSFileSize,
					 NSFilePosixPermissions:

					numbers[key] = try numberCheck(key, object: object)
					break

				// If no match, ignore it and continue
				default: continue

				}
			} catch FileAttributesError.NumberError(let key) {
				fatalError("Number error in attributes, key: `\(key)'.")
			} catch let error as NSError {
				fatalError(error.localizedDescription)
			}
		}

		self.fileName = name
		self.fileSize = numbers[NSFileSize]!.unsignedLongLongValue  // UInt64
		self.filePermissions = numbers[NSFilePosixPermissions]!.stringValue
	}
}


enum FileAttributesError: ErrorType {
	case NumberError(key: String)
}
