//
//  ContentView.swift
//  NYT Articles
//
//  Created by Raziel on 23.05.2021.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            FilteredArticlesView(filter: .emailed)
                .tabItem {
                    Image(systemName: "folder")
                    Text("Emailed")
                }
            FilteredArticlesView(filter: .shared)
                .tabItem {
                    Image(systemName: "folder")
                    Text("Shared")
                }
            FilteredArticlesView(filter: .viewed)
                .tabItem {
                    Image(systemName: "folder")
                    Text("Viewed")
                }
            Favourite()
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favourite")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
