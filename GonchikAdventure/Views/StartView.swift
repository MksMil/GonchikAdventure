import SpriteKit
import SwiftUI

struct StartView: View {
    
    @StateObject var mainRouter = MainRouter()
    
    var body: some View {
            SpriteView(
                scene: mainRouter.activeScene,
                debugOptions: [.showsFPS, .showsNodeCount]
            )
            .ignoresSafeArea()
    }
}

#Preview {
    StartView()
}


