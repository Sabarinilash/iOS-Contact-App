//
//  ListOfContactsDetailsVC.swift
//  SabariNilash
//


import UIKit


class ListOfContactsDetailsVC: UIViewController, UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate {
    
     @IBOutlet weak var contactTableVW: UITableView!
     @IBOutlet weak var profileImg: UIImageView!
    
    var contactDetails:list_ContactModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        contactTableVW.backgroundColor =  UIColor (hex:"F795A5").withAlphaComponent(0.1)
        self.title = "Contact Details"
        contactTableVW.tableFooterView = UIView()
        profileImg.layer.cornerRadius = profileImg.frame.width/2
        profileImg.layer.borderWidth = 2
        profileImg.layer.borderColor = UIColor.purple.cgColor
        profileImg.layer.masksToBounds = true
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  8
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListOfcontactsCell", for: indexPath)
        cell.backgroundColor = UIColor.clear
        tableView.backgroundColor = UIColor (hex:"963373").withAlphaComponent(0.1)
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textColor = UIColor (hex:"CC3E7A")
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = String(format:"Title: %@",contactDetails?.Name?.title ?? "")
        case 1:
            cell.textLabel?.text = String(format:"Name: %@ %@",contactDetails?.Name?.first ?? "", contactDetails?.Name?.last ?? "")
        case 2:
            cell.textLabel?.text =  String(format:"Street: %@",contactDetails?.Location?.street ?? "")
        case 3:
            cell.textLabel?.text = String(format:"City: %@",contactDetails?.Location?.city ?? "")
        case 4:
            cell.textLabel?.text =  String(format:"PostCode: %@",contactDetails?.Location?.postcode ?? "")
        case 5:
            cell.textLabel?.text = String(format:"Email: %@",contactDetails?.email ?? "")
        case 6:
            cell.textLabel?.text = String(format:"Phone: %@",contactDetails?.phone ?? "")
        case 7:
            cell.textLabel?.text = String(format:"CELL: %@",contactDetails?.cell ?? "")
        
            
        default: break
            
        }
        
        return cell
    }
    
  
    override func viewWillAppear(_ animated: Bool) {
        if let url = URL(string: contactDetails?.Picture?.large ?? ""){
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        //self.profileImg.image = UIImage(data:data)
                        
                        self.profileImg.image =  UIImage(data:data)
                        
//                        self.profileImg.UIImage.cornerRadius = self.profileImg.image.frame.size.width / 2
//
//                        self.profileImg.clipsToBounds = true
//
//                        self.profileImg.layer.borderColor = UIColor.white.cgColor
//
//                        self.profileImg.UIImage.borderWidth = 5
                        
                    }
                }
            }
        }
    }
}
    

