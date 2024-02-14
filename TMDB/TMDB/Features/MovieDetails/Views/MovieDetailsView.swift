//
//  MoviewDetailsView.swift
//  TMDB
//
//  Created by Karim Ihab on 10/02/2024.
//

import SwiftUI

struct MovieDetailsView: View {
    @ObservedObject var viewModel: MovieDetailsViewModel

    var body: some View {
        ScrollView {
            if let movieDetails = viewModel.movieDetails {
                VStack(alignment: .center, spacing: 10) {
                    // Movie Poster
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movieDetails.posterPath)")) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .scaledToFit()
                    .frame(width: 200, height: 300)
                    .cornerRadius(8)
                    .shadow(radius: 7)
                    .padding(.top, 20)

                    // Movie Title and Year
                    Text(movieDetails.title)
                        .font(.title)
                        .fontWeight(.bold)

                    if let releaseDate = movieDetails.releaseDate.split(separator: "-").first {
                        Text(String(releaseDate))
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    // Movie Description
                    Text(movieDetails.overview)
                        .font(.body)
                        .padding()
                }
                .frame(maxWidth: .infinity, alignment: .center)
            } else {
                Text("Loading...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
        }
        .navigationTitle("Movie Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
