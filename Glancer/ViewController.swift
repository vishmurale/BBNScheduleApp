//
//  ViewController.swift
//  Glancer
//
//  Created by Vishnu Murale on 5/13/15.
//  Copyright (c) 2015 Vishnu Murale. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    
    //Since you will do this programtically the following can go.
    @IBOutlet weak var Blue: UIView!
    @IBOutlet weak var M: UISwitch!
    @IBOutlet weak var T: UISwitch!
    @IBOutlet weak var W: UISwitch!
    @IBOutlet weak var Th: UISwitch!
    @IBOutlet weak var F: UISwitch!
    
    @IBOutlet weak var Save: UIButton! //this is a save button

    @IBOutlet var Gblock: UITextField!
    @IBOutlet var Fblock: UITextField!
    @IBOutlet var Eblock: UITextField!
    @IBOutlet var Dblock: UITextField!
    @IBOutlet var Ablock: UITextField!
    @IBOutlet var Bblock: UITextField!
    @IBOutlet var Cblock: UITextField!
    //END
    
    //try and keep these and work the UI with them
    var ArrayOfField = [UITextField]()
    var ArrayOfSwitch = [UISwitch]()
    var ArrayOfBool = [Bool]()
    var ArrayOfText = [String]()
    //END
    
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var timer = NSTimer();
    
    override func viewDidLoad() {
        

        
        super.viewDidLoad()
        let defaults = NSUserDefaults(suiteName:"group.vishnu.squad.widget")
        //Change here
        
        
        //Make sure to add all the Ui element's values (string) to "ArrayOfText"
        ArrayOfText.append(Ablock.text!)
        ArrayOfText.append(Bblock.text!)
        ArrayOfText.append(Cblock.text!)
        ArrayOfText.append(Dblock.text!)
        ArrayOfText.append(Eblock.text!)
        ArrayOfText.append(Fblock.text!)
        ArrayOfText.append(Gblock.text!)
        
        //this actauly holds the UI elements, you will make these prgramtically but add the "UITextField" to "ArrayOfField"
        ArrayOfField.append(Ablock)
        ArrayOfField.append(Bblock)
        ArrayOfField.append(Cblock)
        ArrayOfField.append(Dblock)
        ArrayOfField.append(Eblock)
        ArrayOfField.append(Fblock)
        ArrayOfField.append(Gblock)
        
        //Make sure to add all the Ui element's values (bool) to "ArrayOfBool"
        ArrayOfBool.append(M.on)
        ArrayOfBool.append(T.on)
        ArrayOfBool.append(W.on)
        ArrayOfBool.append(Th.on)
        ArrayOfBool.append(F.on)
        
        //this holds the UI elemnts, the switches for first lunch, you will make these prgramtically but add "UISwitch" to "ArrayOfField"

        ArrayOfSwitch.append(M)
        ArrayOfSwitch.append(T)
        ArrayOfSwitch.append(W)
        ArrayOfSwitch.append(Th)
        ArrayOfSwitch.append(F)
        
        
        //you probabbly can get rid of this
        
        self.Gblock.delegate = self;
        self.Fblock.delegate = self;
        self.Eblock.delegate = self;
        self.Dblock.delegate = self;
        self.Ablock.delegate = self;
        self.Bblock.delegate = self;
        self.Cblock.delegate = self;
        //gettring Rid Ends
        
        //Change Ends
  
        

        if(defaults!.objectForKey("ButtonTexts") == nil){
            defaults!.setObject(ArrayOfText, forKey: "ButtonTexts")
        }
        else {
            let UserArray: [String] = defaults!.objectForKey("ButtonTexts") as! Array<String>
            
            for index in 0...UserArray.count-1{
                ArrayOfField[index].text = UserArray[index]
            }
        }
        
        if(defaults!.objectForKey("SwitchValues") == nil){
            defaults!.setObject(ArrayOfBool, forKey: "SwitchValues")
        }
        else {
            let UserSwitch: [Bool] = defaults!.objectForKey("SwitchValues") as! Array<Bool>
            
            for index in 0...UserSwitch.count-1{
                ArrayOfSwitch[index].on = UserSwitch[index]
            }
        }
        
        
        Save.addTarget(self, action: "buttonTapped", forControlEvents: .TouchUpInside)
        
      
        appDelegate.update()
        
        
        
          timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateUI", userInfo: nil, repeats: true)
    
        
        
    
        


        
        
        
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
    
    
    
    func buttonTapped(){ //this is what happens if save button is pressed!

        let defaults = NSUserDefaults(suiteName:"group.vishnu.squad.widget")

        
        ArrayOfText.removeAll()
        ArrayOfBool.removeAll()
        
        
        //CHANGE starts here
        
        //probably will have to change this. Make sure to add the values (string) to  "ArrayOfText"

        ArrayOfText.append(Ablock.text!)
        ArrayOfText.append(Bblock.text!)
        ArrayOfText.append(Cblock.text!)
        ArrayOfText.append(Dblock.text!)
        ArrayOfText.append(Eblock.text!)
        ArrayOfText.append(Fblock.text!)
        ArrayOfText.append(Gblock.text!)
        
        //probably will have to change this. Make sure to add the values (bool) to "ArrayOfBool"
        ArrayOfBool.append(M.on)
        ArrayOfBool.append(T.on)
        ArrayOfBool.append(W.on)
        ArrayOfBool.append(Th.on)
        ArrayOfBool.append(F.on)
        
        
        //Change ends here
        
        
        
        defaults!.setObject(ArrayOfText, forKey: "ButtonTexts")
        defaults!.setObject(ArrayOfBool, forKey: "SwitchValues")
        
        
        appDelegate.update()
        
        print("_____________________________________________________________________")
        print("Scheduled Notifications")

        
        let alert = UIAlertController(title: "Save", message: "Congrats your data has been Saved!", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    
    
    
}

