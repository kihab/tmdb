//
//  ViewModelState.swift
//  TMDB
//
//  Created by Karim Ihab on 14/02/2024.
//

import Foundation

enum ViewModelState<T: Any> {
    case loading
    case loaded(T)
    case error(String)
    
    func isLoading() -> Bool {
        switch self {
        case .loading:
            return true
        default:
            return false
        }
    }
}
