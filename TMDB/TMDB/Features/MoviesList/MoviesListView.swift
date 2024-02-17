//
//  MovieListView.swift
//  TMDB
//
//  Created by Karim Ihab on 10/02/2024.
//

import SwiftUI


import SwiftUI

struct MoviesListView: View {
    @StateObject var viewModel: MoviesListViewModel

    var body: some View {
        if viewModel.isLoading && viewModel.movies.isEmpty {
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        } else if let errorMessage = viewModel.errorMessage {
            Text(errorMessage)
                .foregroundColor(.red)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        } else {
            List(viewModel.movies) { movie in
                MovieRow(movie: movie)
                    .onAppear {
                        Task {
                            await viewModel.loadMoreTrendingMovies(currentItem: movie)
                        }
                    }
            }
            .onAppear{
                Task {
                    await viewModel.loadMoreTrendingMovies(currentItem: nil)
                }
            }
            .navigationBarTitle("Trending Movies", displayMode: .inline)
        }
    }
}
