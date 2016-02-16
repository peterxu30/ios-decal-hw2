//
//  KeyboardViewController.swift
//  CalKeyboard
//
//  Created by Gene Yoo on 9/15/15.
//  Copyright © 2015 iOS Decal. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    @IBOutlet var returnButton: UIButton!
    @IBOutlet var deleteButton: UIButton!
    @IBOutlet var gmailButton: UIButton!
    @IBOutlet var bmailButton: UIButton!
    @IBOutlet var facebookButton: UIButton!
    @IBOutlet var stackOverflowButton: UIButton!
    @IBOutlet var calCentralButton: UIButton!
    @IBOutlet var teleBearsButton: UIButton!
    
    var keyboardView: UIView!

    override func updateViewConstraints() {
        super.updateViewConstraints()
    
        // Add custom view sizing constraints here
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadInterface()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }

    override func textWillChange(textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }

    override func textDidChange(textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
    }
    
    func insertText(text: String) {
        var proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText(text)
    }
    
    func returnNewLine() {
        insertText("\n")
    }
    
    func deleteCharacter() {
        var proxy = textDocumentProxy as UITextDocumentProxy
        proxy.deleteBackward()
    }
    
/*  I copied the below code from: http://stackoverflow.com/questions/26362968/delete-entire-word-with-deletebackward-in-custom-keyboard-on-ios-8/32274429
    The delete key works normally with deleteCharacter but I thought it would be nice to be able to delete the
    whole url in one swipe. In my search for how to do that, I found this and so as to not reinvent the wheel, 
    am using it. Please do not arrest me.
 */
    func deleteAddress() {
        var proxy = textDocumentProxy as UITextDocumentProxy
        if let textArray:[String]? = proxy.documentContextBeforeInput?.componentsSeparatedByString(" "){
            if let validArray = textArray {
                for var i=0; i < validArray.last!.characters.count; i++ {
                    proxy.deleteBackward()
                }
            }
        }

    }
    
    func giveGmailAddress() {
        insertText("gmail.com")
    }
    
    func giveBmailAddress() {
        insertText("bmail.berkeley.edu")
    }
    
    func giveFacebookAddress() {
        insertText("facebook.com")
    }
    
    func giveStackOverflowAddress() {
        insertText("stackoverflow.com")
    }
    
    func giveCalCentralAddress() {
        insertText("calcentral.berkeley.edu")
    }
    
    func giveTeleBearsAddress() {
        insertText("telebears.berkeley.edu")
    }

    func loadTargets() {
        returnButton.addTarget(self, action: "returnNewLine", forControlEvents: .TouchUpInside)
        deleteButton.addTarget(self, action: "deleteCharacter", forControlEvents: .TouchUpInside)
        deleteButton.addTarget(self, action: "deleteAddress", forControlEvents: .TouchDragExit)
        gmailButton.addTarget(self, action:"giveGmailAddress", forControlEvents: .TouchUpInside)
        bmailButton.addTarget(self, action: "giveBmailAddress", forControlEvents: .TouchUpInside)
        facebookButton.addTarget(self, action: "giveFacebookAddress", forControlEvents: .TouchUpInside)
        stackOverflowButton.addTarget(self, action: "giveStackOverflowAddress", forControlEvents: .TouchUpInside)
        calCentralButton.addTarget(self, action: "giveCalCentralAddress", forControlEvents: .TouchUpInside)
        teleBearsButton.addTarget(self, action: "giveTeleBearsAddress", forControlEvents: .TouchUpInside)
    }
    
    func loadInterface() {
        let keyboardNib = UINib(nibName: "Keyboard", bundle: nil)
        keyboardView = keyboardNib.instantiateWithOwner(self, options: nil)[0] as! UIView
        keyboardView.frame = view.frame
        view.addSubview(keyboardView)
        view.backgroundColor = keyboardView.backgroundColor
        nextKeyboardButton.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside) // advanceToNextInputMode is already defined in template
        loadTargets()
        
    }


}
