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
    private var currentPage = 1
    private var canLoadMorePages = true
    
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
                let trendingMovies = try await movieService.fetchTrendingMovies(page: currentPage)
                print("COUNT: \(trendingMovies.count)")
                currentPage = currentPage + 1
                
                //refactor to one sentence
                canLoadMorePages = !trendingMovies.isEmpty
                if trendingMovies.count < 20 {
                    canLoadMorePages = false
                }
                
                if case let .loaded(movies) = state {
                    state = .loaded(movies + trendingMovies)
                } else {
                    state = .loaded(trendingMovies)
                }
            } catch {
                state = .error(error.localizedDescription)
            }
        }
    }
}
