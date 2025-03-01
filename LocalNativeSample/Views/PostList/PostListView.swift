import SwiftUI

struct PostListView: View {
    @ObservedObject var viewModel: PostViewModel
    @Binding var selectedPostID: UUID?
    @State private var showMenuForPostID: UUID?

    var body: some View {
        NavigationView {
            List(viewModel.posts) { post in
                HStack {
                    Text(post.title ?? "No title")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(selectedPostID == post.id ? Color.gray.opacity(0.2) : Color.clear)
                        .onTapGesture {
                            print("taped")
                            selectedPostID = post.id
                        }
                    Button(action: {
                        showMenuForPostID = post.id
                    }) {
                        Image(systemName: "ellipsis")
                            .rotationEffect(.degrees(90))
                            .padding()
                    }
                    .buttonStyle(BorderedButtonStyle())
                    .popover(isPresented: Binding(
                        get: {
                            showMenuForPostID == post.id
                        },
                        set: { if !$0 { showMenuForPostID = nil } }
                    )) {
                        VStack {
                            Button("update") {print("update")}
                            Button("delete") {
                                print("delete")
                                print(post.id)
                                print(showMenuForPostID)
                                print(selectedPostID)
                                if let postToDelete = viewModel.posts.first(where: { $0.id == showMenuForPostID}) {
                                    print("exec")
                                    viewModel.deletePost(postToDelete)
                                }
                                print("ed")
                            }
                        }
                        .padding()
                        .frame(width: 120)
                    }
                }
            }
        }
    }
}
