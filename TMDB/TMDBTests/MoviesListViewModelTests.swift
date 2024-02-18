//
//  MoviesListViewModelTests.swift
//  TMDBTests
//
//  Created by Karim Ihab on 17/02/2024.
//

import XCTest
@testable import TMDB

@MainActor
final class MoviesListViewModelTests: XCTestCase {
    var viewModel: MoviesListViewModel!
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

    // Testing the initial movies load
    func testInitialLoad() async {
        movieServiceMock.moviesToReturn = Movie.mock
        viewModel = MoviesListViewModel(movieService: movieServiceMock)

        await viewModel.loadMoreTrendingMovies(currentItem: nil)

        XCTAssertEqual(viewModel.movies.count, Movie.mock.count)
    }

    // Testing error handling
    func testErrorHandling() async {
        movieServiceMock.errorToThrow = NSError(domain: "TestError", code: -1, userInfo: nil) // Simulate an error
        viewModel = MoviesListViewModel(movieService: movieServiceMock)

        await viewModel.loadMoreTrendingMovies(currentItem: nil)

        XCTAssertNotNil(viewModel.errorMessage, "ViewModel should have an error message after a failed load.")
        XCTAssertTrue(viewModel.movies.isEmpty, "Movies array should be empty after a failed load.")
    }

    // Testing isLoading flag behavior
    func testIsLoadingFlagBehavior() async {
        viewModel = MoviesListViewModel(movieService: movieServiceMock)

        // Before loading
        XCTAssertFalse(viewModel.isLoading, "ViewModel should not be in loading state before loading.")

        await viewModel.loadMoreTrendingMovies(currentItem: nil)

        // After loading
        XCTAssertFalse(viewModel.isLoading, "ViewModel should not be in loading state after loading.")
    }

    // Testing search filters movies correctly
    func testSearchFiltersMoviesCorrectly() async {
        // Given
        let mockMovies = [
            Movie(movieId: 1, title: "Action Movie", overview: "", posterPath: ""),
            Movie(movieId: 2, title: "Comedy Movie", overview: "", posterPath: ""),
            Movie(movieId: 3, title: "Drama Movie", overview: "", posterPath: "")
        ]
        movieServiceMock.moviesToReturn = mockMovies
        viewModel = MoviesListViewModel(movieService: movieServiceMock)

        // When initially loading movies
        await viewModel.loadMoreTrendingMovies(currentItem: nil)

        // And then updating the search query to match only one movie
        viewModel.updateSearch(searchString: "Action")

        // Then only the matching movie should be in the filtered list
        XCTAssertEqual(viewModel.filteredMovies.count, 1,
                       "Filtered movies should only include movies that match the search query.")
        XCTAssertEqual(viewModel.filteredMovies.first?.title,
                       "Action Movie", "Filtered movie should be the one that matches the search query.")
    }

    // Testing search requires at least three characters to filter
    func testSearchRequiresThreeCharacters() async {
        // Given
        movieServiceMock.moviesToReturn = Movie.mock
        viewModel = MoviesListViewModel(movieService: movieServiceMock)
        await viewModel.loadMoreTrendingMovies(currentItem: nil)

        // When updating the search query with less than three characters
        viewModel.updateSearch(searchString: "Ac")

        // Then no filtering should occur, and all movies should be shown
        XCTAssertEqual(viewModel.filteredMovies.count, Movie.mock.count,
                       "Filtered movies should include all movies if search query is less than three characters.")
    }
}
