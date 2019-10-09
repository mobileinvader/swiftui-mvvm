//
//  Dog.swift
//  SwiftUIMVVM
//
//  Created by Kristijan Kralj on 02/10/2019.
//  Copyright © 2019 Kristijan Kralj. All rights reserved.
//

import Foundation

struct GenericDogMessage<T: Codable>: Codable {
  let message: T
  let status: String
}

struct DogMessage: Codable {
  let message: [String]
  let status: String
}
