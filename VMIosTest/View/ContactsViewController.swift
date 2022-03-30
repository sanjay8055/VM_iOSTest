//
//  ContactsViewController.swift
//  VMIosTest
//
//  Created by Sanjay Raskar on 29/03/22.
//

import UIKit

class ContactsViewController: UIViewController {

    var contactsViewModel: ContactsViewModel = ContactsViewModel()
    @IBOutlet weak var contactsTableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)

    // MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        contactsTableView.dataSource = self
        contactsTableView.delegate = self
        self.title = "Contacts"
        getContacts()
        cache.countLimit = 20
        let appTheme = AppTheme.shared
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor(hex: appTheme?.primaryColor ?? "")]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        setupSearchBar()
    }
    
    func setupSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        self.contactsTableView.tableHeaderView = searchController.searchBar
    }

    // MARK: Other methods
    func getContacts() {
        contactsViewModel.fetchList(endPoint: Constants.contactsUrlEndPoint, { [weak self] result in
            switch result {
            case .success:
                print(self?.contactsViewModel.contactsList as Any)
                DispatchQueue.main.async {
                    self?.contactsTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}

// MARK: Tableview datasource
extension ContactsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchController.isActive ? contactsViewModel.filteredContactsList.count : contactsViewModel.contactsList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: StoryBoradIdentifiers.contactCellId) as? ContactsTableViewCell else {
            return UITableViewCell()
        }
        let contact = self.searchController.isActive ? contactsViewModel.filteredContactsList[indexPath.row] : contactsViewModel.contactsList[indexPath.row]
        if let url = URL(string: contact.avatar) {
            cell.contactImageView.loadImage(url)
        }
        cell.contactLabel?.text = contact.firstName + " " + contact.lastName
        cell.setAccessibility(contactDetail: contact)
        return cell
    }

}
// MARK: Tableview delegate
extension ContactsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let Vc =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: StoryBoradIdentifiers.contactDetailsViewControllerId) as? ContactDetailsViewController else { return }
        Vc.contactDetails = self.searchController.isActive ? contactsViewModel.filteredContactsList[indexPath.row] : contactsViewModel.contactsList[indexPath.row]
        self.navigationController?.pushViewController(Vc, animated: true)
        //self.searchController.searchBar.resignFirstResponder()
        self.searchController.isActive = false
    }
}

extension ContactsViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text =  searchController.searchBar.text {
            contactsViewModel.filterSearchresult(searchText: text) { _ in
                self.contactsTableView.reloadData()
            }
        }
    }
    
}
