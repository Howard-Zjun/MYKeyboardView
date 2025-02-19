//
//  WAKeyboardAcceptModel.swift
//  ListenSpeak
//
//  Created by ios on 2025/2/18.
//

import UIKit

///
/// 继承 UITextFieldDelegate, UITextViewDelegate
/// 1.将值变化传递给外部
/// 2.对外部实现的协议做中继传输，比如 textFieldShouldReturn
///
@objc protocol MYKeyboardResponseDelegate: UITextFieldDelegate, UITextViewDelegate {
    
    @objc optional func editValueChange(text: String)
    
}

class MYKeyboardAcceptModel: NSObject {

    var textField: UITextField?
    
    var textView: UITextView?
    
    weak var responseDelegate: MYKeyboardResponseDelegate?
    
    lazy var keyboard: MYKeyboardView = {
        let keyboard = UINib(nibName: String(describing: MYKeyboardView.self), bundle: nil).instantiate(withOwner: nil, options: nil).first as! MYKeyboardView
        keyboard.frame.size = .init(width: 375, height: 250)
        keyboard.delegate = self
        return keyboard
    }()
    
    func config(textField: UITextField, responseDelegate: MYKeyboardResponseDelegate? = nil) {
        self.textField = textField
        self.responseDelegate = responseDelegate
        textField.inputView = keyboard
        textView?.inputView = nil
    }
    
    func config(textView: UITextView, responseDelegate: MYKeyboardResponseDelegate? = nil) {
        self.textView = textView
        self.responseDelegate = responseDelegate
        textField?.inputView = nil
        textView.inputView = keyboard
    }
}

// MARK: - WAKeyboardDelegate
extension MYKeyboardAcceptModel: MYKeyboardDelegate {
    
    func change(keyType: KeyType) {
        if case .ascii(let value) = keyType {
            append(value: value)
        } else if case .comfirm = keyType {
            if let responseDelegate = responseDelegate {
                if let textField, responseDelegate.responds(to: #selector(UITextFieldDelegate.textFieldShouldReturn(_:))) {
                    _ = responseDelegate.textFieldShouldReturn?(textField)
                } else if let textView {
                    textView.resignFirstResponder()
                }
            } else {
                textField?.resignFirstResponder()
                textView?.resignFirstResponder()
            }
        } else if case .delete = keyType {
            if let textField {
                var result = ""
                if let text = textField.text, !text.isEmpty {
                    result = text.prefix(text.count - 1).description
                }
                textField.text = result
                
                // textField 没有 didChange 方法，所以只能通过代理传递
                responseDelegate?.editValueChange?(text: result)
            } else if let textView {
                var result = ""
                if let text = textView.text, !text.isEmpty {
                    result = text.prefix(text.count - 1).description
                }
                textView.text = result
                
                // textView 有 didChange 方法，可以直接调用
                responseDelegate?.textViewDidChange?(textView)
            }
        } else if case .space = keyType {
            append(value: " ")
        } else if case .toLower = keyType {
            keyboard.numberView.isHidden = true
            keyboard.lowerView.isHidden = false
            keyboard.upperView.isHidden = true
        } else if case .toNumber = keyType {
            keyboard.numberView.isHidden = false
            keyboard.lowerView.isHidden = true
            keyboard.upperView.isHidden = true
        } else if case .toUpper = keyType {
            keyboard.numberView.isHidden = true
            keyboard.lowerView.isHidden = true
            keyboard.upperView.isHidden = false
        }
    }
    
    // 尾部追加字段
    func append(value: String) {
        if let textField {
            var result = ""
            if let text = textField.text {
                result = text + value
            } else {
                result = value
            }
            textField.text = result
            
            // textField 没有 didChange 方法，所以只能通过代理传递
            responseDelegate?.editValueChange?(text: result)
        } else if let textView {
            var result = ""
            if let text = textView.text {
                result = text + value
            } else {
                result = value
            }
            textView.text = result
            
            // textView 有 didChange 方法，可以直接调用
            responseDelegate?.textViewDidChange?(textView)
        }
    }
}
