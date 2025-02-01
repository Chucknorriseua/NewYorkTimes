//
//  CustomPicker.swift
//  NYTNews
//
//  Created by Евгений Полтавец on 01/02/2025.
//

import SwiftUI

struct CustomPicker<T: Hashable>: View {
    
    let article: [T]
    @Binding var selectedCtegory: T?
    @Binding var isShowCategory: Bool
    
    var body: some View {
        if isShowCategory {
            VStack {
                ScrollView {
                    VStack {
                        Button("All") {
                            withAnimation {
                                selectedCtegory = nil
                                isShowCategory.toggle()
                            }
                        }
                        .foregroundStyle(Color.white)
                        .fontWeight(.heavy)
                        .padding(.all, 12)
                        .frame(maxWidth: 140, maxHeight: 60)
                        .clipShape(.rect(cornerRadius: 14))
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(
                                    LinearGradient(
                                        gradient: Gradient(colors: [.white]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    ),
                                    lineWidth: 2
                                )
                        )
                        .padding(.horizontal, 12)
                        ForEach(article, id: \.self) { item in
                            VStack {
                                Text(String(describing: item))
                                    .foregroundStyle(Color.white)
                                    .fontWeight(.heavy)
                                    .padding(.all, 12)
                                    .onTapGesture {
                                        withAnimation {
                                            isShowCategory.toggle()
                                            selectedCtegory = item
                                        }
                                    }
                            }
                            .frame(maxWidth: 140, maxHeight: 60)
                            .clipShape(.rect(cornerRadius: 14))
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(
                                        LinearGradient(
                                            gradient: Gradient(colors: [.white]),
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        ),
                                        lineWidth: 2
                                    )
                            )
                            .padding(.horizontal, 12)
                        }
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                }.scrollIndicators(.hidden)
            }.frame(maxWidth: .infinity, maxHeight: 300)
                .background(.ultraThinMaterial)
            .clipShape(.rect(cornerRadius: 24))
            .transition(.scale)
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(
                        LinearGradient(
                            gradient: Gradient(colors: [.white]),
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        lineWidth: 2
                    )
            )
            .overlay(alignment: .topTrailing) {
                VStack {
                    Button {
                        withAnimation(.snappy(duration: 0.8)) {
                            isShowCategory.toggle()
                        }
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 30))
                            .foregroundStyle(Color.white)
                    }.transition(.scale)
                }
                .padding(.top, 6)
                .padding(.trailing, 12)
            }
            .padding(.horizontal, 50)
        } else {

        }
    }
}
