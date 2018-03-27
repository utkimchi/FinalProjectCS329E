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
    
    
    //Recycling Array
    var picker1Options:[String] = []
    //Trash Array
    var picker2Options:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        picker1Options = ["Tiny","Small","Medium","Large","Huge"]
        picker2Options = ["Tiny","Small","Medium","Large","Huge"]
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
