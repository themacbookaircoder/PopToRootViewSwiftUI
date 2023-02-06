import SwiftUI

struct ContentView: View {
    @State var isActive : Bool = false

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(
                    destination: ContentView2(rootIsActive: self.$isActive),
                    isActive: self.$isActive
                ) {
                    Text("Hello, World!")
                }
                .isDetailLink(false)

                NavigationLink(destination: ContentView3(shouldPopToRootView: self.$isActive, navigatingFromRoot: true)) {
                    Text("Go to ContentView3")
                }
                .isDetailLink(false)
            }
            .navigationBarTitle("Root")
        }
    }
}

struct ContentView2: View {
    @Binding var rootIsActive : Bool

    var body: some View {
        NavigationLink(destination: ContentView3(shouldPopToRootView: self.$rootIsActive, navigatingFromRoot: false)) {
            Text("Hello, World #2!")
        }
        .isDetailLink(false)
        .navigationBarTitle("Two")
    }
}

struct ContentView3: View {
    @Binding var shouldPopToRootView : Bool
    @State var navigatingFromRoot: Bool
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    var body: some View {
        VStack {
            Text("Hello, World #3!")
            Button (action: {
                if !navigatingFromRoot {
                    self.shouldPopToRootView = false
                } else{
                    self.presentationMode.wrappedValue.dismiss()
                }
                 } ){
                Text("Pop to root")
            }
        }.navigationBarTitle("Three")
    }
}
