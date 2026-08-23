//
//  ContentView.swift
//  CategoryHub
//
//  Created by Goldianus SM on 22/08/26.
//

import SwiftUI
import UIKit

struct CategoryHubViewRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UINavigationController {
        let categoryVC = CategoryHubViewController()
        return UINavigationController(rootViewController: categoryVC)
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
}

struct ContentView: View {
    var body: some View {
        CategoryHubViewRepresentable()
            .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
