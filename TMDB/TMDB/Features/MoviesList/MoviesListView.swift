//
//  MovieListView.swift
//  TMDB
//
//  Created by Karim Ihab on 10/02/2024.
//

import SwiftUI

struct MoviesListView: View {
    @StateObject var viewModel: MoviesListViewModel
    @State private var searchQuery = ""

    var body: some View {
        if viewModel.isLoading && viewModel.movies.isEmpty {
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        } else if let errorMessage = viewModel.errorMessage {
            Text(errorMessage)
                .foregroundColor(.red)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        } else {
            List(viewModel.filteredMovies) { movie in
                MovieRow(movie: movie)
                    .onAppear {
                        Task {
                            await viewModel.loadMoreTrendingMovies(currentItem: movie)
                        }
                    }
            }
            .searchable(text: $searchQuery, prompt: "Search Movies")
            .onChange(of: searchQuery) {
                viewModel.updateSearch(searchString: searchQuery)
            }
            .navigationBarTitle(Strings.trendingMoviesTitle.localized(), displayMode: .inline)
        }
    }
}
