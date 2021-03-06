//
//  DateTimeViewController.swift
//  MinimalTodo
//
//  Created by Phuc Nguyen on 02/01/2019.
//  Copyright © 2019 Phuc Nguyen. All rights reserved.
//

import UIKit
class DateTimeViewController: UIViewController {
    @IBOutlet weak var txtFieldTime: UITextField!
    var datePicker: UIDatePicker?
    @IBOutlet weak var txtFieldDate: UITextField!
    var timePicker: UIDatePicker?
    var date:String = ""
    var time:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker = UIDatePicker()
        timePicker = UIDatePicker()
        
        datePicker?.datePickerMode = .date
        timePicker?.datePickerMode = .time
        
        //Toolbar
        let toolbarDatePicker = UIToolbar()
        toolbarDatePicker.sizeToFit()
        let toolbarTimePicker = UIToolbar()
        toolbarTimePicker.sizeToFit()

        let donedateButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker))
        let donetimeButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donetimePicker))
        let spaceButton = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButtonDate = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
        let cancelButtonTime = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
        
        toolbarDatePicker.setItems([donedateButton,spaceButton,cancelButtonDate], animated: true)
        toolbarTimePicker.setItems([donetimeButton,spaceButton,cancelButtonTime], animated: true)
        
//        datePicker?.addTarget(self, action: #selector(DateTimeViewController.dateChanged(datePicker:)), for: .valueChanged)
//
//        timePicker?.addTarget(self, action: #selector(DateTimeViewController.timeChanged(timePicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(DateTimeViewController.viewTapped(gestureRecogniser:)))

        view.addGestureRecognizer(tapGesture)
        
        txtFieldDate.inputAccessoryView = toolbarDatePicker
        txtFieldDate.inputView = datePicker
        
        txtFieldTime.inputAccessoryView = toolbarTimePicker
        txtFieldTime.inputView = timePicker
    }
    @objc func viewTapped(gestureRecogniser: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        view.endEditing(true)
    }
    
    @objc func donetimePicker(){
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        txtFieldTime.text = timeFormatter.string(from: timePicker!.date)
        time = timeFormatter.string(from: timePicker!.date)
        sendDateAndTimeToParent(date:date,time:time)
        view.endEditing(true)
    }
    
    @objc func donedatePicker(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        txtFieldDate.text = dateFormatter.string(from: datePicker!.date)
        date = dateFormatter.string(from: datePicker!.date)
        sendDateAndTimeToParent(date:date,time:time)
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        txtFieldDate.text = dateFormatter.string(from: datePicker.date)
        date = dateFormatter.string(from: datePicker.date)
        sendDateAndTimeToParent(date:date,time:time)
        view.endEditing(true)
    }
    
    @objc func timeChanged(timePicker: UIDatePicker){
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        txtFieldTime.text = timeFormatter.string(from: timePicker.date)
        time = timeFormatter.string(from: timePicker.date)
        sendDateAndTimeToParent(date:date,time:time)
        view.endEditing(true)
    }
//    send date to addTodoViewControl
    func sendDateAndTimeToParent(date:String,time:String){
        let vc = parent as! AddTodoViewController
        vc.dateAndTimeFromContainer(date: date, time: time)
    }
    
    func dateAndTimeFromParent(date:String,time:String){
        self.date = date
        self.time = time
        do {
            try setPickers(date: date, time: time)
            print("good string date")
        } catch {
            print(error)
        }
        
        print("done")
    }
    
    func setPickers(date:String,time:String){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        let stringDate:String=date+" "+time
        print(stringDate)
        let dateComplete = dateFormatter.date(from: stringDate)!
        datePicker?.date = dateComplete
        timePicker?.date = dateComplete
        txtFieldDate.text=date
        txtFieldTime.text=time
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
