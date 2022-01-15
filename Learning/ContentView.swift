//
//  ContentView.swift
//  Slate
//
//  Created by James McHargue on 12/22/21.
//

import SwiftUI

struct ContentView: View {
    var passText: String
    //var uselessVariable: 
    
    var body: some View {
        ZStack {
            VStack {
                Text("This is the top of the stack")
                    .bold()
                    .font(.system(size:24, design:.serif))
                Text(passText)
                    .padding()
            }
            VStack {
                Text("wha...?")
                Text("huh...?")
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(passText: "This is a preview")
    }
}
