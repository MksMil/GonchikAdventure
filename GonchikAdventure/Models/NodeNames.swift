// Naming for nodes

enum NodeNames: String{
    case camera, bg, startButton
    case buttonLeft, buttonRight, buttonUp, buttonDown, buttonA, buttonB, buttonPauseResume, buttonSpecail
    case labelScores, labelLives
    case mainHero
    
    var name: String {
        self.rawValue
    }
}
