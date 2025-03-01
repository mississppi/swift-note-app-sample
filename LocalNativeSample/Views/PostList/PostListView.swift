import SwiftUI

struct PostListView: View {
    @ObservedObject var viewModel: PostViewModel
    @Binding var selectedPostID: UUID?
    
    var body: some View {
        NavigationView {
            List(viewModel.posts) { post in
                Text(post.title ?? "No title")
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(selectedPostID == post.id ? Color.gray.opacity(0.2) : Color.clear)
                    .onTapGesture {
                        print("taped")
                        selectedPostID = post.id
                    }
            }
        }
    }
}
