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
        loadMoreTrendingMovies(currentItem: nil) // Initial load
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
    
    func loadMoreTrendingMovies(currentItem: Movie?) {
        guard let movie = currentItem else {
            loadTrendingMovies()
            return
        }
        
        let thresholdIndex = data.index(data.endIndex, offsetBy: -2)
        if data.firstIndex(where: { $0.id == movie.id }) == thresholdIndex {
            loadTrendingMovies()
        }
    }
    
    func loadTrendingMovies() {
        guard canLoadMorePages else { return }

        Task {
            do {
                let trendingMovies = try await movieService.fetchTrendingMovies(page: currentPage)
                
                if trendingMovies.isEmpty || trendingMovies.count < 20 {
                    canLoadMorePages = false
                } else {
                    if case let .loaded(movies) = state {
                        state = .loaded(movies + trendingMovies)
                    } else {
                        state = .loaded(trendingMovies)
                    }
                    currentPage += 1
                }
                
            } catch {
                state = .error(error.localizedDescription)
            }
        }
    }
}
