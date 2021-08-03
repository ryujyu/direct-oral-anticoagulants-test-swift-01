//
//  ViewController.swift
//  direct-oral-anticoagulants-test-swift-01
//
//  Created by administrator on 2021/07/12.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var creTextFiled: UITextField!
    @IBOutlet weak var genderegmentedControl: UISegmentedControl!
    @IBOutlet weak var claerBtnAction: UIButton!
    @IBOutlet weak var calculationBtnAction: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
            weightTextField.placeholder = "体重をkgで入力してください。"
            ageTextField.placeholder = "年齢を数字で入力してください。"
        creTextFiled.placeholder = "クレアチニンクリアランスを数字で入力してください"
        }


    /// 確認ボタン押下後に画面遷移
    @IBAction func calculationBtnAction(_ sender: Any) {
        self.performSegue(withIdentifier: "toCalcViewController", sender: nil)
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // segueのIDを確認して特定のsegueのときのみ動作させる
            if segue.identifier == "toCalcViewController" {
                // 遷移先のViewControllerを取得
                let next = segue.destination as? Calc_ViewController
                // 遷移先のプロパティに処理ごと渡す
                next?.resultHandler = { text in
                    // 引数を使ってoutputLabelの値を更新する処理
                    self.outputLabel.text = text
                }
            }
        }
        
        func calculation(weight: Double, age: Double) -> String {
            let h = weight / 100
            let w = age
            var result = w / (h * h)
            result = floor(result * 10) / 10
            return result.description
        }
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


