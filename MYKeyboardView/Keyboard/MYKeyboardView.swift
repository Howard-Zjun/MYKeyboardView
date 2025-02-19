//
//  WALowerAsciiKeyboardView.swift
//  ListenSpeak
//
//  Created by ios on 2025/2/18.
//

import UIKit

enum KeyType {
    case ascii(value: String)
    case delete
    case toLower
    case toUpper
    case toNumber
    case space
    case comfirm
}

protocol MYKeyboardDelegate: NSObjectProtocol {

    func change(keyType: KeyType)
}

class MYKeyboardView: UIView {
    
    override func awakeFromNib() {
        configStyle()
    }
    
    weak var delegate: MYKeyboardDelegate?
    
    @IBOutlet weak var lowerView: UIView!
    
    @IBOutlet weak var upperView: UIView!
    
    @IBOutlet weak var numberView: UIView!
    
    let style = MYKeyboardKeyStyle()
    
    func configStyle() {
        for view in subviews {
            for subView in view.subviews {
                if let btn = subView as? UIButton {
                    style.setStyle(btn: btn)
                }
            }
        }
    }
    
    @IBAction func clickHandle(_ sender: UIButton) {
        if sender.tag < 100 { // 字母
            if let value = sender.titleLabel?.text {
                delegate?.change(keyType: .ascii(value: value))
            }
        } else if sender.tag == 100 { // 切换大写
            delegate?.change(keyType: .toUpper)
        } else if sender.tag == 101 { // 删除
            delegate?.change(keyType: .delete)
        } else if sender.tag == 102 { // 符号
            delegate?.change(keyType: .toNumber)
        } else if sender.tag == 103 { // 空格
            delegate?.change(keyType: .space)
        } else if sender.tag == 104 { // 确认
            delegate?.change(keyType: .comfirm)
        } else if sender.tag == 105 { // 切换小写
            delegate?.change(keyType: .toLower)
        } else if sender.tag == 106 { // 切换文字
            delegate?.change(keyType: .toLower)
        }
    }
}
