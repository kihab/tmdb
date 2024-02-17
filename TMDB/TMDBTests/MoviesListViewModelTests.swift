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
}
