//
//  MoviewDetailsViewModel.swift
//  TMDB
//
//  Created by Karim Ihab on 10/02/2024.
//

import Foundation

@MainActor
class MovieDetailsViewModel: ObservableObject {
    @Published var state: ViewModelState<MovieDetails> = .loading
    private var movieService: MovieServiceProtocol
    private let movieId: Int

    init(movieService: MovieServiceProtocol = MovieService(), movieId: Int) {
        self.movieService = movieService
        self.movieId = movieId
    }

    var data: (MovieDetails) {
        switch state {
        case let .loaded(data):
            return data
        default:
            return MovieDetails.mock
        }
    }

    func loadMovieDetails() async {
        do {
            let movieDetails = try await movieService.fetchMovieDetails(movieId: movieId)
            state = .loaded(movieDetails)
        } catch {
            state = .error(error.localizedDescription)
        }
    }
}
