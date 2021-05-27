//
//  Most Emailed.swift
//  NYT Articles
//
//  Created by Raziel on 23.05.2021.
//

import SwiftUI

struct Response: Codable {
    var results: [ArticlesData]
}

struct ArticlesData: Codable {
    var id: Int
    var title: String
    var url: String
}

struct FilteredArticlesView: View {
    enum FilterType {
        case emailed, shared, viewed
    }
    enum LoadingState {
        case loading, loaded, failed
    }
    
    @State private var loadingState = LoadingState.loading
    @State private var results = [ArticlesData]()
    
    let filter: FilterType
    
    var title: String {
        switch filter {
        case .emailed:
            return "Most Emailed NYT Articles"
        case .shared:
            return "Most Shared NYT Articles"
        case .viewed:
            return "Most Viewed NYT Articles"
        }
    }
    
    var body: some View {
        NavigationView {
            if loadingState == .loaded {
                List(results, id: \.id) { item in
                    NavigationLink(destination: WebControlView(url: item.url)) {
                        VStack(alignment: .leading) {
                            Text(item.title)
                                .font(.headline)
                        }
                    }
                }
                .navigationBarTitle(title, displayMode: .inline)
            } else if loadingState == .loading {
                Text("Loading…")
            } else {
                Text("Please try again later.")
            }
        }
        .onAppear(perform: loadData)
    }
    
    func loadData() {
        
        switch filter {
        case  .emailed:
            
            guard let url = URL(string: "https://api.nytimes.com/svc/mostpopular/v2/emailed/30.json?api-key=EA1z4cIl6hneMAHgRS0OuoNUK7zTYdua") else {
                print("Invalid URL")
                return
            }
            
            let request = URLRequest(url: url)
            
            return
                URLSession.shared.dataTask(with: request) { data, response, error in
                    if let data = data {
                        if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                            DispatchQueue.main.async {
                                self.results = decodedResponse.results
                            }
                            self.loadingState = .loaded
                            return
                        }
                    }
                    self.loadingState = .failed
                    print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
                }.resume()
            
        case  .shared:
            
            guard let url = URL(string: "https://api.nytimes.com/svc/mostpopular/v2/shared/30/facebook.json?api-key=EA1z4cIl6hneMAHgRS0OuoNUK7zTYdua") else {
                print("Invalid URL")
                return
            }
            
            let request = URLRequest(url: url)
            
            return
                URLSession.shared.dataTask(with: request) { data, response, error in
                    if let data = data {
                        if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                            DispatchQueue.main.async {
                                self.results = decodedResponse.results
                            }
                            self.loadingState = .loaded
                            return
                        }
                    }
                    self.loadingState = .failed
                    print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
                }.resume()
            
        case  .viewed:
            
            guard let url = URL(string: "https://api.nytimes.com/svc/mostpopular/v2/viewed/1.json?api-key=EA1z4cIl6hneMAHgRS0OuoNUK7zTYdua") else {
                print("Invalid URL")
                return
            }
            
            let request = URLRequest(url: url)
            
            return
                URLSession.shared.dataTask(with: request) { data, response, error in
                    if let data = data {
                        if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                            DispatchQueue.main.async {
                                self.results = decodedResponse.results
                            }
                            self.loadingState = .loaded
                            return
                        }
                    }
                    self.loadingState = .failed
                    print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
                }.resume()
        }
    }
}

struct FilteredArticlesView_Previews: PreviewProvider {
    static var previews: some View {
        FilteredArticlesView(filter: .emailed)
    }
}
