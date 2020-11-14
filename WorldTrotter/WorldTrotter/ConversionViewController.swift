//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by James Dunn on 11/5/20.
//

import UIKit

class ConversionViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateCelciusLabel()
        
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
    
    @IBAction func handleFehrenheitInput(_ textField: UITextField) {
        if let text = textField.text, let value = Double(text) {
            farhenheitValue = Measurement(value: value, unit: .fahrenheit)
        } else {
            farhenheitValue = nil
        }
    }
    
    func updateCelciusLabel() {
        if let celciusValue = celciusValue {
            numberOfCDegrees?.text = numberFormatter.string(from: NSNumber(value: celciusValue.value))
        } else {
            numberOfCDegrees?.text = "???"
        }
    }
    
    @IBAction func dissmissKeyboard(_ sender: UIGestureRecognizer) {
        numberOfFDegrees?.resignFirstResponder()
    }
}

