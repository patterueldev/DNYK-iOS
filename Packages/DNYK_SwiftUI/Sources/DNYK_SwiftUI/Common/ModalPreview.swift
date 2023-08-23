//
//  ModalPreview.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/12/23.
//

import SwiftUI

public struct ModalPreview <SomeView: View> : View {
    @State var showsModalView = true
    var content: () -> SomeView
    
    public init(@ViewBuilder content: @escaping () -> SomeView) {
        self.content = content
    }
    
    public var body: some View {
        Text("Preview")
            .sheet(isPresented: $showsModalView, content: content)
    }
}
