//
//  ContactDetailsViewController.swift
//  VMIosTest
//
//  Created by Sanjay Raskar on 29/03/22.
//

import UIKit

class ContactDetailsViewController: UIViewController {
    @IBOutlet weak var contactImageView: UIImageView!
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var favColorLabel: UILabel!
    @IBOutlet weak var contactEmailTextView: UITextView!
    @IBOutlet weak var contactNameLabel: UILabel!
    
    var contactDetails: Contact?
    
    // MARK: view Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        contactImageView.layer.masksToBounds = true
        setupContactDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidLayoutSubviews() {
        contactImageView.layer.cornerRadius = contactImageView.frame.size.width / 2
        super.viewDidLayoutSubviews()
        
    }
    
    // MARK: Other methods
    func setupContactDetails() {
        if let contactDetails = contactDetails {
            if let url = URL(string: contactDetails.avatar) {
                self.contactImageView.loadImage(url)
            }
            self.jobTitleLabel.text = contactDetails.jobtitle
            self.contactNameLabel.text = contactDetails.firstName + " " + contactDetails.lastName
            self.contactEmailTextView.text = contactDetails.email
            self.contactEmailTextView.dataDetectorTypes = .link
            self.contactEmailTextView.isHidden = false
            self.contactEmailTextView.textColor = .black
            self.favColorLabel.text = contactDetails.favouriteColor
            
            self.contactNameLabel.accessibilityValue = contactNameLabel.text
            self.jobTitleLabel.accessibilityValue = jobTitleLabel.text
            contactEmailTextView.accessibilityValue = contactEmailTextView.text
            self.favColorLabel.accessibilityValue = favColorLabel.text
        } else {
            debugPrint("No contact details found")
        }
        
        
    }


}
