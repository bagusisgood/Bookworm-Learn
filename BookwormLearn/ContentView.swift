//
//  ContentView.swift
//  BookwormLearn
//
//  Created by Bagus Triyanto on 08/07/20.
//  Copyright © 2020 Bagus Triyanto. All rights reserved.
//

//  Bookworm : Book-tracking app (what book title you read & what do you think of them?)
//  Apple Core Data : Framework for working with databases
//  First Custom UI Component : Star rating widget - using new property wrapper @Binding

//  Before implementing @Binding -> One way flow of data: ContentView has its rememberMe Boolean, which gets used to create a PushButton – the button has an initial value provided by ContentView. However, once the button was created it takes over control of the value: it toggles the isOn property between true or false *internally* to the button, but *doesn’t pass that change back on to ContentView.*
//  This is a problem, because we now have *two sources of truth: *ContentView is storing one value, and *PushButton another. Fortunately, this is where @Binding comes in: it allows us to create a two-way connection between PushButton and whatever is using it, so that when one value changes the other does too.
//  To switch to @Binding:
//  1. PushButton Struct - @Binding var isOn: Bool
//  2. PushButton instance in ContentView using $binding - PushButton(title: "Remember Me", isOn: $rememberMe)

//  @Environment Wrapper: size classes - how much space we have for our views
//  Two size classes horizontally and vertically, called “compact” and “regular”.
//  AnyView() - Type erased wrapper -- AnyView effectively hides – or erases – the type of the views it contains.
//  Why we don’t use AnyView all the time if it lets us avoid the restrictions of some View? The answer is simple: performance. -- It’s generally best to avoid AnyView unless you specifically need it.

import SwiftUI

struct PushButton: View {
    let title: String
    @Binding var isOn: Bool
    
    var onColors = [Color.red, Color.yellow]
    var offColors = [Color(white: 0.6), Color(white: 0.4)]
    
    var body: some View {
        Button(action: {
            self.isOn.toggle()
        }) {
            Text(title)
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: isOn ? onColors : offColors), startPoint: .top, endPoint: .bottom))
        .foregroundColor(.white)
        .clipShape(Capsule())
        .shadow(radius: isOn ? 5 : 0)
        
    }
}

struct ContentView: View {
    @State private var rememberMe = false
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
//        NavigationView {
//            VStack {
//                Text("Hello, World!")
//
//                Toggle(isOn: $rememberMe) {
//                    Text("Remember Me")
//                }
//
//                Spacer()
//
//                PushButton(title: "Remember Me", isOn: $rememberMe)
//                Text(rememberMe ? "On" : "Off")
//
//                Spacer()
//
//            }
//            .padding()
//            .navigationBarTitle(Text("Bookworm Learn"))
//        }
        
        if sizeClass == .compact {
            return AnyView(VStack {
                Text("Active Size Class:")
                Text("COMPACT")

            }
            .font(.largeTitle))

        } else {
            return AnyView(HStack {
                Text("Active Size Class:")
                Text("REGULAR")

            }
            .font(.largeTitle))

        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
