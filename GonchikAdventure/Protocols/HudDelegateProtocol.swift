// protocol to define hud interaction functionality

import Foundation

protocol HudDelegateProtocol: AnyObject {
    func pressLeft()
    func pressRight()
    func pressA()
    func pressB()
    func pressSpecial()
    func pauseResume()
    
}
