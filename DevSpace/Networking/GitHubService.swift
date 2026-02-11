//
//  GitHubService.swift
//  DevSpace
//
//  Created by K Bimala Singha on 04/02/26.
//

import Foundation
import UIKit

@MainActor ///// Since GitHubService updates the UI
class GitHubService {
    static let shared = GitHubService()
    
    func fetchRepositories(for query: String, completion: @escaping ([Repository]) -> Void) {

        
        let urlString = "https://api.github.com/search/repositories?q=language:\(query)&sort=stars"  // search for repos -- REST API endpoint
        
        //now converting string to URL object
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            // closure will run AFTER the network request is completed
            if let data = data {
                do {
                    // GitHub search results are wrapped in an 'items' array
                    
                    let result = try JSONDecoder().decode(SearchResult.self, from: data)
                    DispatchQueue.main.async {
                        completion(result.items)
                    }
                } catch {
                    print("Decoding error: \(error)")
                }
            }
        }.resume()
    }
}

