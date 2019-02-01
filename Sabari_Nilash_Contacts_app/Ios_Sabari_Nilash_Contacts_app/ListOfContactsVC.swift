//
//  ViewController.swift
//  Ios_Sabari_Nilash_Contacts_app
//
//  Created by epita on 16/01/2019.
//  Copyright © 2019 epita. All rights reserved.
//

import UIKit

class ListOfContactsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var dataTask: URLSessionDataTask?
    var listContact = NSMutableArray()
    
    @IBOutlet weak var contactTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        contactTable.tableFooterView = UIView()
        contactTable.dataSource = self
        contactTable.delegate = self
        self.title = "Contacts App"
        self.listofContacts()
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.listContact.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ListOfContactCell = tableView.dequeueReusableCell(withIdentifier: "ContactListCell", for: indexPath) as!  ListOfContactCell
        let contact = self.listContact.object(at:indexPath.row) as?  list_ContactModel
        cell.textLabel?.text = String(format:"%@ %@ %@",contact?.Name?.title ?? "  ",contact?.Name?.first ?? "",contact?.Name?.last ?? "")
        cell.detailTextLabel?.text = String(format:"%@",contact?.email ?? "")
        
        if let url = URL(string: contact?.Picture?.thumbnail ?? ""){
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    let newImage = self.resizeImage(image: UIImage(data: data)!, toTheSize: CGSize(width:32,height:32))
                    DispatchQueue.main.async {
                        let cellImageLayer: CALayer?  = cell.imageView?.layer
                        cellImageLayer!.cornerRadius = 16
                        cellImageLayer!.masksToBounds = true
                        cell.imageView?.image = newImage
                    }
                }
            }
        }
        
       //TableViewCell
        
        cell.textLabel?.textColor = UIColor(hex:"CC3E7A")
        cell.detailTextLabel?.textColor = UIColor(hex: "F795A5")
        cell.textLabel?.backgroundColor = UIColor.clear
        cell.detailTextLabel?.backgroundColor = UIColor.clear
        
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = UIColor (hex:"963373").withAlphaComponent(0.4)
        } else {
            cell.backgroundColor = UIColor (hex:"963373").withAlphaComponent(0.1)
        }
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListOfContactDetailsVC") as? ListOfContactsDetailsVC {
            viewController.contactDetails =  self.listContact.object(at:indexPath.row) as?  list_ContactModel
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
    
    func resizeImage(image:UIImage, toTheSize size:CGSize)->UIImage{
        let scale = CGFloat(max(size.width/image.size.width,
                                size.height/image.size.height))
        let width:CGFloat  = image.size.width * scale
        let height:CGFloat = image.size.height * scale;
        let rr:CGRect = CGRect(x:0,y:0,width:width, height:height);
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0);
        image.draw(in: rr)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        return newImage ?? UIImage()
    }
    
    func listofContacts() {
        dataTask?.cancel()
        if var api_url = URLComponents(string: "https://randomuser.me/api/?results=50&seed=KURAPATI") {
            guard let url = api_url.url else { return }
            
            let defaultSession = URLSession(configuration: .default)

            dataTask = defaultSession.dataTask(with: url) { data, response, error in
                defer { self.dataTask = nil }
                
                if let error = error {
                    print(error.localizedDescription)
                    
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with:
                            data, options: [])
                        if let jsondict = jsonResponse as? [String: Any]  {
                            if let jsonArray = jsondict["results"] as? [[String: Any]] {
                                print(jsonArray)
                                for dic in jsonArray{
                                    let cModel = list_ContactModel()
                                    cModel.initData(random:dic)
                                    self.listContact.add(cModel)
                                }
                            }
                        }
                    } catch let parsingError {
                        print("Error", parsingError)
                    }
                    DispatchQueue.main.async {
                        self.contactTable.reloadData()
                    }
                }
            }
            dataTask?.resume()
        }
    }

}

