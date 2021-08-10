//
//  ViewController.swift
//  Prework
//
//  Created by Qin Ying Chen on 8/10/21.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var calculateTotalBtn: UIButton!
    @IBOutlet weak var clearBtn: UIButton!
    
    let tipPercentage = [0.15, 0.18, 0.2, 0]
    
    // use return to close keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "LazyTip"
        billAmountTextField.delegate = self
        setupAddTargetIsNotEmptyTextFields()
    }
    
    
    /* functions to handle user action functionalities */
    
    func setupAddTargetIsNotEmptyTextFields(){
        // hide buttons
        calculateTotalBtn.isHidden = true
        clearBtn.isHidden = true
        tipControl.isEnabled = false
        
        // to detect any changes in text field
        billAmountTextField.addTarget(self, action: #selector(textFieldIsNotEmpty), for: .editingChanged)
    }
    
    @objc func textFieldIsNotEmpty(sender: UITextField) {
        sender.text = sender.text?.trimmingCharacters(in: .whitespaces)
        
        guard
            let billAmt = billAmountTextField.text, !billAmt.isEmpty
            else
        {
            // hide buttons if text field is empty
            calculateTotalBtn.isHidden = true
            clearBtn.isHidden = true
            tipControl.isEnabled = false
            return
        }
        // enable buttons if all conditions are met (i.e. if text field is not empty)
        calculateTotalBtn.isHidden = false
        clearBtn.isHidden = false
        tipControl.isEnabled = true
    }

    @IBAction func calculateTotalBtnPressed(_ sender: Any) {
        calculateTotalBill()
    }
    
    @IBAction func clearBtnPressed(_ sender: Any) {
        // reset all fields
        billAmountTextField.text = ""
        tipControl.selectedSegmentIndex = 0
        tipAmountLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        setupAddTargetIsNotEmptyTextFields()
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        calculateTotalBill()
    }
    
    
    /* functions to handle total bill calculations */
    
    func calculateTotalBill(){
        // get bill amount from text field
        let bill = Double(billAmountTextField.text!) ?? 0
        // get total tip (bill * tip%)
        let tip = bill*tipPercentage[tipControl.selectedSegmentIndex]
        // calculate total cost
        let total = tip + bill
        
        // update labels
        updateLabels(tipAmt: tip, total: total)
    }
    
    func updateLabels(tipAmt: Double, total: Double){
        // update tip and total amount labels
        tipAmountLabel.text = String(format: "$%.2f", tipAmt)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
}

