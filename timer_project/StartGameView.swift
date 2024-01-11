//
//  StartGameView.swift
//  timer_project
//
//  Created by Joel Martin on 12/8/23.
//

import UIKit

class StartGameView: UIViewController {

    @IBOutlet weak var timePicker: UIPickerView!
    
    let hours = Array(0...24)
    let minutesOrSeconds = Array(0...59)
    var chosenTime: Int = 30
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PlayGameView {
            destination.hours = Int(timePicker.selectedRow(inComponent: 0))
            destination.minutes = Int(timePicker.selectedRow(inComponent: 1))
            destination.seconds = Int(timePicker.selectedRow(inComponent: 2))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timePicker.dataSource = self
        timePicker.delegate = self
    }
    

}

extension StartGameView: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return hours.count
        case 1:
            return minutesOrSeconds.count
        case 2:
            return minutesOrSeconds.count
        default:
            return 0
        }
    }
}

extension StartGameView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return String(hours[row])
        case 1:
            return String(minutesOrSeconds[row])
        case 2:
            return String(minutesOrSeconds[row])
        default:
            return "0"
        }
    }
}
