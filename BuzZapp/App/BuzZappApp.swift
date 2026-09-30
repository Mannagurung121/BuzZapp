import SwiftUI

@main

struct BuzZappApp: App {

    

    @StateObject private var cartViewModel = CartViewModel()

    

    var body: some Scene {

        WindowGroup {

            MainTabView()

                .environmentObject(cartViewModel)

        }

    }

}
