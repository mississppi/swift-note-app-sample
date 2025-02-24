import Foundation
import CoreData

class PostViewModel: ObservableObject {
    @Published var posts: [Post] = []
    
    private let coreDataService = CoreDataService()
    
    init() {
        fetchPosts()
    }
    
    func fetchPosts() {
        posts = coreDataService.fetchPosts()
    }
    
    func addPost(title: String, content: String){
        let maxOrder = coreDataService.getMaxOrder() ?? 0
        let newOrder: Int64 = maxOrder + 1
        coreDataService.addPost(title: title, content: content, order: newOrder)
        fetchPosts()
    }
    
    func updatePost(_ post: Post) {
        coreDataService.updatePost(post)
        fetchPosts()
    }
}
