import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = NewsViewModel()
    @State private var selectedArticle: IdentifiableURL?
    @State private var searchText = ""
    @State private var savedArticles: [Article] = []
    @State private var toastMessage: String = ""
    @State private var showToast = false

    @State private var selectedCategory: String = "general"
    @State private var customFavorites: [String] = ["F1"]
    @State private var isShowingSideMenu = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemBackground)
                    .ignoresSafeArea()

                if !isShowingSideMenu {
                    ContentView(
                        viewModel: viewModel,
                        selectedArticle: $selectedArticle,
                        searchText: $searchText,
                        savedArticles: $savedArticles,
                        onSave: saveSavedArticles,
                        showToastMessage: showToastMessage,
                        selectedCategory: selectedCategory
                    )
                }

                if isShowingSideMenu {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation {
                                isShowingSideMenu = false
                            }
                        }

                    SideMenuView(
                        isShowing: $isShowingSideMenu,
                        selectedCategory: $selectedCategory,
                        customFavorites: $customFavorites,
                        savedArticles: $savedArticles,
                        onAddCategory: { category in addCategory(category) },
                        onDeleteCategory: deleteFavorite
                    )
                    .transition(.move(edge: .leading))
                    .zIndex(1)
                }
            }
            .navigationTitle(selectedCategoryTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        withAnimation {
                            isShowingSideMenu.toggle()
                        }
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .imageScale(.large)
                    }
                }
            }
        }
        .onAppear {
            loadFavorites()
            loadSavedArticles()
        }
    }

    // MARK: - Helper Computed Property

    private var selectedCategoryTitle: String {
        if selectedCategory == "general" {
            return "Top Headlines"
        } else if selectedCategory == "SavedArticles" {
            return "Saved Articles"
        } else {
            return selectedCategory.capitalized
        }
    }

    // MARK: - Helper Functions

    private func saveSavedArticles() {
        if let encoded = try? JSONEncoder().encode(savedArticles) {
            UserDefaults.standard.set(encoded, forKey: "savedArticles")
        }
    }

    private func loadSavedArticles() {
        if let data = UserDefaults.standard.data(forKey: "savedArticles"),
           let decoded = try? JSONDecoder().decode([Article].self, from: data) {
            savedArticles = decoded
        }
    }

    private func saveFavorites() {
        if let encoded = try? JSONEncoder().encode(customFavorites) {
            UserDefaults.standard.set(encoded, forKey: "customFavorites")
        }
    }

    private func loadFavorites() {
        if let data = UserDefaults.standard.data(forKey: "customFavorites"),
           let decoded = try? JSONDecoder().decode([String].self, from: data) {
            customFavorites = decoded
        }
    }

    private func addCategory(_ category: String) {
        let trimmed = category.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmed.isEmpty && !customFavorites.contains(trimmed) {
            customFavorites.append(trimmed)
            saveFavorites()
        }
    }

    private func deleteFavorite(at offsets: IndexSet) {
        customFavorites.remove(atOffsets: offsets)
        saveFavorites()
    }

    private func showToastMessage(_ message: String) {
        toastMessage = message
        showToast = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            showToast = false
        }
    }
}

