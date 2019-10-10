//
//  ContentView.swift
//  SwiftUIMVVM
//
//  Created by Kristijan Kralj on 02/10/2019.
//  Copyright © 2019 Kristijan Kralj. All rights reserved.
//

import SwiftUI

struct DogListView: View {
  @ObservedObject var dogListVM = DogListViewModel()
  
  var body: some View {
    NavigationView {
      List(dogListVM.dogs, id: \.self) { dog in
        HStack {
          DogImage(breedName: dog)
          Text(dog)
        }
      }.navigationBarTitle("Dogs")
       .navigationBarItems(trailing: Button(action: {
          self.dogListVM.fetchDogs()
        }, label: {
          Text("Refresh")
        }))
    }
  }
}

struct DogListView_Previews: PreviewProvider {
  static var previews: some View {
    DogListView()
  }
}
