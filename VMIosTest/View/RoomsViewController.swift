//
//  RoomsViewController.swift
//  VMIosTest
//
//  Created by Sanjay Raskar on 29/03/22.
//

import UIKit

class RoomsViewController: UIViewController {

    var roomsViewModel: RoomsViewModel = RoomsViewModel()
    
    @IBOutlet weak var roomsTableView: UITableView!

    // MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        roomsTableView.dataSource = self
        self.title = "Rooms"
        getRooms()
        let appTheme = AppTheme.shared
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor(hex: appTheme?.primaryColor ?? "")]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }

    // MARK: Other methods
    func getRooms() {
        roomsViewModel.fetchList { [weak self] result in
            switch result {
            case .success:
                print(self?.roomsViewModel.roomsList as Any)
                DispatchQueue.main.async {
                    self?.roomsTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: Tableview data source
extension RoomsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomsViewModel.roomsList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: StoryBoradIdentifiers.roomsCellId) as? RoomsTableViewCell else {
            return UITableViewCell()
        }
        let room = roomsViewModel.roomsList[indexPath.row]
        
        cell.roomIdLabel.text =  "Room: \(room.id)"
        cell.roomCapacityLabel.text =  "Capacity: \(room.maxOccupancy)"
        cell.availabiltyLabel.text =  room.isOccupied ? "Not Available" : "Available"
        cell.availabiltyLabel.textColor = room.isOccupied ? UIColor(hex: AppTheme.shared?.primaryColor ?? "") : UIColor.blue
        cell.setAccessibility(roomDetail: room)
        return cell
    }

}

