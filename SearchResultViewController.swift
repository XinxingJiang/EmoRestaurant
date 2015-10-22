//
//  SearchResultViewController.swift
//  EmoRestaurant
//
//  Created by Xinxing Jiang on 3/15/15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

class SearchResultViewController: UITableViewController {
    
    // MARK: Model
    
    var category: String? {
        didSet {
            let query = PFQuery(className: Database.Restaurant)
            query.whereKey(Database.RestaurantCategory, equalTo: category!)
            query.findObjectsInBackgroundWithBlock { (data, error) in
                if let result = data as? [PFObject] {
                    self.restaurants = result
                }
            }
        }
    }
    
    var restaurants: [PFObject]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBarHidden = false
    }
    
    // MARK: - Table View Data Source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.CellReuseIdentifier, forIndexPath: indexPath) as! RestaurantCellView
        if let restaurant = restaurants?[indexPath.row] {
            if let imageFile = restaurant.objectForKey(Database.ProfileImage) as? PFFile {
                let imageData = imageFile.getData()
                let image = UIImage(data: imageData)
                cell.restaurantImageView.image = image
            }
            let chineseName = restaurant.objectForKey(Database.RestaurantChineseName) as! String
            let name = restaurant.objectForKey(Database.RestaurantName) as! String
            var restaurantName = name
            
            if chineseName.characters.count > 0 {
                restaurantName += " (\(chineseName))"
            }
            cell.restaurantNameLabel.text = restaurantName
            cell.backgroundColor = UIColor.whiteColor()
        }
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case StoryBoard.ShowARestaurant:
                if let rvc = segue.destinationViewController as? RestaurantViewController {
                    if let indexPath = tableView.indexPathForCell(sender as! RestaurantCellView) {
                        rvc.restaurant = restaurants?[indexPath.row]
                    }
                }
            default:
                break
            }
        }
    }
    
    // MARK: - Constants
    
    private struct Constants {
        static let CellReuseIdentifier = "RestaurantCellView"
    }
}