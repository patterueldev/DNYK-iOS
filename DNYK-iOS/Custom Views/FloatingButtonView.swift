//
//  FloatingButtonView.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/11/23.
//

import SwiftUI

struct FloatingButtonView: View {
    let isCircle: Bool
    let backgroundColor: Color
    let foregroundColor: Color
    let shadowRadius: CGFloat
    let labelBuilder: () -> AnyView
    let action: () -> Void
    
    var body: some View {
        Button(action: action, label: labelBuilder)
            .background(backgroundColor)
            .foregroundStyle(foregroundColor)
            .buttonBorderShape(isCircle ? .circle : .roundedRectangle(radius: 20))
            .shadow(radius: shadowRadius)
    }
    
    init(
        isCircle: Bool = true,
        backgroundColor: Color = .blue,
        foregroundColor: Color = .white,
        shadowRadius: CGFloat = 5,
        action: @escaping () -> Void,
        @ViewBuilder buttonContent: @escaping () -> AnyView
    ) {
        self.isCircle = isCircle
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.shadowRadius = shadowRadius
        self.action = action
        self.labelBuilder = buttonContent
    }
    
    init(
        backgroundColor: Color = .clear,
        foregroundColor: Color = .blue,
        shadowRadius: CGFloat = 5,
        plusAction action: @escaping () -> Void
    ) {
        self.isCircle = true
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.shadowRadius = shadowRadius
        self.action = action
        self.labelBuilder = {
            AnyView (
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(foregroundColor)
                    .background(Color.white)
            )
        }
    }
    
    init(
        backgroundColor: Color = .blue,
        foregroundColor: Color = .white,
        shadowRadius: CGFloat = 5,
        textHPadding: CGFloat = 20,
        textVPadding: CGFloat = 10,
        text: String,
        textAction: @escaping () -> Void
    ) {
        self.isCircle = false
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.shadowRadius = shadowRadius
        self.action = textAction
        self.labelBuilder = {
            AnyView (
                Text(text)
                    .padding(.horizontal, textHPadding)
                    .padding(.vertical, textVPadding)
            
            )
        }
    }
}

#Preview {
    FloatingButtonView(plusAction: {})
//    FloatingButtonView(text: "Save", textAction: {})
}
