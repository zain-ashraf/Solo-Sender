//
//  ViewController.swift
//  Inviter-App-xCode
//
//  Created by Enduser on 11/17/23.
//

import UIKit
import MessageUI

class ViewController: UIViewController,MFMessageComposeViewControllerDelegate {
    
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true) {
                    switch result {
                    case .sent:
                        print("Message sent successfully!")
                    case .cancelled:
                        print("Message sending cancelled.")
                    case .failed:
                        print("Message sending failed.")
                    @unknown default:
                        fatalError("New case added in MessageComposeResult.")
                    }
                }
            }
    
 
    @IBOutlet weak var messageTextField: UITextField!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBAction func sendButton(_ sender: UIButton) {
        guard let message = messageTextField.text, !message.isEmpty, let numbers = phoneNumberTextField.text?.components(separatedBy: ",").map({ $0.trimmingCharacters(in: .whitespacesAndNewlines) }),
              // everything above this retrieves the message and phone numbers
              !numbers.isEmpty else {
            print("message or phone number is empty.")
            return
        } // this else statements handles a case where the number is empty
        
        for number in numbers {
            sendSMS(message: message, recipients: numbers)
        }
    
        
        func sendSMS(message: String, recipients: [String]) {
            if MFMessageComposeViewController.canSendText() {
                let messageController = MFMessageComposeViewController()
                messageController.body = message
                messageController.recipients = recipients
                messageController.messageComposeDelegate = self
                
                present(messageController, animated: true)
            }
            else
            {
                print("Device unable to send messages.")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

