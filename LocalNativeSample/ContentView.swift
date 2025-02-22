import SwiftUI

struct ContentView: View {
    @State private var debugMessage: String = "shortcut 待機中"
    @State private var isCommandPressed = false
    var body: some View {
//        HStack(spacing: 0) {
//            PostListView()
//                .frame(width: 300)
//                .background(Color.gray.opacity(0.2))
//            
//            VStack(spacing: 0) {
//                PostTitleView()
//                    .frame(height: 50)
//                    .background(Color.blue.opacity(0.2))
//                PostContentView()
//                    .background(Color.black)
//            }
//            .frame(maxWidth: .infinity)
//            
//        }
//        .frame(maxHeight: .infinity)
        VStack {
            Text(debugMessage)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
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
                print("key pressed!")
                
                NSApp.keyWindow?.makeFirstResponder(nil)
                return nil
            }
            return event
        }
    }
}

// 仮の PostTitleView
struct PostTitleView: View {
    var body: some View {
        Text("Post Title")
            .font(.headline)
            .padding()
    }
}

// 仮の PostContentView
struct PostContentView: View {
    var body: some View {
        ScrollView {
            Text("ここに Post の内容が入ります。\n\n長いテキストでも OK")
                .padding()
        }
    }
}

#Preview {
    ContentView()
}
