//
//  TimelineViewController.swift
//  Tweeter
//
//  Created by Alex Clark on 2/7/16.
//  Copyright © 2016 R. Alex Clark. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController {

    // Outlets
    
    // Logout
    @IBOutlet var logoutButton: UIButton!
    
    // Tableview Outlets
    @IBOutlet var tableView: UITableView!
    
    // Variables
    var tweets: [Tweet]?
    var params: NSDictionary!
    var refreshController: UIRefreshControl!
    var isMoreDataLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Setup tableView data / delegation
        tableView.delegate = self
        tableView.dataSource = self
        
        // Setup tableview cell sizes and row height for auto layout
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 160
        
        // Setup refresh controller
        setupRefreshController()
        
        // Get home timeline, assign the tweets and refresh timeline
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Refresh Controller
    func setupRefreshController() {
        self.refreshController = UIRefreshControl()
        self.refreshController.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshController)
    }
    
    // Refresh Function for the Refresh Controller
    func refresh(sender:AnyObject) {
        // Call timeline and reload if successful
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        })
        refreshController?.endRefreshing()
    }
    
    // User logout action
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }

    // Segue handler
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "NewTweetSegue") {
            let newTweetViewController = segue.destinationViewController as! NewTweetViewController
            
        }
        else {
            // Select this cell of the tableview structure
            let cell = sender as! TweetCell
            let indexPath = tableView.indexPathForCell(cell)
            
            
            // Get this tweet
            let tweet = tweets![indexPath!.row]
            
            
            // Assign the detail view controller
            let detailViewController = segue.destinationViewController as! TweetDetailViewController
            
            
            // Set the tweet content
            detailViewController.tweet = tweet
        }

    }
}


// Tableview Extensions
extension TimelineViewController: UITableViewDelegate, UITableViewDataSource {

    // Set table cell count to number of tweets we have received
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets!.count
        } else { // No tweets
            return 0
        }
    }
    
    // Handle setting each cell to one TweetCell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Get this cell @ indexPath
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        // If we have tweets, set the one for this indexPath to the current cell
        if tweets != nil {
            cell.tweet = tweets![indexPath.row]
        }
        
        // Return and go on to next cell
        return cell
    }
    
    // Deselect the cell after it is selected for the detail view
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    

}

// Scrollview Extensions
extension TimelineViewController: UIScrollViewDelegate {

    // Check if we need to load more data
    func loadDataOnScroll() {
        self.isMoreDataLoading = false
    }
    
    // If tableView was scrolled through
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        // If more data is loading
        if(!isMoreDataLoading){
            
            // set the tableview content height size of the scrollView && set the offset of the new scrollview content
            let scrollViewContentHeight = tableView.contentSize.height;
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            // If scrollview y pos is @ more than the allowed offset and tableview is being dragged, we load more tweets
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.dragging) {
                
                isMoreDataLoading = true
                
                // Code to load more results
                loadDataOnScroll()
                scrollView.contentOffset.y = 0
            }
            
        }
    }
}
