//
//  main.swift
//  ls
//
//  Created by Ryan Breaker on 1/21/16.
//  Copyright © 2016 Ryan Breaker. All rights reserved.
//

import Foundation
import OptionKit


let fManager = NSFileManager.defaultManager()

let cwd = fManager.currentDirectoryPath
let cwdContents = (try! fManager.contentsOfDirectoryAtPath(cwd))
	.sort( { s1, s2 in return s1 < s2 } )  // Sort alphabetically


var outString = ""

for file in cwdContents {
	let attributes = try! fManager.attributesOfItemAtPath(file)
	let fileSize = attributes["NSFileSize"] as! Int
	
	outString += "\(fileSize)\t\(file)\n"
}


print(outString, terminator: "")
