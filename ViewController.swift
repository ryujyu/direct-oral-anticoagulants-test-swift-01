//
//  ViewController.swift
//  DOAC-test
//
//  Created by administrator on 2021/07/10.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var genderegmentedControl: UISegmentedControl!
    @IBOutlet weak var claerBtnAction: UIButton!
    @IBOutlet weak var calculationBtnAction: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
            weightTextField.placeholder = "体重をkgで入力してください。"
            ageTextField.placeholder = "年齢を数字で入力してください。"
        }


    /// 確認ボタン押下後に画面遷移
    @IBAction func nextBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "toNext", sender: nil)

        
    }
}

private var maxLengths = [UITextField: Int]()

extension UITextField {

    @IBInspectable var maxLength: Int {
        get {
            guard let length = maxLengths[self] else {
                return Int.max
            }

            return length
        }
        set {
            maxLengths[self] = newValue
            addTarget(self, action: #selector(limitLength), for: .editingChanged)
        }
    }

    @objc func limitLength(textField: UITextField) {
        guard let prospectiveText = textField.text, prospectiveText.count > maxLength else {
            return
        }

        let selection = selectedTextRange
        let maxCharIndex = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)

        #if swift(>=4.0)
            text = String(prospectiveText[..<maxCharIndex])
        #else
            text = prospectiveText.substring(to: maxCharIndex)
        #endif

        selectedTextRange = selection
    }
}
    
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.hideKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }

}


