//
//  AddPersonViewController.swift
//  Death Note
//
//  Created by  Vladyslav Fil on 4/22/19.
//  Copyright © 2019  Vladyslav Fil. All rights reserved.
//

import UIKit

class AddPersonViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        nameTextField.smartInsertDeleteType = UITextSmartInsertDeleteType.no
        
        self.descTextView.layer.borderWidth = 0.5
        self.descTextView.layer.cornerRadius = 5.0
        self.descTextView.layer.borderColor = UIColor.black.cgColor
        
        self.datePicker.minimumDate = Date()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 10
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneSegue" {
            if let vc = segue.destination as? ViewController {
                let newPerson: Person = Person(name: nameTextField.text, description: descTextView.text, date: datePicker.date)
                if !newPerson.name!.isEmpty {
                    vc.persons.append(newPerson)
                    vc.tableView.reloadData()
                    print(newPerson)
                }
            }
        }
    }
    
    @IBAction func doneButton(_ sender: Any) {
        performSegue(withIdentifier: "doneSegue", sender: "AddAPerson")
    }
    
}
