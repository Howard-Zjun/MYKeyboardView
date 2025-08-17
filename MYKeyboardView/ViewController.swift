//
//  ViewController.swift
//  MYKeyboardView
//
//  Created by ios on 2025/2/19.
//

import UIKit
import MyBaseExtension

class ViewController: UIViewController {

    var childrenPrivacyKey: String {
        "childrenPrivacyKey"
    }
    
    var useragreementKey: String {
        "useragreementKey"
    }
    
    var privacyPolicyKey: String {
        "privacyPolicyKey"
    }
    
    /// 原本的TextField
    lazy var sourceTextField: UITextField = {
        let sourceTextField = UITextField.init(frame: CGRect(x: 100, y: 100, width: 200, height: 50))
        sourceTextField.backgroundColor = .init(hex: 0xB9DEE7)
        sourceTextField.delegate = self
        sourceTextField.autocorrectionType = .no
        sourceTextField.spellCheckingType = .no
        sourceTextField.keyboardType = .asciiCapable
        sourceTextField.returnKeyType = .done
        return sourceTextField
    }()
    
    /// 使用自定义键盘的TextField
    let textFieldAccrptModel = MYKeyboardAcceptModel()
    
    lazy var myTextField: UITextField = {
        let myTextField = UITextField.init(frame: CGRect(x: 100, y: 200, width: 200, height: 50))
        myTextField.backgroundColor = .init(hex: 0xB9DEE7)
        myTextField.delegate = self
        textFieldAccrptModel.config(textField: myTextField, responseDelegate: self)
        return myTextField
    }()
    
    func getAttrText() -> NSAttributedString {
        let aColor = UIColor(hex: 0x8B8B8B)
        let linkColor = UIColor(hex: 0x009CFF)
        let blackColor = UIColor.black
        let items: [(String, UIColor, String?)] = [
            ("请您充分阅读并理解", aColor, nil),
            ("《使用条款》", linkColor, useragreementKey),
            ("、", aColor, nil),
            ("《隐私协议》", linkColor, privacyPolicyKey),
            ("和", aColor, nil),
            ("《儿童隐私政策》", linkColor, childrenPrivacyKey),
            ("。\n", aColor, nil),
            ("1、请您在浏览使用时，", aColor, nil),
            ("我们会收集您的设备信息、操作日志等。\n", blackColor, nil),
        ]
        
        let attr = NSMutableAttributedString()
        for item in items {
            let tAttr = NSMutableAttributedString(string: item.0, attributes: [.foregroundColor : item.1])
            if let key = item.2 {
                tAttr.addAttribute(.link, value: key, range: .init(location: 0, length: tAttr.length))
                tAttr.addAttribute(.underlineStyle, value: NSNumber(value: NSUnderlineStyle.single.rawValue), range: .init(location: 0, length: tAttr.length))
                tAttr.addAttribute(.underlineColor, value: item.1, range: .init(location: 0, length: tAttr.length))
            }
            attr.append(tAttr)
        }
        attr.addAttribute(.baselineOffset, value: NSNumber(value: 5), range: .init(location: 0, length: attr.length))
        return attr
    }
    
    /// 原本的TextView
    lazy var sourceTextView: UITextView = {
        let sourceTextView = UITextView.init(frame: CGRect(x: 100, y: 300, width: 200, height: 200))
        sourceTextView.backgroundColor = .init(hex: 0xB9DEE7)
        sourceTextView.delegate = self
        sourceTextView.linkTextAttributes = .init()
        return sourceTextView
    }()
    
    /// 使用自定义键盘的TextView
    let textViewAcceptModel = MYKeyboardAcceptModel()
    
    lazy var myTextView: UITextView = {
        let myTextView = UITextView.init(frame: CGRect(x: 100, y: 550, width: 200, height: 200))
        myTextView.backgroundColor = .init(hex: 0xB9DEE7)
        myTextView.delegate = self
        myTextView.linkTextAttributes = .init()
        textViewAcceptModel.config(textView: myTextView, responseDelegate: self)
        return myTextView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(sourceTextField)
        view.addSubview(myTextField)
        view.addSubview(sourceTextView)
        view.addSubview(myTextView)
        
        sourceTextView.attributedText = getAttrText()
        myTextView.attributedText = getAttrText()
    }
}

extension ViewController: MYKeyboardResponseDelegate {
    
}

extension ViewController: UITextFieldDelegate {
    
    func recognize(textField: UITextField) -> String {
        if textField == sourceTextField {
            return "sourceTextField"
        } else if textField == myTextField {
            return "myTextField"
        } else {
            return ""
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("\(recognize(textField: textField))-\(#function)")
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("\(recognize(textField: textField))-\(#function)")
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("\(recognize(textField: textField))-\(#function)")
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("\(recognize(textField: textField))-\(#function)")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        print("\(recognize(textField: textField))-\(#function)")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("\(recognize(textField: textField))-\(#function)")
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print("\(recognize(textField: textField))-\(#function)")
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("\(recognize(textField: textField))-\(#function)")
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("\(recognize(textField: textField))-\(#function)")
        textField.resignFirstResponder()
        return true
    }
}


extension ViewController: UITextViewDelegate {
    
    func recognize(textView: UITextView) -> String {
        if textView == sourceTextView {
            return "sourceTextView"
        } else if textView == myTextView {
            return "myTextView"
        } else {
            return ""
        }
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        print("\(recognize(textView: textView))-\(#function)")
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        print("\(recognize(textView: textView))-\(#function)")
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("\(recognize(textView: textView))-\(#function)")
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print("\(recognize(textView: textView))-\(#function)")
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        print("\(recognize(textView: textView))-\(#function)")
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        print("\(recognize(textView: textView))-\(#function)")
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        print("\(recognize(textView: textView))-\(#function)")
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        print("\(recognize(textView: textView))-\(#function)")
        return true
    }
    
    func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        print("\(recognize(textView: textView))-\(#function)")
        return true
    }
}


