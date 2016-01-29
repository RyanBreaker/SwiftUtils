//
//  main.swift
//  ls
//
//  Created by Ryan Breaker on 1/21/16.
//  Copyright © 2016 Ryan Breaker. All rights reserved.
//

import Foundation


/// File manager
let fManager = NSFileManager.defaultManager()

///  Current working directory and its contents
let cwd = fManager.currentDirectoryPath
let cwdContents: [String]



do {
	cwdContents = try fManager.contentsOfDirectoryAtPath(cwd)
		.sort({ s1, s2 in return s1 < s2 })
} catch let error as NSError {
	print(error.localizedDescription)
	exit(1)
}


var outString = ""

for file in cwdContents {
}

print(outString, terminator: "")

