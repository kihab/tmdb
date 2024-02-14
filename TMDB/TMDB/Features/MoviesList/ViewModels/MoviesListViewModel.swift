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
    private var movieService: MovieServiceProtocol
    
    init(movieService: MovieServiceProtocol = MovieService()) {
        self.movieService = movieService
    }
    
    func loadTrendingMovies() {
        Task {
            do {
                self.movies = try await movieService.fetchTrendingMovies()
            } catch {
                print(error)
            }
        }
    }
}
