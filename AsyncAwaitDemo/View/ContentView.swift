//
//  ContentView.swift
//  AsyncAwaitDemo
//
//  Created by Shafiq  Ullah on 11/21/23.
//

import SwiftUI

struct ContentView: View {
//    https://api.github.com/users/twostraws
    
    @StateObject var viewModel = MainViewModel()
    
    
    var body: some View {
        VStack(spacing: 20){
            
            AsyncImage(url: URL(string: viewModel.user?.avatarUrl ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
            } placeholder: {
                Circle()
                    .foregroundColor(.gray)
                    
            }
            .frame(width: 120, height: 120, alignment: .center)

            
            Text(viewModel.user?.name ?? "Name")
                .bold()
                .font(.title3)
            
            Text(viewModel.user?.bio ?? "This is bio")
                .padding()
            
            Spacer()
        }
        .padding()
        .task {
            do{
                viewModel.user =  try await viewModel.getUser()
            }catch GitError.GitInvalidData{
                print("GitInvalidData Error happened")
            }catch GitError.GitInvalidResponse{
                print("GitInvalidResponse Error happened")
            }catch GitError.GitURLNotFound{
                print("GitURLNotFound Error happened")
            }
            catch {
                print("Unknown Error happened")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
