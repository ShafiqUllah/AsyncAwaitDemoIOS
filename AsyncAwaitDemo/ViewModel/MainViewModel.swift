//
//  MainViewModel.swift
//  AsyncAwaitDemo
//
//  Created by Shafiq  Ullah on 11/21/23.
//

import Foundation

class MainViewModel : ObservableObject{
    @Published var user : GitUser?
    
    
    func getUser() async throws -> GitUser {
        let apiEndpoint = "https://api.github.com/users/twostraws"
        guard let url = URL(string: apiEndpoint) else{
            throw GitError.GitURLNotFound
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
            throw GitError.GitInvalidResponse
        }
        
        do{
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(GitUser.self, from: data)
        }catch{
            throw GitError.GitInvalidData
        }
        
                
    }
}
