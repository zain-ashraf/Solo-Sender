//
//  ViewController.swift
//  Inviter-App-xCode
//
//  Created by Enduser on 11/17/23.
//

import UIKit
import MessageUI
import ContactsUI

class ViewController: UIViewController,MFMessageComposeViewControllerDelegate, UITextFieldDelegate, UITextViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        messageTextView.delegate = self
        phoneNumberTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
    
    
    @IBOutlet weak var messageTextView: UITextView!
    
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
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
    
    @IBAction func sendButton(_ sender: UIButton) {
        guard let message = messageTextView.text, !message.isEmpty, let numbers = phoneNumberTextField.text?.components(separatedBy: ",").map({ $0.trimmingCharacters(in: .whitespacesAndNewlines) }),
              // everything above this retrieves the message and phone numbers
              !numbers.isEmpty else {
            print("message or phone number is empty.")
            return
        } // this else statements handles a case where the number is empty
        
        sendMessagesSequentially(numbers: numbers, message: message)
    }
    
    func sendMessagesSequentially(numbers: [String], message: String) {
        sendNextMessage(0, numbers: numbers, message: message)
    }
    
    func sendNextMessage(_ index: Int, numbers: [String], message: String) {
        guard index < numbers.count else {
            print("All messages sent")
            return
        }
        
        let recipient = numbers[index]
        sendSMS(message: message, recipient: recipient)
        
        // adds delay between each message being sent
        DispatchQueue.main.asyncAfter(deadline: .now() + 8.0) {
            self.sendNextMessage(index + 1, numbers: numbers, message: message)
        }
        
        func sendSMS(message: String, recipient: String) {
            if MFMessageComposeViewController.canSendText() {
                let messageController = MFMessageComposeViewController()
                messageController.body = message
                messageController.recipients = [recipient]
                messageController.messageComposeDelegate = self
                
                present(messageController, animated: true)
            }
            else
            {
                print("Device unable to send messages.")
            }
        }
    }
}
    
