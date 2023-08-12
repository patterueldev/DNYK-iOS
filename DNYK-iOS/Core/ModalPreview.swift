//
//  ModalPreview.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/12/23.
//

import SwiftUI

struct ModalPreview <SomeView: View> : View {
    @State var showsModalView = true
    var content: () -> SomeView
    
    var body: some View {
        Text("Preview")
            .sheet(isPresented: $showsModalView, content: content)
    }
}
