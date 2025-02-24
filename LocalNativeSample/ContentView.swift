import SwiftUI

struct ContentView: View {
    @State private var isCommandPressed = false
    @StateObject private var viewModel = PostViewModel()
    @State private var selectedPostID: UUID?
    
    var selectedPost: Post? {
        viewModel.posts.first { $0.id == selectedPostID }
    }
    
    var body: some View {
        HStack(spacing: 0) {
            PostListView(viewModel: viewModel, selectedPostID: $selectedPostID)
                .frame(width: 300)
            
            if let post = selectedPost {
                PostDetailView(viewModel: viewModel, post: post)
                    .frame(maxWidth: .infinity)
            } else {
                Text("No post selected")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundColor(.gray)
            }
        }
        .onAppear(){
            setupKeyListener()
        }
    }
    
    private func setupKeyListener() {
        NSEvent.addLocalMonitorForEvents(matching: .flagsChanged) { event in
            isCommandPressed = event.modifierFlags.contains(.command)
            return event
        }
        
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
            if isCommandPressed && event.keyCode == 45 {
                viewModel.addPost(title: "タイトル", content: "本文")
                NSApp.keyWindow?.makeFirstResponder(nil)
                return nil
            }
            return event
        }
    }
}

#Preview {
    ContentView()
}
