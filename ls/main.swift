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

print(fManager.currentDirectoryPath)
print(try! fManager.contentsOfDirectoryAtPath(fManager.currentDirectoryPath))
