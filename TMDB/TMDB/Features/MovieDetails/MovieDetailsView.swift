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
        switch viewModel.state {
        case .error(_):
            Text("Something went wrong, please try again later")
        default:
            ScrollView {
                    VStack(alignment: .center, spacing: 10) {
                        // Movie Poster
                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(viewModel.data.posterPath)")) { image in
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
                        Text(viewModel.data.title)
                            .font(.title)
                            .fontWeight(.bold)

                        if let releaseDate = viewModel.data.releaseDate.split(separator: "-").first {
                            Text(String(releaseDate))
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }

                        // Movie Description
                        Text(viewModel.data.overview)
                            .font(.body)
                            .padding()
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .onAppear{
                Task {
                    await viewModel.loadMovieDetails()
                }
            }
            .navigationBarTitle("Movie Details", displayMode: .inline)
            .redacted(when: viewModel.state.isLoading())
        }

    }
}
