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

    var body: some View {
        switch viewModel.state {
        case .error(_):
            Text("Something went wrong, please try again later")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        default:
                List(viewModel.data) { movie in
                    MovieRow(movie: movie)
                        .onAppear {
                            viewModel.loadMoreTrendingMovies(currentItem: movie)
                        }
                }
                //See if you can add this to the item itself.
                .redacted(when: viewModel.state.isLoading())
                .navigationBarTitle("Trending Movies", displayMode: .inline)

        }

    }
}
