import SwiftUI

struct PostDetailView: View {
    @State private var isCommandPressed = false
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
            TitleTextFieldView(title: $title, onSave: saveChanges)
                
                Divider()
                
                ScrollView {
                    ContentTextFieldView(content: $content, onSave: saveChanges)
                }
        }
        .onAppear {
            title = post.title ?? ""
            content = post.content ?? ""
            
            setupKeyListener()
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
    
    private func setupKeyListener() {
        NSEvent.addLocalMonitorForEvents(matching: .flagsChanged) { event in
            isCommandPressed = event.modifierFlags.contains(.command)
            return event
        }
        
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
            if isCommandPressed && event.characters == "c" {
                if let textView = NSApp.keyWindow?.firstResponder as? NSTextView {

                    //範囲選択か判定
                    let selectedRange = textView.selectedRange()
                    if selectedRange.length == 0 {
                        let cursorPosition = textView.selectedRange().location
                        let text = textView.string as NSString
                        
                        var startPos = cursorPosition
                        while startPos > 0 {
                            let char = text.character(at: startPos - 1)
                            if char == 10  || char == 13 {
                                break
                            }
                            startPos -= 1
                        }
                        
                        var endPos = cursorPosition
                        while endPos < text.length {
                            let char = text.character(at: endPos)
                            if char == 10 || char == 13 {
                                break
                            }
                            endPos += 1
                        }
                        let lineEnd = (endPos == NSNotFound) ? text.length : endPos
                        let lineRange = NSRange(location: startPos, length: lineEnd - startPos)
                        textView.setSelectedRange(lineRange)
                        textView.copy(nil)
                        textView.setSelectedRange(NSRange(location: cursorPosition, length: 0))
                        return nil
                    }
                }
            }
            return event
        }
    }
    
    private func copyCurrentLine() {
        print("start")
    }
}
