//
//  ContentView.swift
//  SwiftUIMVVM
//
//  Created by Kristijan Kralj on 02/10/2019.
//  Copyright © 2019 Kristijan Kralj. All rights reserved.
//

import SwiftUI

struct DogListView: View {
  var dogs: [Dog] = [
    Dog(name: "Bulldog"),
    Dog(name: "Beagle"),
    Dog(name: "Poodle")
  ]
  
  var body: some View {
    NavigationView {
      List(dogs) { dog in
        HStack {
          Image(uiImage: UIImage(named: "dog")!)
          .resizable()
          .scaledToFill()
          .frame(width: 60, height: 60)
          .overlay(
              RoundedRectangle(cornerRadius: 60)
                  .strokeBorder(style: StrokeStyle(lineWidth: 1))
                .foregroundColor(Color.black))
          .cornerRadius(60)
          Text(dog.name)
        }
      }.navigationBarTitle("Dogs")
    }
  }
}

struct DogListView_Previews: PreviewProvider {
  static var previews: some View {
    DogListView()
  }
}
