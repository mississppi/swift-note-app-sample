import XCTest
import CoreData
@testable import LocalNativeSample

final class CoreDataServiceTests: XCTestCase {
    var coreDataService: CoreDataService!;
    var testContext: NSManagedObjectContext!;
    
    override func setUp() {
        super.setUp()
        testContext = TestPersistenceController.shared.context
        coreDataService = CoreDataService(context: testContext)
    }
    
    override func tearDown() {
        deleteAllPosts()
        coreDataService = nil
        testContext = nil
        super.tearDown()
    }
    
    func test_addPost_shouldIncreaseCount() {
        let initialCount = coreDataService.fetchPosts().count

        coreDataService.addPost(title: "Test title", content: "Test Content", order: 1)
        let newCount = coreDataService.fetchPosts().count
        XCTAssertEqual(newCount, initialCount + 1)
    }
    
    func test_fetchPost_shouldReturnCorrectData() {
        coreDataService.addPost(title: "Test title", content: "Test Content", order: 1)
        
        let posts = coreDataService.fetchPosts()
        
        XCTAssertEqual(posts.count, 1)
        XCTAssertEqual(posts.first?.title, "Test title")
        XCTAssertEqual(posts.first?.content, "Test Content")
    }
    
    func test_updatePost_shouldOnlyUpdateUpdatedAt() {
        coreDataService.addPost(title: "Test title", content: "Test Content", order: 1)
        var post = coreDataService.fetchPosts().first!
        
        let oldCreatedAt = post.createdAt
        let oldUpdatedAt = post.updatedAt
        let oldTitle = post.title
        let oldContent = post.content
        let oldOrder = post.order
        
        sleep(1)
        
        coreDataService.updatePost(post)
        
        let updatedPost = coreDataService.fetchPosts().first!
        
        XCTAssertEqual(updatedPost.createdAt, oldCreatedAt)
        XCTAssertNotEqual(updatedPost.updatedAt, oldUpdatedAt)
        
        XCTAssertEqual(updatedPost.title, oldTitle)
        XCTAssertEqual(updatedPost.content, oldContent)
        XCTAssertEqual(updatedPost.order, oldOrder)
    }
    
    func test_deletePost_shouldRemovePost() {
        coreDataService.addPost(title: "Test title", content: "Test Content", order: 1)
        var posts = coreDataService.fetchPosts()
        XCTAssertEqual(posts.count, 1)
        
        let postToDelete = posts.first!
        
        coreDataService.deletePost(postToDelete)
        
        posts = coreDataService.fetchPosts()
        
        XCTAssertEqual(posts.count, 0)

    }
    
    //データのリセットに利用
    func deleteAllPosts() {
        let fetchRequest: NSFetchRequest<Post> = Post.fetchRequest()
        
        do {
            let posts = try testContext.fetch(fetchRequest)
            for post in posts {
                testContext.delete(post)
            }
            try testContext.save()
        } catch {
            print("failed to delete all")
        }
    }
    
}
