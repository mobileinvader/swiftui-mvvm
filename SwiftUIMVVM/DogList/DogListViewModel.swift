//  DogListViewModel.swift
//  SwiftUIMVVM
//
//  Created by Kristijan Kralj on 02/10/2019.
//  Copyright © 2019 Kristijan Kralj. All rights reserved.
//

import Foundation

class DogListViewModel: ObservableObject {
  @Published var dogs: [Dog] = [
    Dog(name: "Bulldog"),
    Dog(name: "Beagle"),
    Dog(name: "Poodle")
  ]
}
