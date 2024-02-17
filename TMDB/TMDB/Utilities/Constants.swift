//
//  Constants.swift
//  TMDB
//
//  Created by Karim Ihab on 12/02/2024.
//

import Foundation

struct Constants {
    static let baseURL = URL(string: "https://api.themoviedb.org/3")

    static let bearerToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxMzU1NjViYzMyNDIwNmM0ZmI5MzNhODVmNDBhOWJmYSIsInN1YiI6IjViYzMxYmFlMGUwYTI2NmU1ZDA0NTc1ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.lS_9xTda4zfMxxKoZkTxZYW_b2_7T58Oj8uxs0R065s"
    
    static let imageBaseURL = "https://image.tmdb.org/t/p"
    static let thumbnailURL = "\(imageBaseURL)/w92"
    static let posterURL = "\(imageBaseURL)/w500"
    
}
