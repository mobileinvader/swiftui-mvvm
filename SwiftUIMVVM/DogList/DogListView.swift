//
//  ContentView.swift
//  SwiftUIMVVM
//
//  Created by Kristijan Kralj on 02/10/2019.
//  Copyright © 2019 Kristijan Kralj. All rights reserved.
//

import SwiftUI

struct DogListView: View {
  @Environment(\.managedObjectContext) var managedObjectContext
  
  @ObservedObject var dogListVM = DogListViewModel()
  
  var body: some View {
    NavigationView {
      List {
        ForEach(dogListVM.dogs, id: \.self) { dog in
          HStack {
            DogImage(breedName: dog)
            Text(dog)
          }
        }
      }
      .navigationBarTitle("Dogs")
      .navigationBarItems(leading: HStack {
        NavigationButton(text: "Save", tapAction: self.dogListVM.saveDogs)
        NavigationButton(text: "Load", tapAction: self.dogListVM.loadDogs)
        }
        , trailing: NavigationButton(text: "Refresh", tapAction: self.dogListVM.fetchDogs))
    }.onAppear
      {
        self.dogListVM.objectContext = self.managedObjectContext
    }
  }
}

struct NavigationButton: View {
  let text: String
  let tapAction: () -> Void
  
  var body: some View {
    Button(action: tapAction, label: {
      Text(text)
    })
  }
}

struct DogListView_Previews: PreviewProvider {
  static var previews: some View {
    DogListView()
  }
}
