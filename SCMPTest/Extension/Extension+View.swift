//
//  Extension+View.swift
//  SCMPTest
//
//  Created by Kevin Hsu on 2023/12/16.
//

import Foundation
import SwiftUI

extension View {
    func scmpLine(height: CGFloat = 1.0, isFocused: Binding<Bool> = .constant(false), isError: Binding<Bool> = .constant(false)) -> some View {
        self.modifier(ScmpLine(height: height, isFocused: isFocused, isError: isError))
    }
    
    func limitText(_ text: Binding<String>, to characterLimit: Int) -> some View {
        self
            .onChange(of: text.wrappedValue) { _ in
                text.wrappedValue = String(text.wrappedValue.prefix(characterLimit))
            }
    }
}

struct ScmpLine: ViewModifier {
    var height: CGFloat = 1
    
    @Binding var isFocused: Bool
    @Binding var isError: Bool
    
    func body(content: Content) -> some View {
        content
            .overlay {
                if isFocused {
                    Rectangle()
                        .frame(height: height)
                        .foregroundColor(.blue)
                } else if isError {
                    Rectangle()
                        .frame(height: height)
                        .foregroundColor(.red)
                } else {
                    Rectangle()
                        .frame(height: height)
                        .foregroundColor(.black)
                }
            }
    }
}
