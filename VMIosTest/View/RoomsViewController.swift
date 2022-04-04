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
        let appTheme = AppTheme.shared
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor(hex: appTheme?.primaryColor ?? "")]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if roomsViewModel.roomsList.count == 0 {
            getRooms() //try to fecth rooms list again
        }
    }
    
    // MARK: Other methods
    func getRooms() {
        roomsViewModel.fetchList(endPoint: Constants.roomsUrlEndPoint, { [weak self] result in
            switch result {
            case .success:
                debugPrint(self?.roomsViewModel.roomsList as Any)
                DispatchQueue.main.async {
                    self?.roomsTableView.reloadData()
                }
            case .failure(let error):
                showAlertWithCompletion(message: "No data found", okTitle: "OK", cancelTitle: nil) { okPressed in
                    
                }
                debugPrint(error.localizedDescription)
            }
        })
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

