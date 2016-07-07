//
//  NetworkGamesViewController.swift
//  o_X
//
//  Created by Daniel Seong on 7/4/16.
//  Copyright © 2016 iX. All rights reserved.
//

import UIKit

class NetworkGamesViewController: UITableViewController {
    
    @IBOutlet var tableview: UITableView!
    
    private var games = [OXGame]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
       
       
        
        tableview.delegate = self
        tableview.dataSource = self
        
    }
    
    override func viewDidAppear(animated: Bool) {
        OXGameController.sharedInstance.getGames(onCompletion: {(games, error) in
            if let game = games {
                self.games = game
                self.tableview.reloadData()
            }
            else {
                let alert = UIAlertController(title: "Error", message: error , preferredStyle: UIAlertControllerStyle.Alert)
                let alertAction = UIAlertAction(title: "Dismiss", style: .Default, handler: nil)
                alert.addAction(alertAction)
                self.presentViewController(alert, animated: true, completion: nil)
            }
            // self.data = [string!, OXGameController.sharedInstance.host, OXGameController.sharedInstance.ID]
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func creategamebuttonpressed(sender: UIBarButtonItem) {
        OXGameController.sharedInstance.createNewGame { (game, error) in
            if error == nil {
                self.performSegueWithIdentifier("boardnetwork", sender: nil)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return games.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        OXGameController.sharedInstance.joingame(games[indexPath.row].ID) { (game, error) in
            if error == nil {
                self.performSegueWithIdentifier("boardnetwork", sender: nil)
            }
        }
    }

    @IBAction func backbuttonpressed(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellIdentifier", forIndexPath: indexPath)
        
        cell.textLabel?.text = "Game \(games[indexPath.row].ID) @ \(games[indexPath.row].host)"
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController as! BoardViewController
        controller.networkmode = true
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
