import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "Post")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("CoreDataのロードに失敗しました: \(error)")
            }
        }
    }
    
    var context: NSManagedObjectContext {
        return container.viewContext
    }
}
