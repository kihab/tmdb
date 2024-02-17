//
//  MovieRow.swift
//  TMDB
//
//  Created by Karim Ihab on 15/02/2024.
//

import SwiftUI

struct MovieRow: View {
    let movie: Movie
    
    var body: some View {
        NavigationLink(destination: MovieDetailsView(viewModel: MovieDetailsViewModel(movieId: movie.movieId))) {
            HStack(spacing: 12) {
                // Movie Thumbnail Image
                AsyncImage(url: URL(string: Constants.thumbnailURL + movie.posterPath)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 50, height: 75)
                .cornerRadius(4)
                .aspectRatio(contentMode: .fill)
                
                // Movie Title and Overview
                VStack(alignment: .leading) {
                    Text(movie.title)
                        .font(.headline)
                    Text(movie.overview)
                        .font(.subheadline)
                        .lineLimit(3)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

