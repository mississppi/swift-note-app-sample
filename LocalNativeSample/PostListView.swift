import SwiftUI

struct PostListView: View {
    var body: some View {
        List {
            ForEach(1..<6) { index in
                Text("Post \(index)")
            }
        }
    }
}

#Preview {
    PostListView()
}
