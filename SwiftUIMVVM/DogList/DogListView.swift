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

struct DogImage: View {
  @ObservedObject private var viewModel: DogImageViewModel
  
  init(breedName: String) {
    viewModel = DogImageViewModel(breedName: breedName)
  }
  
  var body: some View {
    Image(uiImage: (viewModel.imageData.count == 0) ? UIImage(named: "dog")!
      : UIImage(data: viewModel.imageData)!)
      .resizable()
      .scaledToFill()
      .frame(width: 60, height: 60)
      .clipped()
      .overlay(
        RoundedRectangle(cornerRadius: 60)
          .strokeBorder(style: StrokeStyle(lineWidth: 1))
          .foregroundColor(Color.black))
      .cornerRadius(60)
  }
}
