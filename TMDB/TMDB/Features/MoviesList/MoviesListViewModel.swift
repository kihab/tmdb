//
//  MovieViewModel.swift
//  TMDB
//
//  Created by Karim Ihab on 10/02/2024.
//

import Foundation

@MainActor
class MoviesListViewModel: ObservableObject {
    @Published var state: ViewModelState<[Movie]> = .loading
    private var movieService: MovieServiceProtocol
    
    init(movieService: MovieServiceProtocol = MovieService()) {
        self.movieService = movieService
    }
    
    var data: ([Movie]) {
        switch state {
        case let .loaded(data):
            return data
        case .error:
            return []
        default:
            return Movie.mock
        }
    }
    
    func loadTrendingMovies() {
        Task {
            do {
                let trendingMovies = try await movieService.fetchTrendingMovies()
                state = .loaded(trendingMovies)
            } catch {
                state = .error(error.localizedDescription)
            }
        }
    }
}
