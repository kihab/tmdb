//
//  MovirService.swift
//  TMDB
//
//  Created by Karim Ihab on 10/02/2024.
//

import Foundation

struct MovieService: MovieServiceProtocol {

    private func performRequest<T: Decodable>(url: URL, decodingType: T.Type) async throws -> T {
        var request = URLRequest(url: url, timeoutInterval: 10.0)
        request.addValue("Bearer \(Constants.bearerToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
            throw NSError(domain: "Error fetching data",
                          code: statusCode,
                          userInfo: [NSLocalizedDescriptionKey: "Failed with status code \(statusCode)"])
        }

        return try JSONDecoder().decode(decodingType, from: data)
    }

    func fetchTrendingMovies(page: Int) async throws -> [Movie] {
        guard let url = Constants.baseURL?.appendingPathComponent("discover/movie"),
              var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw NSError(domain: "Invalid URL", code: -1, userInfo: nil)
        }
        components.queryItems = [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "sort_by", value: "popularity.desc")
        ]

        guard let finalURL = components.url else {
            throw NSError(domain: "Invalid URL", code: -1, userInfo: nil)
        }

        let decodedResponse: MovieResponse = try await performRequest(url: finalURL, decodingType: MovieResponse.self)
        return decodedResponse.results
    }

    func fetchMovieDetails(movieId: Int) async throws -> MovieDetails {
        guard let url = Constants.baseURL?.appendingPathComponent("movie/\(movieId)") else {
            throw NSError(domain: "Invalid URL", code: -1, userInfo: nil)
        }

        return try await performRequest(url: url, decodingType: MovieDetails.self)
    }
}
