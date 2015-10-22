//
//  FavoritesViewController.swift
//  EmoRestaurant
//
//  Created by Xinxing Jiang on 3/15/15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

class FavoritesViewController: UITableViewController {

    // MARK: - Model
    
    var restaurants: [PFObject] = [PFObject]() {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - View Controller View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        refreshRestaurants() // get user's favorite restaurants
        tableView.reloadData()
        navigationController?.navigationBarHidden = true
    }

    // MARK: - Table View Data Source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.CellReuseIdentifier, forIndexPath: indexPath) as! RestaurantCellView
        let restaurant = restaurants[indexPath.row]
        if let imageFile = restaurant.objectForKey(Database.ProfileImage) as? PFFile {
            let imageData = imageFile.getData()
            let image = UIImage(data: imageData)
            cell.restaurantImageView.image = image
        }
        if let name = restaurant.objectForKey(Database.RestaurantName) as? String {
            cell.restaurantNameLabel.text = name
            cell.backgroundColor = UIColor.whiteColor()
        }
        return cell
    }

    // MARK: Load data
    
    // get all restaurants the user has marked as favorite (at most 10)
    // max number = 10 is maintained when marking restaurant as favorite
    private func refreshRestaurants() {
        restaurants.removeAll()
        let currentUser = PFUser.currentUser()
        var query = PFQuery(className: Database.UserAndRestaurant)
        query.whereKey(Database.Username, equalTo: currentUser.username)
        query.findObjectsInBackgroundWithBlock { (data, error) in
            if error == nil {
                if let result = data as? [PFObject] {
                    for item in result {
                        if let restaurantName = item.valueForKey(Database.Restaurant) as? String {
                            query = PFQuery(className: Database.Restaurant)
                            query.whereKey(Database.RestaurantName, equalTo: restaurantName)
                            query.findObjectsInBackgroundWithBlock { (data2, error2) in
                                if error2 == nil {
                                    if let result2 = data2 as? [PFObject] { // there should be only 1 element
                                        if result2.count == 1 {
                                            let restaurant = result2.first!
                                            self.restaurants.append(restaurant)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case StoryBoard.ShowARestaurant:
                if let rvc = segue.destinationViewController as? RestaurantViewController {
                    if let indexPath = tableView.indexPathForCell(sender as! RestaurantCellView) {
                        rvc.restaurant = restaurants[indexPath.row]
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
