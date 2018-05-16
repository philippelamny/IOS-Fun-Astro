//
//  ViewController.swift
//  born-day
//
//  Created by philippe lam on 21/01/2018.
//  Copyright © 2018 philippe lam. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pickerDateBirth: UIPickerView!
    @IBOutlet weak var buttonGetDay: UIButton!
    
    @IBOutlet weak var paulbouton: UIButton!
    var yearData: [Int] = [Int]()
    var monthData: [Int] = [Int]()
    var dayData: [Int] = [Int]()
    var pickerDateBirthData: [[Int]] = [[Int]]()
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDateBirthData[component].count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerDateBirthData.count
    }
    
    internal func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(pickerDateBirthData[component][row])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerDateBirth.delegate = self
        self.pickerDateBirth.dataSource = self
        
        for index in 1955...2026 {
            yearData.insert(index, at: yearData.count)
        }
        for index in 1...12 {
            monthData.insert(index, at: monthData.count)
        }
        for index in 1...31 {
            dayData.insert(index, at: dayData.count)
        }
        
        pickerDateBirthData.insert(yearData, at: 0)
        pickerDateBirthData.insert(monthData, at: 1)
        pickerDateBirthData.insert(dayData, at: 2)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func touchDown(_ sender: Any) {
        let yearyear = self.pickerDateBirth.selectedRow(inComponent: 0)
        let monthmonth = self.pickerDateBirth.selectedRow(inComponent: 1)
        let dayday = self.pickerDateBirth.selectedRow(inComponent: 2)
        
        let alertView = UIAlertView();
        alertView.addButton(withTitle: "OK");
        alertView.title = "The day of your birth";
        alertView.message = getDayOfBirthday(_year: yearData[yearyear], _month: monthData[monthmonth], _day: dayData[dayday])
        alertView.show();
        
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! AstroCardVC
        destinationVC.month = self.pickerDateBirth.selectedRow(inComponent: 1) + 1
        destinationVC.day = self.pickerDateBirth.selectedRow(inComponent: 2) + 1
    }

    func getDayOfBirthday(_year: Int, _month: Int, _day: Int)-> String {
        
        var jourPerpetuel:[String] = [String](repeating: "", count: 37)
        var moisPerpetuel:[[Int]] = [[Int]]()
        var annePerpetuel:[[Int]] = [[Int]](repeating:[Int](repeating:0, count: 0), count:28)
        
        // Contruction Tableau d'année
        var key: Int = 0
        var indexAt: Int = 0
        for index in 1801...2036 {
            if key != 0 && (key % 28) == 0 {
                key = 0
                indexAt += 1
            }
            else if index == 1900 {
                key += 5
            }
            else if index == 1901 {
                key = 4
            }
            else if index == 2001 {
                key = 20
            }
            annePerpetuel[key].insert(index, at: indexAt)
            key += 1
        }
        moisPerpetuel = [
             [4,0,0,3,5,1,3,6,2,4,0,2]
            ,[5,1,1,4,6,2,4,0,3,5,1,3]
            ,[6,2,2,5,0,3,5,1,4,6,2,4]
            ,[0,3,4,0,2,5,0,3,6,1,4,6]
            ,[2,5,5,1,3,6,1,4,0,2,5,0]
            ,[3,6,6,2,4,0,2,5,1,3,6,1]
            ,[4,0,0,3,5,1,3,6,2,4,0,2]
            ,[5,1,2,5,0,3,5,1,4,6,2,4]
            ,[0,3,3,6,1,4,6,2,5,0,3,5]
            ,[1,4,4,0,2,5,0,3,6,1,4,6]
            ,[2,5,5,1,3,6,1,4,0,2,5,0]
            ,[3,6,0,3,5,1,3,6,2,4,0,2]
            ,[5,1,1,4,6,2,4,0,3,5,1,3]
            ,[6,2,2,5,0,3,5,1,4,6,2,4]
            ,[0,3,3,6,1,4,6,2,5,0,35]
            ,[1,4,5,1,3,6,1,4,0,2,5,0]
            ,[3,6,6,2,4,0,2,5,1,3,6,1]
            ,[4,0,0,3,5,1,3,6,2,4,0,2]
            ,[5,1,1,4,6,2,4,0,3,5,1,3]
            ,[6,2,3,6,1,4,6,2,5,0,3,5]
            ,[1,4,4,0,2,5,0,3,6,1,4,6]
            ,[2,5,5,1,3,6,1,4,0,2,5,0]
            ,[3,6,6,2,4,0,2,5,1,3,6,1]
            ,[4,0,1,4,6,2,4,0,3,5,1,3]
            ,[6,2,2,5,0,3,5,1,4,6,2,4]
            ,[0,3,3,6,1,4,6,2,5,0,3,5]
            ,[1,4,4,0,2,5,0,3,6,1,4,6]
            ,[2,5,6,2,4,0,2,5,1,3,6,1]
        ]
        
        let indexDay: [String] = [
            "Sunday"
            , "Monday"
            , "Tuesday"
            , "Wednesday"
            , "Thursday"
            , "Friday"
            , "Saturday"
        ]
    
        for index in 0...36 {
            jourPerpetuel[index] = indexDay[index % 7]
        }
        
        var line: Int = 0
        for (index, element) in annePerpetuel.enumerated() {
            if element.contains(_year) {
                line = index
                break;
            }
        }
        
        let valMonth: Int = moisPerpetuel[line][_month - 1] + _day - 1
        
        return jourPerpetuel[valMonth];
    }
    
   
   
}


