//  DogListViewModel.swift
//  SwiftUIMVVM
//
//  Created by Kristijan Kralj on 02/10/2019.
//  Copyright © 2019 Kristijan Kralj. All rights reserved.
//

import Foundation
import Combine
import CoreData

class DogListViewModel: ObservableObject {
  @Published var dogs: [String] = ["bulldog", "beagle", "poodle"]
  
  var objectContext: NSManagedObjectContext?
  
  private let dogApiUrl = "https://dog.ceo/api/breeds/list/random/10"
  private var task: AnyCancellable?
  
  
  func fetchDogs() {
    guard let url = URL(string: dogApiUrl) else { return }
    
    task = URLSession.shared.dataTaskPublisher(for: url)
      .map { $0.data }
      .decode(type: DogMessage<[String]>.self, decoder: JSONDecoder())
      .map { $0.message }
      .replaceError(with: [String]())
      .eraseToAnyPublisher()
      .receive(on: RunLoop.main)
      .assign(to: \DogListViewModel.dogs, on: self)
  }
  
  func saveDogs() {
    guard let context = objectContext else { return }
    
    for dog in dogs {
      let managed = Dog(context: context)
      managed.name = dog
    }
    context.saveContext()
  }
  
  func loadDogs() {
    guard let context = objectContext else { return }
    
    let fetchRequest = NSFetchRequest<Dog>(entityName: "Dog")
    
    if let result = try? context.fetch(fetchRequest) {
      dogs.removeAll()
      for fetchedDog in result.compactMap({ $0.name }) {
        dogs.append(fetchedDog)
      }
    }
  }
}
