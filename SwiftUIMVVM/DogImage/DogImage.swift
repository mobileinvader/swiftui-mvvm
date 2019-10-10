//
//  DogImage.swift
//  SwiftUIMVVM
//
//  Created by Kristijan Kralj on 10/10/2019.
//  Copyright © 2019 Kristijan Kralj. All rights reserved.
//

import SwiftUI

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

struct DogImage_Previews: PreviewProvider {
    static var previews: some View {
      DogImage(breedName: "poodle")
    }
}
