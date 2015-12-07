//
//  HomeTableViewController.swift
//  Glancer
//
//  Created by Cassandra Kane on 11/29/15.
//  Copyright (c) 2015 Vishnu Murale. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var timer = NSTimer();
    
    @IBOutlet weak var mainDayLabel: UILabel!
    @IBOutlet weak var mainBlockLabel: UILabel!
    @IBOutlet weak var mainTimeLabel: UILabel!
    @IBOutlet weak var mainNextBlockLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        let currentDateTime = appDelegate.Days[0].getDate_AsString()
        let Day_Num = appDelegate.Days[0].getDayOfWeek_fromString(currentDateTime)
        return appDelegate.Days[Day_Num].ordered_times.count
        
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! BlockTableViewCell
        
        let row = indexPath.row
        
        /*
        cell.blockLetter.text =
        cell.className.text =
        cell.classTimes.text =
        */
        
        return cell
    }
    
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    
    func find_Minutes(hour_before : Int, hour_after : Int)->Int{
        
        var HOUR_AFTER_MINUS_FIVE = hour_after
        
        if(hour_after%100 < 5){
            
            HOUR_AFTER_MINUS_FIVE = hour_after - 5 - 40
            
        }
        else{
            HOUR_AFTER_MINUS_FIVE = hour_after - 5
        }
        
        
        
        let num_hours_less = Int(hour_before/100)
        let num_hours_more = Int(HOUR_AFTER_MINUS_FIVE/100)
        
        let diff_hours = num_hours_more-num_hours_less
        
        print("Diff in hours" + String(diff_hours))
        
        let diff_minutes = HOUR_AFTER_MINUS_FIVE%100 - hour_before%100
        
        print("Diff in minutes" + String(diff_minutes))
        
        
        return diff_hours*60 + diff_minutes;
        
        
    }
    
    
    
    func CurrentDayandStuff() -> (current_block : String, minutesRemaining : Int){
        
        
        
        let currentDateTime = appDelegate.Days[0].getDate_AsString()
        let Day_Num = appDelegate.Days[0].getDayOfWeek_fromString(currentDateTime)
        var Widget_Block = appDelegate.Widget_Block;
        var Time_Block = appDelegate.Time_Block;
        var End_Times = appDelegate.End_Times;
        var Curr_block = " ";
        
        var minutes_until_nextblock = 0;
        
        for i in Array((0...Widget_Block[Day_Num].count-1).reverse()){
            
            
            
            let dateAfter = Time_Block[Day_Num][i]
            let CurrTime = appDelegate.Days[0].NSDateToStringWidget(NSDate())
            
            //      CurrTime = "-09-33";
            
            var End_Time_String = ""
            if(i+1 <= Widget_Block[Day_Num].count-1){
                End_Time_String = Time_Block[Day_Num][i+1]
            }
            
            print("Date After : " + dateAfter)
            print("Current Date : " + CurrTime)
            
            var hour4 = self.substring(dateAfter,StartIndex: 1,EndIndex: 3)
            hour4 = hour4 + self.substring(dateAfter,StartIndex: 4,EndIndex: 6)
            
            var hour2 = self.substring(CurrTime,StartIndex: 1,EndIndex: 3)
            hour2 = hour2 + self.substring(CurrTime,StartIndex: 4,EndIndex: 6)
            
            var end_time = self.substring(End_Time_String,StartIndex: 1,EndIndex: 3)
            end_time = end_time + self.substring(End_Time_String,StartIndex: 4,EndIndex: 6)
            
            
            let hour_one = Int(hour4)
            let hour_two = Int(hour2)
            let hour_after = Int(end_time)
            
            
            print("Blcok  Date  hour : ")
            print(hour_one, terminator: "")
            print("Current Date hour: ")
            print(hour_two, terminator: "")
            print("After Date  hour : ")
            print(hour_after)
            
            
            
            if(i == Widget_Block[Day_Num].count-1 && hour_two >= hour_one){
                
                let EndTime = End_Times[Day_Num]
                if(hour_two! - EndTime < 0){
                    
                    
                    minutes_until_nextblock = self.find_Minutes(hour_two!, hour_after: (EndTime))
                    
                    print("Miuntes until next blok " + String(minutes_until_nextblock))
                    if(minutes_until_nextblock > 0){
                        Curr_block = Widget_Block[Day_Num][i]
                    }
                    else{
                        Curr_block = "GETTOCLASS"
                    }
                }
                else{
                    print("After School")
                    Curr_block = "NOCLASSNOW"
                }
                
                break;
                
            }
            
            
            if(hour_two >= hour_one){
                
                
                minutes_until_nextblock = self.find_Minutes(hour_two!, hour_after: (hour_after!))
                
                print("Miuntes unitl next block " + String(minutes_until_nextblock))
                
                if(minutes_until_nextblock > 0){
                    
                    Curr_block = Widget_Block[Day_Num][i]
                }
                else{
                    Curr_block = "GETTOCLASS"
                }
                
                break;
            }
            
        }
        
        return (Curr_block,minutes_until_nextblock);
        
        
        
        
    }
    

    
    
    
    func updateUI(){
        
        
        if(appDelegate.Days.count > 0){
            
            let currentDateTime = appDelegate.Days[0].getDate_AsString()
            let Day_Num = appDelegate.Days[0].getDayOfWeek_fromString(currentDateTime)
            
            if(Day_Num < 5){ //this checks that the current day is a weekday
                
                
                //get's current day's time and block and minutes left
                
                
                
                
                let CurrentValues = CurrentDayandStuff();
                
                var CurrentBlock = CurrentValues.current_block;
                var minutesRemaining = CurrentValues.minutesRemaining;
                let user_data_for_block = appDelegate.Days[Day_Num].messages_forBlock[CurrentBlock];
                
                print("Current Block " + user_data_for_block! + "  minutes remaining " + String(minutesRemaining)); //if you run this in the simulator you can see the output
                
                
                
                
                
                
                
                ///get data for all the blocks of the day
                
                
                print("current day");
                print(Day_Num);
                print(appDelegate.Days[Day_Num].name); //this is the name of the day
                
                var length = appDelegate.Days[Day_Num].ordered_times.count; //number of blocks in day (might be useful when positioning ui)
                
                
                for (index,time) in appDelegate.Days[Day_Num].ordered_times.enumerate(){
                    
                    
                    let block_name = appDelegate.Days[Day_Num].ordered_blocks[index]; //this is the block name
                    let user_data_for_block = appDelegate.Days[Day_Num].messages_forBlock[block_name]; // this is the user info for that block
                    
                    
                    //time is in the form of string, in military time, so the following converts it to a regular looking time
                    
                    let hours = substring(time,StartIndex: 1,EndIndex: 3)
                    var hours_num:Int! = Int(hours);
                    if(hours_num > 12){
                        hours_num = hours_num! - 12;
                    }
                    let regular_hours:String! = String(hours_num);
                    let minutes = substring(time,StartIndex: 4,EndIndex: 6)
                    let final_time = regular_hours + ":" + minutes
                    
                    //converting is ended "final_time" is the correct time
                    
                    print(final_time + " : " + block_name + " => " + user_data_for_block!); //if you run this in the simulator you can see the output
                    
                    
                    
                    
                }
                
            }else{
                
                print("WEEKEND BABY");
                //this means the day is a weekend so we won't display a UI schedule
                
                
            }
            
            timer.invalidate()
            
            
            
        }
        
        
        
    }
    
    func substring(origin :String, StartIndex : Int, EndIndex : Int)->String{
        var counter = 0
        var subString = ""
        for char in origin.characters{
            
            if(StartIndex <= counter && counter < EndIndex){
                subString += String(char)
            }
            
            counter++;
            
        }
        
        return subString
        
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}
