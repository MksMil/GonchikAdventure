import SpriteKit
import SwiftUI
import CoreGraphics

struct StartView: View {
    
    @StateObject var mainRouter = MainRouter()
//    var scene = SKScene(fileNamed: "TestScene")
    
    var body: some View {
//        if let scene{
            SpriteView(
                scene: mainRouter.activeScene ,
                debugOptions: [.showsFPS, .showsNodeCount]
            )
            .ignoresSafeArea()
//        } else {
//            Color.red
//        }
        
    }
}

#Preview {
    StartView()
}


