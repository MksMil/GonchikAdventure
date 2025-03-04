//
//  MainViewDelegateProtocol.swift
//  GonchikAdventure
//
//  Created by Миляев Максим on 04.03.2025.
//

import Foundation

protocol MainViewDelegateProtocol: AnyObject {
    func printText(text: String)
    func nextScene()
}
