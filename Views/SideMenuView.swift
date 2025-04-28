import SwiftUI

struct SideMenuView: View {
    @Binding var isShowing: Bool
    @Binding var selectedCategory: String
    @Binding var customFavorites: [String]
    @Binding var savedArticles: [Article]

    @State private var newCategory: String = ""

    let onAddCategory: (String) -> Void
    let onDeleteCategory: (IndexSet) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("SwiftNews")
                .font(.largeTitle.bold())
                .padding(.top, 60)
                .padding(.horizontal)

            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    SectionHeader(title: "Sections")
                    
                    Button(action: {
                        withAnimation {
                            selectedCategory = "general"
                            isShowing = false
                        }
                    }) {
                        Label("Top Headlines", systemImage: "newspaper")
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(12)
                            .padding(.horizontal)
                    }

                    if !savedArticles.isEmpty {
                        Button(action: {
                            withAnimation {
                                selectedCategory = "SavedArticles"
                                isShowing = false
                            }
                        }) {
                            Label("Saved Articles", systemImage: "bookmark.fill")
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(12)
                                .padding(.horizontal)
                        }
                    }

                    SectionHeader(title: "Favorites")
                    
                    if customFavorites.isEmpty {
                        Text("No favorites yet.")
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                    } else {
                        ForEach(customFavorites, id: \.self) { topic in
                            Button(action: {
                                withAnimation {
                                    selectedCategory = topic
                                    isShowing = false
                                }
                            }) {
                                Label(topic.capitalized, systemImage: "star.fill")
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color(.secondarySystemBackground))
                                    .cornerRadius(12)
                                    .padding(.horizontal)
                            }
                        }
                        .onDelete(perform: onDeleteCategory)
                    }

                    HStack {
                        TextField("New category", text: $newCategory)
                            .textFieldStyle(.roundedBorder)
                            .padding(.horizontal)

                        Button(action: {
                            addCategory()
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.blue)
                                .font(.title2)
                        }
                        .padding(.trailing)
                    }
                }
                .padding(.top)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground))
        .edgesIgnoringSafeArea(.all)
    }

    private func addCategory() {
        let trimmed = newCategory.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmed.isEmpty {
            onAddCategory(trimmed)
            newCategory = ""
        }
    }
}


