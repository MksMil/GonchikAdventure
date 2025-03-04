import SpriteKit
import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel: SceneRouter = SceneRouter()
    
    var body: some View {
        
            SpriteView(
                scene: viewModel.activeScene,
                debugOptions: [.showsFPS, .showsNodeCount]
            )
            .ignoresSafeArea()
           
    
//        .padding(.bottom,20)
    }
}

#Preview {
    ContentView()
}


