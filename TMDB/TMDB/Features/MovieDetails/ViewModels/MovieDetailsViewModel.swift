//
//  MoviewDetailsViewModel.swift
//  TMDB
//
//  Created by Karim Ihab on 10/02/2024.
//

import Foundation

@MainActor
class MovieDetailsViewModel: ObservableObject {
    @Published var movieDetails: MovieDetails?
    private var movieService: MovieServiceProtocol
    private let movieId: Int
    
    init(movieService: MovieServiceProtocol = MovieService(), movieId: Int) {
        self.movieService = movieService
        self.movieId = movieId
        loadMovieDetails()
    }
    
    func loadMovieDetails() {
        Task {
            do {
                self.movieDetails = try await movieService.fetchMovieDetails(movieId: movieId)
            } catch {
                print(error)
            }
        }
    }
}

