//
//  ContentView.swift
//  Ingresso-Challenge
//
//  Created by Yuri Strack on 04/09/21.
//

import SwiftUI
import URLImage
import URLImageStore

struct MoviesView: View {
    
    @ObservedObject var viewModel: MoviesViewModel
    
    init(viewModel: MoviesViewModel) {
        self.viewModel = viewModel
        self.viewModel.getMovies()
    }
    
    // Config image cache
    let urlImageService = URLImageService(fileStore: URLImageFileStore(), inMemoryStore: URLImageInMemoryStore())
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.clear)
                }
                else {
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.movies) { movie in
                                NavigationLink(destination: MovieDetailView(viewModel: viewModel.didTapMovie(movie: movie))) {
                                    MovieCell(movie)
                                }
                                .buttonStyle(PlainButtonStyle())
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            }
                        }.padding(.horizontal, 4)
                    }
                }
            }
            .navigationTitle("Filmes")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(trailing: Button(action: {viewModel.showSearchView.toggle()}) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color(.primaryBlue))
                    .imageScale(.large)
            })
            .background(Color(.primaryGray).ignoresSafeArea())
        }
        .fullScreenCover(isPresented: $viewModel.showSearchView, content: {
            SearchView(viewModel: SearchViewModel(movies: viewModel.movies), isShowing: $viewModel.showSearchView)
            
        })
        .alert(isPresented: $viewModel.showErrorAlert, content: {
            Alert(title: Text("Aviso"), message: Text("Erro ao carregar os filmes"), dismissButton: .default(Text("Ok")))
        })
        .environment(\.urlImageService, urlImageService)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView(viewModel: MoviesViewModel())
    }
}
