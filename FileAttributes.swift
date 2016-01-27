//
//  FileAttributes.swift
//  SwiftUtils
//
//  Created by Ryan Breaker on 1/26/16.
//  Copyright © 2016 Ryan Breaker. All rights reserved.
//

import Foundation


struct FileAttributes {
	let fileName: String
	let fileSize: UInt64
	var fileSizeKB: UInt64 {
		return fileSize / 1024
	}
	
	init(name: String, attributes: [String: AnyObject]) throws {
		guard let size = attributes["NSFileSize"] as? UInt64
			else {
				throw FileAttributesError(message: "NSFileSize")
		}
		
		self.fileName = name
		self.fileSize = size
	}
}


struct FileAttributesError: ErrorType {
	let message: String
}
