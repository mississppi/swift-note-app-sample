import SwiftUI

struct ContentTextFieldView: View {
    @Binding var content: String
    var onSave: () -> Void
    
    var body: some View {
//        TextField("Enter content", text: $content)
//            .frame(maxWidth: .infinity, alignment: .leading)
//            .padding()
//            .textFieldStyle(.plain)
//            .font(.title2)
//            .onChange(of: content) {
//                onSave()
//            }
        TextEditor(text: $content)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .textFieldStyle(.plain)
            .background(Color.clear)
            .scrollContentBackground(.hidden) 
            .font(.title3)
            .onChange(of: content) {
                onSave()
            }
    }
}
