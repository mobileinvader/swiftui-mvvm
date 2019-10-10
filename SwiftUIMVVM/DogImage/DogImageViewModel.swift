//
//  DogImageViewModel.swift
//  SwiftUIMVVM
//
//  Created by Kristijan Kralj on 08/10/2019.
//  Copyright © 2019 Kristijan Kralj. All rights reserved.
//

import Foundation
import Combine

class DogImageViewModel: ObservableObject {

  @Published var imageData = Data()
  
  private var firstTask: AnyCancellable?
  private var secondTask: AnyCancellable?
  
  init(breedName: String) {

    guard let url = URL(string: imageUrl(from: breedName)) else { return }

    firstTask = URLSession.shared.dataTaskPublisher(for: url)
    .map { $0.data }
    .decode(type: DogMessage<String>.self, decoder: JSONDecoder())
    .map { $0.message }
    .replaceError(with: String())
    .eraseToAnyPublisher()
    .sink { [weak self] value in
      self?.getImageData(from: value)
    }
  }

  private func getImageData(from urlString: String) {
    guard let url = URL(string: urlString) else { return }
    
    secondTask = URLSession.shared.dataTaskPublisher(for: url)
    .map { $0.data }
    .replaceError(with: Data())
    .eraseToAnyPublisher()
    .receive(on: RunLoop.main)
    .assign(to: \DogImageViewModel.imageData, on: self)
  }
  
  private func imageUrl(from name: String) -> String {
    return "https://dog.ceo/api/breed/\(name)/images/random"
  }
}
