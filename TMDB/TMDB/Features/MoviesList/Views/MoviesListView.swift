//
//  MovieListView.swift
//  TMDB
//
//  Created by Karim Ihab on 10/02/2024.
//

import SwiftUI


import SwiftUI

struct MoviesListView: View {
    @StateObject private var viewModel: MoviesListViewModel = MoviesListViewModel()
    
    let imageBaseURL = "https://image.tmdb.org/t/p/w92" // Adjust the size as needed

    var body: some View {
        NavigationView {
            List(viewModel.movies) { movie in
                NavigationLink(destination: MovieDetailsView(viewModel: MovieDetailsViewModel(movieId: movie.id))) {
                    HStack(spacing: 12) {
                        // Movie Thumbnail Image
                        AsyncImage(url: URL(string: "\(imageBaseURL)\(movie.posterPath )")) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 50, height: 75)
                        .cornerRadius(4)
                        .aspectRatio(contentMode: .fill)

                        // Movie Title and Overview
                        VStack(alignment: .leading) {
                            Text(movie.title)
                                .font(.headline)
                            Text(movie.overview)
                                .font(.subheadline)
                                .lineLimit(3)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Trending Movies")
            .onAppear {
                    viewModel.loadTrendingMovies()
            }
        }
    }
}

struct MoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView()
    }
}


//struct MoviesListView: View {
//    @StateObject private var viewModel: MoviesListViewModel = MoviesListViewModel()
//
//    var body: some View {
//        NavigationView {
//            List(viewModel.movies) { movie in
//                NavigationLink(destination: MovieDetailsView(viewModel: MovieDetailsViewModel(movieId: movie.id))) {
//                    VStack(alignment: .leading) {
//                        Text(movie.title).font(.headline)
//                        Text(movie.overview).font(.subheadline).lineLimit(3)
//                    }
//                }
//            }
//            .navigationTitle("Trending Movies")
//            .onAppear {
//                viewModel.loadTrendingMovies()
//            }
//        }
//    }
//}
//
//struct MoviesListView_Previews: PreviewProvider {
//    static var previews: some View {
//        MoviesListView()
//    }
//}
