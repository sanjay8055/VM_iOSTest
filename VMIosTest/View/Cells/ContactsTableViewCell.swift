//
//  ContactsTableViewCell.swift
//  VMIosTest
//
//  Created by Sanjay Raskar on 29/03/22.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {
    @IBOutlet weak var contactImageView: UIImageView!
    @IBOutlet weak var contactLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        contactImageView.layer.cornerRadius = contactImageView.frame.height / 2
        contactImageView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setAccessibility(contactDetail: Contact) {
        self.contactImageView.accessibilityTraits = .image
        self.contactImageView.accessibilityLabel = contactDetail.firstName + contactDetail.lastName
        self.contactLabel.accessibilityLabel = "Contact Name"
        self.contactLabel.isAccessibilityElement = true
        self.contactLabel.accessibilityValue = contactDetail.firstName + contactDetail.lastName
        self.contactLabel.accessibilityTraits = .none
    }

}
