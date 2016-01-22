//
//  main.swift
//  SwiftUtils
//
//  Created by Ryan Breaker on 1/18/16.
//  Copyright © 2016 Ryan Breaker. All rights reserved.
//

import Foundation
import OptionKit

let opt_b = Option(trigger: .Short("b"), helpDescription: "Number the non-blank output lines, starting at 1.")
let opt_n = Option(trigger: .Short("n"), helpDescription: "Number the output lines, starting at 1.")
let optionParser = OptionParser(definitions: [opt_b, opt_n])

var numberLines = false
var numberAllLines = false

let (options, rest): ParseData
do {
	(options, rest) = try optionParser.parse(Array(Process.arguments[1..<Process.arguments.count]))
} catch OptionKitError.InvalidOption(let description) {
	print(description)
	exit(1)
}

for (opt, _) in options {
	switch opt {
	case opt_b:
		numberLines = true
		break
	
	case opt_n:
		numberAllLines = true
		break
	
	default:
		if opt.trigger.debugDescription == "[-h|--help]" {
			print(optionParser.helpStringForCommandName("cat"))
			exit(0)
		}
	}
}


let fManager = NSFileManager.defaultManager()

var lineNumber = 1
var outString  = ""

// Iterate through remaining arguments (filenames)
for arg in rest {
	if fManager.fileExistsAtPath(arg) {
		if fManager.isReadableFileAtPath(arg) {
			let s = try! String(contentsOfFile: arg, encoding: NSUTF8StringEncoding)
			if numberAllLines {
				outString += "     \(lineNumber++)\t" + s
			} else {
				outString += s
			}
		} else {
			print("Permission denied, cannot read file \(arg).")
		}
	} else {
		print("Error: File `\(arg)' does not exist.")
	}
}


// Push out outString
print(outString, terminator: "")
