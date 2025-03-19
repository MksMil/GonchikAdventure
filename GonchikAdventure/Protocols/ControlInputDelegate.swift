// protocol to define hud interaction functionality

import Foundation

protocol ControlInputDelegate: AnyObject {
    func executeInstruction(input: NodeNames, state: InputState)
    
}
