//
//  ImageDownloader.swift
//  SwiftUIMVVM
//
//  Created by Kristijan Kralj on 08/10/2019.
//  Copyright © 2019 Kristijan Kralj. All rights reserved.
//

import Foundation
import Combine

class ImageDownloader: ObservableObject {

  @Published var imageData: Data?
  
  private var task: AnyCancellable?
  
  init(breedName: String) {
    guard let url = URL(string: imageUrl(from: breedName)) else { return }
    
    task = URLSession.shared.dataTaskPublisher(for: url)
    .map { $0.data }
    .replaceError(with: Data())
    .eraseToAnyPublisher()
    .receive(on: RunLoop.main)
    .assign(to: \ImageDownloader.imageData, on: self)
  }

  private func imageUrl(from name: String) -> String {
    return "https://dog.ceo/api/breed/\(name)/images/random"
  }
}
