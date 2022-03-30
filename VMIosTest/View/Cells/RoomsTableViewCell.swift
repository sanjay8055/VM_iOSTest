//
//  RoomsTableViewCell.swift
//  VMIosTest
//
//  Created by Sanjay Raskar on 29/03/22.
//

import UIKit

class RoomsTableViewCell: UITableViewCell {
    @IBOutlet weak var roomIdLabel: UILabel!
    @IBOutlet weak var roomCapacityLabel: UILabel!
    @IBOutlet weak var availabiltyLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //set accessibilty values
    func setAccessibility(roomDetail: Room) {
        roomIdLabel.accessibilityLabel = "Room Number"
        roomIdLabel.accessibilityValue = String(roomDetail.id)
        roomIdLabel.isAccessibilityElement = true
        roomIdLabel.accessibilityTraits = .none

        roomCapacityLabel.accessibilityLabel = "Capacity"
        roomCapacityLabel.accessibilityValue = String(roomDetail.maxOccupancy)
        roomCapacityLabel.accessibilityTraits = .none
        roomCapacityLabel.isAccessibilityElement = true

        availabiltyLabel.accessibilityLabel = "Room status"
        availabiltyLabel.accessibilityValue = roomDetail.isOccupied ? "Available" : "Not Available"
        availabiltyLabel.isAccessibilityElement = true
        availabiltyLabel.accessibilityTraits = .none

    }
}
