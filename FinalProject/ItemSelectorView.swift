//
//  ItemSelectorView.swift
//  FinalProject
//
//  Created by Avila, Colton C on 3/27/18.
//  Copyright © 2018 Group 12. All rights reserved.
//

import UIKit

class ItemSelectorView: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    @IBOutlet weak var recyclePicker: UIPickerView!
    @IBOutlet weak var trashPicker: UIPickerView!
    @IBOutlet weak var streamSegment: UISegmentedControl!
    //Stream ID
    var streamType:String = "Plastic"
    
    @IBAction func streamSelector(_ sender: Any) {
        switch streamSegment.selectedSegmentIndex{
        case 0:
            streamType = "Plastic"
            picker1Options = ["Tiny : Utensils","Small : Cups","Medium: Bottles","Large: Jugs","Huge : Buckets"]
        case 1:
            streamType = "Paper"
            picker1Options = ["Tiny : 1 Sheet","Small : 5 Sheets","Medium: 10 Sheets","Large: Magazine(30 Sheets)","Huge : Newspaper(60 Sheets)"]
        case 2:
            streamType = "Cardboard"
            picker1Options = ["Tiny : Ring Box","Small : DVD Box","Medium: Cereal Box","Large: Shoe Box","Huge : Microwave Box"]
        case 3:
            streamType = "Glass"
            picker1Options = ["Tiny : Shards","Small : Jars","Medium: Soda Bottle","Large: Wine Bottle","Huge : Jugs"]
        case 4:
            streamType = "Metals"
            picker1Options = ["Tiny : Bottle Tabs","Small : Foil","Medium: Soda Cans","Large: Coffee Cans","Huge : Microwave"]
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
        picker1Options = ["Tiny : Utensils","Small : Cups","Medium: Bottles","Large: Jugs","Huge : Buckets"]
        picker2Options = ["Tiny: Wrapper","Small : Apple","Medium : NBA Shoe","Large : Basketball","Huge : Microwave"]
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
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 1){
            return (picker1Options[row])
        }else{
            return (picker2Options[row])
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
