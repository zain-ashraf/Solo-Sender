//
//  ViewController.swift
//  Inviter-App-xCode
//
//  Created by Enduser on 11/17/23.
//

import UIKit

class ViewController: UIViewController {

    

 
    @IBOutlet weak var messageTextField: UITextField!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBAction func sendButton(_ sender: UIButton) {
        guard let message = messageTextField.text, !message.isEmpty, let numbers = phoneNumberTextField.text?.components(separatedBy: ",").map({ $0.trimmingCharacters(in: .whitespacesAndNewlines) }),
              !numbers.isEmpty else {
                    print("message or phone number is empty.")
                    return
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

