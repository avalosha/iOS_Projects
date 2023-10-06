//
//  SideMenuViewController.swift
//  Targets
//
//  Created by Sferea-Lider on 29/09/23.
//

import UIKit

protocol SideMenuViewControllerDelegate: NSObjectProtocol {
    func selectedCell(_ option: MenuOptions)
}

class SideMenuViewController: UIViewController {

    @IBOutlet weak var sideMenuTableView: UITableView!
    @IBOutlet weak var footerLbl: UILabel!
    
    var defaultHighlightedCell: Int = 0
    var menu: [SideMenuModel] = [
        SideMenuModel(icon: UIImage(systemName: "house.fill")!, title: "Home"),
        SideMenuModel(icon: UIImage(systemName: "music.note")!, title: "Music"),
        SideMenuModel(icon: UIImage(systemName: "film.fill")!, title: "Movies"),
        SideMenuModel(icon: UIImage(systemName: "book.fill")!, title: "Books"),
        SideMenuModel(icon: UIImage(systemName: "person.fill")!, title: "Profile"),
        SideMenuModel(icon: UIImage(systemName: "slider.horizontal.3")!, title: "Settings"),
        SideMenuModel(icon: UIImage(systemName: "hand.thumbsup.fill")!, title: "Like us on facebook")
    ]
    
    weak var delegate: SideMenuViewControllerDelegate? = nil
    
    var selectedIndex = 0
    var menuItems: [MenuOptions] = MenuOptions.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }
    
    private func setupTableView() {
        sideMenuTableView.delegate = self
        sideMenuTableView.dataSource = self
        sideMenuTableView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        sideMenuTableView.separatorStyle = .none
        
        // Set Highlighted Cell
        DispatchQueue.main.async {
            let defaultRow = IndexPath(row: self.defaultHighlightedCell, section: 0)
            self.sideMenuTableView.selectRow(at: defaultRow, animated: false, scrollPosition: .none)
        }
        
        // Footer
        footerLbl.textColor = UIColor.white
        footerLbl.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        footerLbl.text = "Developed by Álvaro Ávalos"
        
        // Register TableView Cell
        self.sideMenuTableView.register(SideMenuCell.nib, forCellReuseIdentifier: SideMenuCell.identifier)

        // Update TableView with the data
        self.sideMenuTableView.reloadData()
    }

}

extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuCell.identifier, for: indexPath) as? SideMenuCell else { fatalError("xib doesn't exist") }

        cell.iconImg.image = self.menu[indexPath.row].icon
        cell.titleLbl.text = self.menu[indexPath.row].title

        // Highlighted color
        let myCustomSelectionColorView = UIView()
        myCustomSelectionColorView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.selectedBackgroundView = myCustomSelectionColorView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        delegate?.selectedCell(menuItems[selectedIndex])
    }
}

enum MenuOptions: String, CaseIterable {
    case home = "Home"
    case music = "Music"
    case film = "Film"
    case book = "Book"
    case person = "Person"
    case settings = "Settings"
    case facebook = "Facebook"
    
    var storyboard: String{
        get {
            switch self {
            case .home:
                return "tabBar"
            case .music:
                return "example"
            case .film:
                return "example"
            case .book:
                return "example"
            case .person:
                return "profile"
            case .settings:
                return "example"
            case .facebook:
                return "example"
            }
        }
    }
    
    var storyId: String{
        get {
            switch self {
            case .home:
                return "TabNavID"
            case .music:
                return "ExampleNavID"
            case .film:
                return "ExampleNavID"
            case .book:
                return "ExampleNavID"
            case .person:
                return "ProfileNavID"
            case .settings:
                return "ExampleNavID"
            case .facebook:
                return "ExampleNavID"
            }
        }
    }
}