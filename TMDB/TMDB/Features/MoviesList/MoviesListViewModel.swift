//
//  MovieViewModel.swift
//  TMDB
//
//  Created by Karim Ihab on 10/02/2024.
//

import Foundation

@MainActor
class MoviesListViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private var movieService: MovieServiceProtocol
    private var currentPage = 1
    private var canLoadMorePages = true
    
    init(movieService: MovieServiceProtocol) {
        self.movieService = movieService       
    }
    
    func loadMoreTrendingMovies(currentItem: Movie?) async {
        guard canLoadMorePages, !isLoading else { return }
        // When at the last item, loading more movies
        if currentItem == nil || movies.last?.movieId == currentItem?.movieId {
            await loadTrendingMovies()
        }
    }
    
    private func loadTrendingMovies() async {
        isLoading = true
        errorMessage = nil
        do {
            let trendingMovies = try await movieService.fetchTrendingMovies(page: currentPage)
            
            if trendingMovies.isEmpty {
                canLoadMorePages = false
            } else {
                movies.append(contentsOf: trendingMovies)
                currentPage += 1
            }
        } catch {
            errorMessage = Strings.errorLoadingMovies.localized()
        }
        //TODO:: Remove print
        print("Movie Count: \(movies.count)")
        isLoading = false
    }
}
