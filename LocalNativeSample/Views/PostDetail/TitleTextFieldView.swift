import SwiftUI

struct TitleTextFieldView: View {
    @Binding var title: String
    var onSave: () -> Void
    
    var body: some View {
        TextField("Enter title", text: $title)
            .padding()
            .frame(maxWidth: .infinity)
            .textFieldStyle(.plain)
            .font(.title2)
            .onChange(of: title) {
                onSave()
            }
    }
}
