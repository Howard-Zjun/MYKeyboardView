//
//  WAKeyboardKeyStyle.swift
//  ListenSpeak
//
//  Created by ios on 2025/2/18.
//

import UIKit
import MyBaseExtension

class MYKeyboardKeyStyle: NSObject {

    func setStyle(btn: UIButton) {
        btn.layer.cornerRadius = 4.6
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.layer.shadowOffset = .init(width: 0, height: 5)
        btn.layer.shadowColor = UIColor(hex: 0x898A8D).cgColor
        btn.titleLabel?.font = UIFont(name: "Source Han Sans CN", size: 34)
        btn.autoresizingMask = [.flexibleLeftMargin, .flexibleTopMargin, .flexibleWidth, .flexibleHeight, .flexibleRightMargin, .flexibleBottomMargin]
    }
}
