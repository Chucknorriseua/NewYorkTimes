//
//  NYTNewsApp.swift
//  NYTNews
//
//  Created by Евгений Полтавец on 30/01/2025.
//

import SwiftUI

@main
struct NYTNewsApp: App {
    
    let persistenceController = PersistenceController.shared
    @StateObject private var newsViewModel = NewsViewModel.shared
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                NYTTabBar()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(newsViewModel)
            }
        }
    }
}
