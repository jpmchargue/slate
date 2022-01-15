//
//  TaskSubheading.swift
//  Slate
//
//  Created by James McHargue on 1/14/22.
//

import SwiftUI

struct TaskSubheading: View {
    var text: String = ""
    
    var body: some View {
        Text(text)
            .font(.system(size: 12, weight:.bold))
            .frame(maxWidth:.infinity, alignment:.leading)
            .foregroundColor(.gray)
            .padding(.top)
    }
}

struct TaskSubheading_Previews: PreviewProvider {
    static var previews: some View {
        TaskSubheading()
    }
}
