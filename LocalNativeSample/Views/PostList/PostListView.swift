import SwiftUI

struct PostListView: View {
    @ObservedObject var viewModel: PostViewModel
    @Binding var selectedPostID: UUID?
    @State private var showMenuForPostID: UUID?
    @State private var draggingPost: Post?

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
                        .onDrag {
                            draggingPost = post
                            guard let postID = post.id else {
                                return NSItemProvider(object: "" as NSString)
                            }
                            return NSItemProvider(object: postID.uuidString as NSString)
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
                                if let postToDelete = viewModel.posts.first(where: { $0.id == showMenuForPostID}) {
                                    viewModel.deletePost(postToDelete)
                                }
                            }
                        }
                        .padding()
                        .frame(width: 120)
                    }
                }
                .onDrop(of: ["public.text"], isTargeted: nil) { providers in
                    guard let provider = providers.first else {return false}
                    provider.loadObject(ofClass: NSString.self) { (uuidString, error) in
                        DispatchQueue.main.async {
                            guard let uuidString = uuidString as? String,
                                  let movedPostID = UUID(uuidString: uuidString),
                                  let movedPost = viewModel.posts.first(where: {$0.id == movedPostID }),
                                  let targetPost = viewModel.posts.first(where: {$0.id == post.id }) else {return}
                            viewModel.updateOrder(movedPost: movedPost, targetPost: targetPost)
                        }
                    }
                    return true
                }
            }
        }
    }
}
