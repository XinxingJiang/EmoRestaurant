//
//  SearchResultTableViewController.swift
//  EmoRestaurant
//
//  Created by YUE on 3/3/15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {

    // MARK: - Model
    
    var categories = RestaurantCategory.Values
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
    }
    
    // MARK: - Table View Data Source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.CellReuseIdentifier, forIndexPath: indexPath) as! CategoryCellView
        let category = categories[indexPath.row]
        cell.categoryLabel.text = category
        return cell
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case StoryBoard.SearchResult:
                if let srvc = segue.destinationViewController as? SearchResultViewController {
                    if let cell = sender as? CategoryCellView {
                        srvc.category = cell.categoryLabel.text
                    }
                }
            default:
                break
            }
        }
    }
    
    // MARK: - Constants
    
    private struct Constants {
        static let CellReuseIdentifier = "CategoryCellView"
    }
}
