//
//  Repository.swift
//  DevSpace
//
//  Created by K Bimala Singha on 04/02/26.
//
//
//struct GitHubResponse: Decodable {
//    let items: [Repository]
//}
//
//struct Repository: Decodable {
//    let name: String
//    let description: String?
//    let stargazers_count: Int
//    let owner: Owner
//}
//
//struct Owner: Decodable {
//    let avatar_url: String
//}


import Foundation

//struct Repository {
//    let name: String
////    let ownerName: String
//    let owner: Owner
//    let description: String
////    let avatarUrl: String // We'll use a placeholder image name for now
//}
//
//struct LanguageCategory {
//    let title: String
//    let repos: [Repository]
//}
//
//struct Owner: Decodable {
//    let avatar_url: String
//}

struct SearchResult: Decodable {
    let items: [Repository]
}

struct Repository: Decodable {
    let name: String
    let description: String?
    let owner: Owner
    let html_url: String
}

struct Owner: Decodable {
    let avatarUrl: String
    
    enum CodingKeys: String, CodingKey {  //CodingKeys helps match GitHub's "avatar_url" to category names
        case avatarUrl = "avatar_url"
    }
}

struct LanguageCategory {
    let title: String
    let repos: [Repository]
}


struct RepositoryDisplay {
    let repo: Repository
    let iconUrl: String
    let language: String
}
