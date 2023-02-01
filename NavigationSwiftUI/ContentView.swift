//
//  ContentView.swift
//  NavigationSwiftUI
//
//  Created by Kuldeep Vashisht on 26/01/23.
//

import SwiftUI

struct RootPresentationModeKey: EnvironmentKey {
    static let defaultValue: Binding<RootPresentationMode> = .constant(RootPresentationMode())
}

extension EnvironmentValues {
    var rootPresentationMode: Binding<RootPresentationMode> {
        get { return self[RootPresentationModeKey.self] }
        set { self[RootPresentationModeKey.self] = newValue }
    }
}

typealias RootPresentationMode = Bool

extension RootPresentationMode {
    
    public mutating func dismiss() {
        self.toggle()
    }
}

struct FirstScreen: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: SecondScreen()) {
                    Text("Go to Second Screen")
                }
            }
        }
    }
}

struct SecondScreen: View {
    var body: some View {
        VStack {
            NavigationLink(destination: ThirdScreen()) {
                Text("Go to Third Screen")
            }
        }
    }
}

struct ThirdScreen: View {
    var body: some View {
        VStack {
            NavigationLink(destination: FirstScreen()) {
                Text("Go to First Screen")
            }
        }
    }
}


struct ContentView: View {
    @State private var isActive : Bool = false
    var body: some View {
        NavigationView {
            VStack {
                Text("Root")
                NavigationLink(destination: ContentView2(), isActive: self.$isActive )
                { Text("Push") }
                    .isDetailLink(false)
            }
            .navigationBarTitle("Root")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .environment(\.rootPresentationMode, self.$isActive)
    }
}

struct ContentView2: View {
    @State private var isActive : Bool = false
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>
    var body: some View {
        VStack {
            Text("Two")
            NavigationLink(destination: ContentView3(), isActive: self.$isActive)
            { Text("Push") }
                .isDetailLink(false)
            Button (action: { self.presentationMode.wrappedValue.dismiss() } )
            { Text("Pop") }
            Button (action: { self.rootPresentationMode.wrappedValue.dismiss() } )
            { Text("Pop to root") }
        }
        .navigationBarTitle("Two")
    }
}
struct ContentView3: View {
    @State private var isActive : Bool = false
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>
    var body: some View {
        VStack {
            Text("Three")
            NavigationLink(destination: ContentView4(), isActive: self.$isActive)
            { Text("Push") }
                .isDetailLink(false)
            Button (action: { self.presentationMode.wrappedValue.dismiss() } )
            { Text("Pop") }
            Button (action: { self.rootPresentationMode.wrappedValue.dismiss() } )
            { Text("Pop to root") }
        }
        .navigationBarTitle("Three")
    }
}

struct ContentView4: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>
    var body: some View {
        VStack {
            Text("Four")
            Button (action: { self.presentationMode.wrappedValue.dismiss() } )
            { Text("Pop") }
            Button (action: { self.rootPresentationMode.wrappedValue.dismiss() } )
            { Text("Pop to root") }
        }
        .navigationBarTitle("Four")
    }
}
