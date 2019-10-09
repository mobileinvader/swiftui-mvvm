//  DogListViewModel.swift
//  SwiftUIMVVM
//
//  Created by Kristijan Kralj on 02/10/2019.
//  Copyright © 2019 Kristijan Kralj. All rights reserved.
//

import Foundation
import Combine

class DogListViewModel: ObservableObject {
  let dogApiUrl = "https://dog.ceo/api/breeds/list/random/10"
  private var task: AnyCancellable?
  
  @Published var dogs: [String] = ["bulldog", "beagle", "poodle"]
  
  func fetchDogs() {
    task = URLSession.shared.dataTaskPublisher(for: URL(string: dogApiUrl)!)
      .map { $0.data }
      .decode(type: DogMessage.self, decoder: JSONDecoder())
      .map { $0.message }
      .replaceError(with: [String]())
      .eraseToAnyPublisher()
      .receive(on: RunLoop.main)
      .assign(to: \DogListViewModel.dogs, on: self)
  }
}
