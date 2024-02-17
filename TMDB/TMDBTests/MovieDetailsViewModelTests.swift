//  MovieDetailsViewModelTests.swift
//  TMDBTests
//
//  Created by Karim Ihab on 17/02/2024.

import XCTest
@testable import TMDB

@MainActor
final class MovieDetailsViewModelTests: XCTestCase {
    var viewModel: MovieDetailsViewModel!
    var movieServiceMock: MovieServiceMock!

    override func setUp() {
        super.setUp()
        movieServiceMock = MovieServiceMock()
    }

    override func tearDown() {
        viewModel = nil
        movieServiceMock = nil
        super.tearDown()
    }

    func testSuccessfulLoadMovieDetails() async {
        // Given
        movieServiceMock.movieDetailsToReturn = MovieDetails.mock

        // When
        viewModel = MovieDetailsViewModel(movieService: movieServiceMock, movieId: 1)
        await viewModel.loadMovieDetails()

        // Then
        switch viewModel.state {
        case .loaded(let movieDetails):
            XCTAssertEqual(movieDetails.title,
                           MovieDetails.mock.title, "Loaded movie details should match expected mock data.")
        default:
            XCTFail("State should be .loaded after successfully loading movie details.")
        }
    }

    func testLoadMovieDetailsWithError() async {
        // Given
        let expectedErrorMessage = "Failed to fetch movie details."
        movieServiceMock.errorToThrow = NSError(domain: "TestError", code: 1,
                                                userInfo: [NSLocalizedDescriptionKey: expectedErrorMessage])

        // When
        viewModel = MovieDetailsViewModel(movieService: movieServiceMock, movieId: 1)
        await viewModel.loadMovieDetails()

        // Then
        switch viewModel.state {
        case .error(let errorMessage):
            XCTAssertEqual(errorMessage, expectedErrorMessage, "Error message should match expected error.")
        default:
            XCTFail("State should be .error after failing to load movie details.")
        }
    }

    func testInitialLoadingState() {
        // Given
        viewModel = MovieDetailsViewModel(movieService: movieServiceMock, movieId: 1)

        // Then
        switch viewModel.state {
        case .loading:
            // Expected initial state is loading
            XCTAssertTrue(true)
        default:
            XCTFail("Initial state should be .loading before movie details are loaded.")
        }
    }
}
