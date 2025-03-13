//
//  RecipeRow.swift
//  RecipeApp
//
//  Created by David Seitz Jr on 3/5/25.
//

import SwiftUI
import SafariServices

import SwiftUI
import SafariServices

struct RecipeRow: View {
    let recipe: RecipeListItemViewModel
    @State private var selectedURL: URL?
    @State private var image: UIImage? = nil

    var body: some View {
        HStack {

            if let image = self.image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }

            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.headline)
                Text(recipe.cuisine)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()

            // Indicator for source/youtube URL link
            if let url = recipe.sourceURL ?? recipe.youtubeURL, let url = URL(string: url) {
                Button(action: {
                    selectedURL = url
                }) {
                    Image(systemName: (recipe.sourceURL != nil ? "arrow.up.right.square" : "play.rectangle"))
                        .foregroundColor((recipe.sourceURL != nil ? .blue : .red))
                }
            }
        }
        .padding(.vertical, 4)
        .sheet(item: $selectedURL) { url in
            // When the row is tapped, show a sheet/modal displaying the URL content.\
            SafariView(url: url)
        }
        .task {
            do {
                image = try await ImageCacheManager.image(for: recipe.photoURLSmall)
            } catch {
                print("Error occured while loading RecipeRow: \(error.localizedDescription)")
            }
        }
    }
}

struct SafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {}
}
