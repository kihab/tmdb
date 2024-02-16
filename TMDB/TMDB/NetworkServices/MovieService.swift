//
//  MovirService.swift
//  TMDB
//
//  Created by Karim Ihab on 10/02/2024.
//

import Foundation

struct MovieService: MovieServiceProtocol {
    
    private let baseURL = URL(string: "https://api.themoviedb.org/3")!
    private let bearerToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxMzU1NjViYzMyNDIwNmM0ZmI5MzNhODVmNDBhOWJmYSIsInN1YiI6IjViYzMxYmFlMGUwYTI2NmU1ZDA0NTc1ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.lS_9xTda4zfMxxKoZkTxZYW_b2_7T58Oj8uxs0R065s"
    
    func fetchTrendingMovies(page: Int) async throws -> [Movie] {
        let url = baseURL.appendingPathComponent("discover/movie")
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        components.queryItems = [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "sort_by", value: "popularity.desc")
        ]
        
        guard let finalURL = components.url else {
            throw NSError(domain: "Invalid URL", code: -1, userInfo: nil)
        }
        
        
        var request = URLRequest(url: finalURL, timeoutInterval: 10.0)
        request.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NSError(domain: "Error fetching movies", code: -1, userInfo: nil)
        }
        
        
        let decodedResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
        return decodedResponse.results
    }
    
    func fetchMovieDetails(movieId: Int) async throws -> MovieDetails {
        let url = baseURL.appendingPathComponent("movie/\(movieId)")
        var request = URLRequest(url: url, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                throw NSError(domain: "Error fetching movie details", code: statusCode, userInfo: [NSLocalizedDescriptionKey: "Failed with status code \(statusCode)"])
            }

            return try JSONDecoder().decode(MovieDetails.self, from: data)
        } catch let jsonError as DecodingError {
            // This provides more insight into what went wrong during decoding
            print("Decoding error: \(jsonError.localizedDescription)")
            throw jsonError
        } catch {
            // For other errors like network issues
            print("Unexpected error: \(error.localizedDescription)")
            throw error
        }
    }

}

struct MovieResponse: Codable {
    let results: [Movie]
}

