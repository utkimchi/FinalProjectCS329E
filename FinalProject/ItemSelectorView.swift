//
//  ItemSelectorView.swift
//  FinalProject
//
//  Created by Avila, Colton C on 3/27/18.
//  Copyright © 2018 Group 12. All rights reserved.
//

import UIKit
import CoreData

class ItemSelectorView: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    @IBOutlet weak var recyclePicker: UIPickerView!
    @IBOutlet weak var trashPicker: UIPickerView!
    @IBOutlet weak var streamSegment: UISegmentedControl!
    //Stream ID
    var streamType:String = "Plastic"
    
    //Sets info
    var ownerInfo: Recycler?
    
    //Segmented controller
    @IBAction func streamSelector(_ sender: Any) {
        switch streamSegment.selectedSegmentIndex{
        case 0:
            streamType = "Plastic"
            picker1Options = ["Nothing","Tiny : Utensils","Small : Cups","Medium: Bottles","Large: Jugs","Huge : Buckets"]
        case 1:
            streamType = "Paper"
            picker1Options = ["Nothing","Tiny : 1 Sheet","Small : 5 Sheets","Medium: 10 Sheets","Large: Magazine(30 Sheets)","Huge : Newspaper(60 Sheets)"]
        case 2:
            streamType = "Cardboard"
            picker1Options = ["Nothing","Tiny : Ring Box","Small : DVD Box","Medium: Cereal Box","Large: Shoe Box","Huge : Microwave Box"]
        case 3:
            streamType = "Glass"
            picker1Options = ["Nothing","Tiny : Shards","Small : Jars","Medium: Soda Bottle","Large: Wine Bottle","Huge : Jugs"]
        case 4:
            streamType = "Metals"
            picker1Options = ["Nothing","Tiny : Bottle Tabs","Small : Foil","Medium: Soda Cans","Large: Coffee Cans","Huge : Microwave"]
        default:
            break
        }
    }
    
    //Recycling Array
    var picker1Options:[String] = []
    //Trash Array
    var picker2Options:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initial Picker
        picker1Options = ["Nothing", "Tiny : Utensils","Small : Cups","Medium: Bottles","Large: Jugs","Huge : Buckets"]
        picker2Options = ["Nothing","Tiny: Wrapper","Small : Apple","Medium : NBA Shoe","Large : Basketball","Huge : Microwave"]
        // Do any additional setup after loading the view.
        
        recyclePicker.delegate = self
        trashPicker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1{
            return picker1Options.count
        }
        else{
            return picker2Options.count
        }
    }
    
    //for add
    var recycleIndex: Int = 0
    var trashIndex: Int = 0
    
    //Title of Picker Row
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 1){
            recycleIndex = row
            return (picker1Options[row])
        }else{
            trashIndex = row
            return (picker2Options[row])
        }
    }
    
    //Check to see what saved
    @IBOutlet weak var checkDataLabel: UILabel!
    
    @IBAction func addDataButton(_ sender: UIButton) {
        self.saveRecyler(recycleIndex: recycleIndex, trashIndex: trashIndex)
        checkDataLabel.text = "Hey you Saved!"
    }
    
    func saveRecyler(recycleIndex:Int,trashIndex:Int) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        var newVolume:Int = 0
        
        //Milliliters
        switch recycleIndex {
        case 0:
            newVolume = 125
        case 1:
            newVolume = 200
        case 2:
            newVolume = 330
        case 3:
            newVolume = 750
        case 4:
            newVolume = 1200
        default:
            break
        }
        
        
        // Set the attribute values
        switch streamType {
        case "Plastic":
            print(ownerInfo?.value(forKey: "plasticTotal") as! String)
            var totalPlastic:Int = ownerInfo?.value(forKey: "plasticTotal") as! Int
            totalPlastic = totalPlastic + newVolume
            ownerInfo?.setValue(recycleIndex, forKey: "plasticTotal")
        default:
            break
        }
        
        // Commit the changes.
        do {
            try managedContext.save()
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
