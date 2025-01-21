import SpriteKit
import SwiftUI

struct ContentView: View {
    var body: some View {
        SpriteView(
            scene: HomeScene(), debugOptions: [.showsFPS, .showsNodeCount]
        )
        .ignoresSafeArea()
//        .padding(.bottom,20)
    }
}

#Preview {
    ContentView()
}
