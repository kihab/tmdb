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
    @Published var filteredMovies: [Movie] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private var movieService: MovieServiceProtocol
    private var currentPage = 1
    private var canLoadMorePages = true
    private var searchString: String = "" {
        didSet {
            filterMovies()
        }
    }

    init(movieService: MovieServiceProtocol) {
        self.movieService = movieService
        Task {
            await loadMoreTrendingMovies(currentItem: nil)
        }
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
                filterMovies()
                currentPage += 1
            }
        } catch {
            errorMessage = Strings.errorLoadingMovies.localized()
        }
        isLoading = false
    }

    func updateSearch(searchString: String) {
        self.searchString = searchString
    }

    private func filterMovies() {
        if searchString.count >= 3 {
            filteredMovies = movies.filter { $0.title.lowercased().contains(searchString.lowercased()) }
        } else {
            filteredMovies = movies
        }
    }
}
