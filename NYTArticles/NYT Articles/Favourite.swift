//
//  Favourite.swift
//  NYT Articles
//
//  Created by Raziel on 23.05.2021.
//

import SwiftUI

struct Favourite: View {
    
    var body: some View {
        List {
            Text("Articles that you like will be reflected here")
        }
    }
}

struct WebControlView: View {
    
    @State private var favouriteStatus = false
    
    var url: String
    
    var body: some View {
        NavigationView {
            VStack {
                WebView(url: url)
                    .navigationBarItems(trailing:
                        Button(action: {
                            favouriteStatus.toggle()
                        }) {
                            Image(systemName: favouriteStatus == true ? "heart.fill" : "heart")
                                .foregroundColor(.red)
                        }
                    )
            }
        }
    }
}



struct Favourite_Previews: PreviewProvider {
    static var previews: some View {
        Favourite()
    }
}
