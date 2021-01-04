//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by James Dunn on 11/5/20.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateCelciusLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let timeFormatter = DateFormatter()
        timeFormatter.locale = NSLocale.current
        timeFormatter.timeStyle = .short
        timeFormatter.dateStyle = .none
        
        let currentTime = timeFormatter.string(from: Date())
        guard let nightModeTime = Int(currentTime.prefix(through: currentTime.startIndex)) else { return }
        // if after 5pm local user time, use night mode colors
        if nightModeTime >= 5 && currentTime.contains("PM") {
            view.backgroundColor = UIColor.init(displayP3Red: 30, green: 30, blue: 30, alpha: 0.1)
            numberOfFDegrees?.attributedPlaceholder = NSAttributedString(string: (numberOfFDegrees?.placeholder)!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
            mediatingLabel?.textColor = UIColor.lightGray
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentLocale = Locale.current
        let decimalSeparator = currentLocale.decimalSeparator ?? "."
        let existingTextHasDecimalSeperator = textField.text?.range(of: decimalSeparator)
        let replacementTextHasDecimalSeperator = string.range(of: decimalSeparator)
        let restrictedCharacterSet = CharacterSet.letters
        if string.rangeOfCharacter(from: restrictedCharacterSet) != nil {
                    return false
                 } else {
        if existingTextHasDecimalSeperator != nil, replacementTextHasDecimalSeperator != nil {
            return false
        } else {
            return true
        }
                 }
    }
    
    @IBOutlet var numberOfFDegrees: UITextField?
    @IBOutlet var fahrenheitLabel: UILabel?
    @IBOutlet var mediatingLabel: UILabel?
    @IBOutlet var numberOfCDegrees: UILabel?
    @IBOutlet var celciusLabel: UILabel?
    var farhenheitValue: Measurement<UnitTemperature>? {
        didSet {
            updateCelciusLabel()
        }
    }
    private var celciusValue: Measurement<UnitTemperature>? {
        if let farhenheitValue = self.farhenheitValue {
            return farhenheitValue.converted(to: .celsius)
        } else {
            return nil
        }
    }
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    func updateCelciusLabel() {
        if let celciusValue = celciusValue {
            numberOfCDegrees?.text = numberFormatter.string(from: NSNumber(value: celciusValue.value))
        } else {
            numberOfCDegrees?.text = "???"
        }
    }
    
    @IBAction func handleFehrenheitInput(_ textField: UITextField) {
        if let text = textField.text, let value = Double(text) {
            farhenheitValue = Measurement(value: value, unit: .fahrenheit)
        } else {
            farhenheitValue = nil
        }
    }
    
    @IBAction func dissmissKeyboard(_ sender: UIGestureRecognizer) {
        numberOfFDegrees?.resignFirstResponder()
    }
}

