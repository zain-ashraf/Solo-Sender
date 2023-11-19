//
//  ViewController.swift
//  Inviter-App-xCode
//
//  Created by Enduser on 11/17/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func messageTextField(_ sender: UITextField) {
    }
    
    @IBAction func phoneNumberTextField(_ sender: UITextField) {
    }
    
    @IBAction func sendButton(_ sender: UIButton) {
        guard let message = messageTextField.text, !message.isEmpty, let numbers = phoneNumberTextField.text?.components(separatedBy: ",").map({ $0.trimmingCharacters(in: .whitespacesAndNewlines) }),
              !numbers.isEmpty else {
                    print("message or phone number is empty.")
                    return
        }
        
    }
    
}

