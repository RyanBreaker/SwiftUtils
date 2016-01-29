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

private func stringCheck(key: String, object: AnyObject) throws -> String {
	guard let str = object as? String else {
		throw FileAttributesError.StringError(key: key)
	}

	return str
}

private func dateCheck(key: String, object: AnyObject) throws -> NSDate {
	if let date = object as? NSDate {
		return date
	} else {
		throw FileAttributesError.DateError(key: key)
	}
}


struct FileAttributes {
	let fileName: String
	let fileSize: UInt64

	let filePermissions: String

	let fileOwner: String
	let fileGroup: String


	static let EmptyPermissions = "???"
	static let EmptyFileSize    = UInt64(0)


	init(fileName: String, attributes: [String: AnyObject]) throws {
		var numbers = [String: NSNumber]()
		var strings = [String: String]()
		var dates   = [String: NSDate]()

		for (key, object) in attributes {

			switch key {

			// Pick out the numbers
			case NSFileSize,
				 NSFilePosixPermissions:

				numbers[key] = try numberCheck(key, object: object)
				break

			case NSFileOwnerAccountName,
				 NSFileGroupOwnerAccountName:

				strings[key] = try stringCheck(key, object: object)
				break


			// If no match, ignore it and continue to next iteration
			default: continue

			}
		}


		// Check that these were fetched, otherwise set fallback
		if let size = numbers[NSFileSize] {
			self.fileSize = size.unsignedLongLongValue
		} else {
			self.fileSize = 0
			print("Warning, missing filesize!")
		}

		if let permissions = numbers[NSFilePosixPermissions] {
			self.filePermissions = permissions.stringValue
		} else {
			self.filePermissions = FileAttributes.EmptyPermissions
			print("Warning, missing permissions!")
		}

		if let fileOwner = strings[NSFileOwnerAccountName] {
			self.fileOwner = fileOwner
		} else {
			self.fileOwner = ""
		}

		if let fileGroup = strings[NSFileGroupOwnerAccountName] {
			self.fileGroup = fileGroup
		} else {
			self.fileGroup = ""
		}

		self.fileName = fileName
	}
}


enum FileAttributesError: ErrorType {
	case NumberError(key: String)
	case StringError(key: String)
	case DateError(key: String)
}
