import SwiftUI

struct PostDetailView: View {
    @ObservedObject var viewModel: PostViewModel
    var post: Post
    @State private var title: String
    @State private var content: String

    init(viewModel: PostViewModel, post: Post) {
        self.viewModel = viewModel
        self.post = post
        _title = State(initialValue: post.title ?? "")
        _content = State(initialValue: post.content ?? "")
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            TextField("Enter title ", text: $title)
                .onChange(of: title) {
                    saveChanges()
                }
                
                Divider()
                
                ScrollView {
                    TextField("enter content ", text: $content)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .onChange(of: content) {
                            saveChanges()
                        }
                }
        }
        .onAppear {
            title = post.title ?? ""
            content = post.content ?? ""
        }
        .onChange(of: post.id) {
            title = post.title ?? ""
            content = post.content ?? ""
        }
    }
    
    private func saveChanges() {
        post.title = title
        post.content = content
        viewModel.updatePost(post)
    }
}
