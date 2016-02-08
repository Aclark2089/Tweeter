//
//  TimelineViewController.swift
//  Tweeter
//
//  Created by Alex Clark on 2/7/16.
//  Copyright © 2016 R. Alex Clark. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // Outlets
    
    // Logout
    @IBOutlet var logoutButton: UIButton!
    
    // Tableview Outlets
    @IBOutlet var tableView: UITableView!
    
    // Variables
    var tweets: [Tweet]!
    var params: NSDictionary!
    var refreshController: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Setup tableView data / delegation
        tableView.delegate = self
        tableView.dataSource = self
        
        setupRefreshController()
        
        // Get home timeline
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        })
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 160

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets!.count
        } else {
            return 0
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        cell.tweet = tweets![indexPath.row]
        
        return cell
    }
    
    // Refresh Controller
    func setupRefreshController() {
        
        self.refreshController = UIRefreshControl()
        self.refreshController.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshController)
    
    }
    
    // Refresh Function
    func refresh(sender:AnyObject) {
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        })
        refreshController?.endRefreshing()
    }
    
    // Actions
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }


    // Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Select this cell of the tableview structure
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        
        
        // Get this tweet
        let tweet = tweets![indexPath!.row]
        
        
        // Assign the detail view controller
        let detailViewController = segue.destinationViewController as! TweetDetailViewController
        
        
        // Set the tweet content
        detailViewController.tweet = tweet
    }

}
