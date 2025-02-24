import SwiftUI

struct PostDetailView: View {
    @ObservedObject var viewModel: PostViewModel
    var post: Post
    @State private var title: String

    init(viewModel: PostViewModel, post: Post) {
        self.viewModel = viewModel
        self.post = post
        _title = State(initialValue: post.title ?? "")
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            TextField("Enter title ", text: $title)
                .onChange(of: title) {
                    saveChanges()
                }
                
                Divider()
                
                ScrollView {
                    Text("nooo content")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                }
        }
        .onAppear {
            title = post.title ?? ""
        }
        .onChange(of: post.id) {
            title = post.title ?? ""
        }
    }
    
    private func saveChanges() {
        post.title = title
        viewModel.updatePost(post)
    }
}
