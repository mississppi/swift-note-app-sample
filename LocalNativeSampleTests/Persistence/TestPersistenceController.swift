import CoreData

struct TestPersistenceController {
    static let shared = TestPersistenceController()
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "Post")
        let description = container.persistentStoreDescriptions.first
        description?.type = NSInMemoryStoreType
        
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("テスト用　CoreDataのセットアップに失敗しました")
            }
        }
        
        context = container.viewContext
    }
}
