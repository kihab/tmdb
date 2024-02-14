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
        switch viewModel.state {
        case .error(_):
            Text("Something went wrong, please try again later")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        default:
            NavigationView {
                List(viewModel.data) { movie in
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
                .redacted(when: viewModel.state.isLoading())
            }
        }

    }
}
