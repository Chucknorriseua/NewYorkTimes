//
//  NYTTabBar.swift
//  NYTNews
//
//  Created by Евгений Полтавец on 30/01/2025.
//

import SwiftUI
enum TabbedItems: Int, CaseIterable{
    case mostEmailed = 0
    case mostShared
    case mostViewed
    case favorites
    
    var title: String{
        switch self {
        case .mostEmailed:
            return "Most Emailed"
        case .mostShared:
            return "Most Shared"
        case .mostViewed:
            return "Most Viewed"
        case .favorites: 
           return "Favorites"
        }
    }
    
    var iconName: String{
        switch self {
        case .mostEmailed:
            return "envelope.circle.fill"
        case .mostShared:
            return  "globe.europe.africa.fill"
        case .mostViewed:
            return "eye.circle.fill"
        case .favorites:
            return "bookmark.circle.fill"
        }
    }
}

struct NYTTabBar: View {
    
    @State private var selectedTab = 0

   
    var body: some View {

        ZStack(alignment: .bottom) {
            ZStack {
                TabView(selection: $selectedTab,
                        content:  {
                    EmailedController()
                        .toolbarBackground(.hidden, for: .tabBar)
                        .tag(0)
                    SharedController()
                        .toolbarBackground(.hidden, for: .tabBar)
                        .tag(1)
                    ViewedController()
                        .toolbarBackground(.hidden, for: .tabBar)
                        .tag(2)
                    FavoritesController()
                        .toolbarBackground(.hidden, for: .tabBar)
                        .tag(3)
                })
            }

            ZStack {
                HStack{
                    ForEach((TabbedItems.allCases), id: \.self) { item in
                            Button {
                                withAnimation(.linear(duration: 0.8)) {
                                    selectedTab = item.rawValue
                                }
                            } label: {
                                
                                CustomTabItem(imageName: item.iconName, title: item.title, isActive: (selectedTab == item.rawValue))
                            }
                    }
                }
                .padding(6)
            }
            .frame(height: 70)
            .background(.ultraThinMaterial)
            .cornerRadius(35)
            .padding(.horizontal, 26)
        }.ignoresSafeArea(.keyboard)
    }
}

extension NYTTabBar{
    func CustomTabItem(imageName: String, title: String, isActive: Bool) -> some View{
        HStack(spacing: 10){
            Spacer()
            Image(systemName: imageName)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(isActive ? .black : .gray)
                .frame(width: 20, height: 20)
            if isActive{
                Text(title)
                    .font(.system(size: 14))
                    .foregroundColor(isActive ? .black : .gray)
            }
            Spacer()
        }
        .frame(width: isActive ? 140 : 60, height: 60)
        .background(isActive ? .white.opacity(0.6) : .clear)
        .cornerRadius(30)
    }
}
