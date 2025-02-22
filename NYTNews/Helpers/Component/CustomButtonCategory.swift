//
//  CustomButtonCategory.swift
//  NYTNews
//
//  Created by Евгений Полтавец on 01/02/2025.
//

import SwiftUI

struct CustomButtonCategory: View {
    
    @Binding var isShowCategory: Bool
    
    var body: some View {
        VStack {
            Button {
                withAnimation(.snappy(duration: 0.8)) {
                    isShowCategory.toggle()
                }
            } label: {
                Image(systemName: "list.bullet.circle")
                    .font(.system(size: 24))
                    .foregroundStyle(Color.white)
            }
        }
    }
}
