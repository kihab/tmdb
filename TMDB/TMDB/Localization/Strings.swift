//
//  Strings.swift
//  TMDB
//
//  Created by Karim Ihab on 17/02/2024.
//

import Foundation

enum Strings: String {
    case trendingMoviesTitle = "Trending Movies"
    case errorLoadingMovies = "Failed to load movies. Please try again later."
    case errorLoadingDetails = "Something went wrong, please try again later"
    case detailsTitle = "Movie Details"
    
    func localized() -> String {
        NSLocalizedString(rawValue, comment: "")
    }
    
    func localizedWithArguments(arg: String) -> String {
        String(format: localized(), arg)
    }
}
