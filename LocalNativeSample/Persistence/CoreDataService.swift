import CoreData

struct CoreDataService {
//    private let context = PersistenceController.shared.context
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = PersistenceController.shared.context) {
        self.context = context
    }
    
    func fetchPosts() -> [Post]{
        let request: NSFetchRequest<Post> = Post.fetchRequest()
        let sortDescript = NSSortDescriptor(key: "order", ascending: true)
        request.sortDescriptors = [sortDescript]
        
        do {
            return try context.fetch(request)
        } catch {
            print("データ取得エラー")
            return []
        }
    }

    func addPost(title: String, content: String, order: Int64) {
        let newPost = Post(context: context)
        newPost.id = UUID()
        newPost.title = title
        newPost.content = content
        newPost.createdAt = Date()
        newPost.updatedAt = Date()
        newPost.order = order
        
        saveContext()
    }
    
    func deletePost(_ post: Post) {
        context.delete(post)
        saveContext()
    }
    
    func updatePost(_ post: Post) {
        post.updatedAt = Date()
        saveContext()
    }
    
    func getMaxOrder() -> Int64?{
        let fetchRequest: NSFetchRequest<Post> = Post.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "order", ascending: false)]
        fetchRequest.fetchLimit = 1
        
        do {
            let results = try context.fetch(fetchRequest)
            return results.first?.order
        } catch {
            print("failed to fetch max order")
            return nil
        }
    }

    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("保存エラー \(error.localizedDescription)")
        }
    }
}
