//
//  main.swift
//  ls
//
//  Created by Ryan Breaker on 1/21/16.
//  Copyright © 2016 Ryan Breaker. All rights reserved.
//

import Foundation
import OptionKit



internal struct FileAttributes {
	let fileName: String
	let fileSize: UInt64

	init(_ fileName: String, _ fileAttributes: [String: AnyObject]?) throws {
		guard let fileAttributesUnwrapped = fileAttributes
			else {
				throw FileAttributesError.NilFileAttributes
		}

		guard let fileSizeAnyObject = fileAttributesUnwrapped["NSFileSize"]
			else {
				throw FileAttributesError.DictionaryAccessFailed(key: "NSFileSize")
		}

		guard let fileSize = fileSizeAnyObject as? UInt64
			else {
				throw FileAttributesError.FailedDowncast
		}

		self.fileName = fileName
		self.fileSize = fileSize
	}
}

enum FileAttributesError: ErrorType {
	case NilFileAttributes
	case DictionaryAccessFailed(key: String)
	case FailedDowncast
}



let fManager = NSFileManager.defaultManager()

let cwd = fManager.currentDirectoryPath
let cwdContents: [String]

do {
	cwdContents = try fManager.contentsOfDirectoryAtPath(cwd)
		.sort( { s1, s2 in return s1 < s2 } )
} catch let error as NSError {
	print(error.localizedDescription)
	exit(1)
}


var outString = ""

for file in cwdContents {
}


print(outString, terminator: "")


