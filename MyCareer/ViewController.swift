//
//  ViewController.swift
//  MyCareer
//
//  Created by Ewen on 2021/7/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var slider: UISlider!
    
    let titleDictionary = [
        "201505": "擄・神話",
        "201512": "舉頭望明樂・低頭思⿎鄉",
        "201605": "為師的最後七堂課",
        "201607": "⽵塹國樂節【風中⽵情】",
        "201705": "明天，我要和昨天的妳⾳樂會",
        "201706": "骨・噪",
        "201809": "藝起來中正",
        "201907": "我們還在",
        "201912": "Reborn",
        "202012": "清・春・交響曲"
    ]
    
    let subTitleDictionary = [
        "201505": "清大大禮堂",
        "201512": "清大合勤演藝廳",
        "201605": "清大大禮堂",
        "201607": "新竹市文化局演藝廳",
        "201705": "交大活動中心演藝廳",
        "201706": "清大合勤演藝廳",
        "201809": "中正紀念堂大孝門廳",
        "201907": "清大合勤演藝廳",
        "201912": "清大合勤演藝廳",
        "202012": "交大活動中心演藝廳"
    ]
    
    let dateFormatter = DateFormatter()
    var timer: Timer?
    
    var yearValue = 2015
    var monthValue = 1
    var dayValue = 1
    var sliderValue = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Date Picker的locale與dateFormat
        datePicker.locale = Locale(identifier: "zh_TW")
        dateFormatter.dateFormat = "yyyy/MM/dd"
        //畫面載入先sync預設value進去
        sync()
    }
    
    // 全部同步
    func sync() {
        //monthValue為1~9月
        if monthValue <= 9 {
            //myImageView被連動
            myImageView.image = UIImage(named: "\(yearValue)0\(monthValue)")
            //titleLabel被連動
            titleLabel.text = titleDictionary["\(yearValue)0\(monthValue)"]
            //subTitleLabel被連動
            subTitleLabel.text = subTitleDictionary["\(yearValue)0\(monthValue)"]
            //datePicker被連動
            datePicker.setDate(dateFormatter.date(from: "\(yearValue)/0\(monthValue)/\(dayValue)")!, animated: true)
        } else { //10~12月
            myImageView.image = UIImage(named: "\(yearValue)\(monthValue)")
            titleLabel.text = titleDictionary["\(yearValue)\(monthValue)"]
            //subTitleLabel被連動
            subTitleLabel.text = subTitleDictionary["\(yearValue)\(monthValue)"]
            datePicker.setDate(dateFormatter.date(from: "\(yearValue)/\(monthValue)/\(dayValue)")!, animated: true)
        }
        //slider被連動
        slider.setValue(Float((yearValue - 2015) * 12 + monthValue - 1), animated: true)
    }
    
    //Date Picker被觸發，如果年月都Match，全部Value更新
    @IBAction func changeDatePicker(_ sender: UIDatePicker){
        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: sender.date)
        
        let datePickerYear = dateComponents.year!
        let datePickerMonth = dateComponents.month!
        
        yearValue = datePickerYear
        monthValue = datePickerMonth
        
        if yearValue == 2015 && monthValue == 5 {
            sliderValue = 4
            dayValue = 22  //20150522
        } else if yearValue == 2015 && monthValue == 12 {
            sliderValue = 11
            dayValue = 20  //20151220
        } else if yearValue == 2016 && monthValue == 5 {
            sliderValue = 16
            dayValue = 27  //20160527
        } else if yearValue == 2016 && monthValue == 7 {
            sliderValue = 18
            dayValue = 15  //20160715
        } else if yearValue == 2017 && monthValue == 5 {
            sliderValue = 28
            dayValue = 26  //20170526
        } else if yearValue == 2017 && monthValue == 6 {
            sliderValue = 29
            dayValue = 18  //20170618
        } else if yearValue == 2018 && monthValue == 9 {
            sliderValue = 44
            dayValue = 8   //20180908
        } else if yearValue == 2019 && monthValue == 7 {
            sliderValue = 54
            dayValue = 6   //20190706
        } else if yearValue == 2019 && monthValue == 12 {
            sliderValue = 59
            dayValue = 20  //20191220
        } else if yearValue == 2020 && monthValue == 12 {
            sliderValue = 71
            dayValue = 12  //20201212
        }
        sync()
    }
    
    //Slider被觸發，如果年月都Match，全部Value更新
    @IBAction func changeSlider(_ sender: UISlider) {
        sender.value.round()
        sliderValue = Int(sender.value)
        
        yearValue = sliderValue / 12 + 2015
        monthValue = sliderValue % 12 + 1
        
        switch sliderValue {
        case 4:
            dayValue = 22  //20150522
        case 11:
            dayValue = 20  //20151220
        case 16:
            dayValue = 27  //20160527
        case 18:
            dayValue = 15  //20160715
        case 28:
            dayValue = 26  //20170526
        case 29:
            dayValue = 18  //20170618
        case 44:
            dayValue = 8   //20180908
        case 54:
            dayValue = 6   //20190706
        case 59:
            dayValue = 20  //20191220
        case 71:
            dayValue = 12  //20201212
        default:
            dayValue = 1   //slider沒match，day一律設成1日
        }
        sync()
    }

    //Switch被觸發，把slider的value拉到「下一個音樂會時間點」對應的sliderValue
    @IBAction func autoPlay(_ sender: UISwitch) {
        if sender .isOn{
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startCarousell), userInfo: nil, repeats: true)
            } else{
            timer?.invalidate()
        }
    }
    
    @objc func startCarousell() {
        if sliderValue >= 4 && sliderValue < 11 {
            sliderValue = 11
            dayValue = 20  //20151220
        } else if sliderValue >= 11 && sliderValue < 16 {
            sliderValue = 16
            dayValue = 27  //20160527
        } else if sliderValue >= 16 && sliderValue < 18 {
            sliderValue = 18
            dayValue = 15  //20160715
        } else if sliderValue >= 18 && sliderValue < 28 {
            sliderValue = 28
            dayValue = 26  //20170526
        } else if sliderValue >= 28 && sliderValue < 29 {
            sliderValue = 29
            dayValue = 18  //20170618
        } else if sliderValue >= 29 && sliderValue < 44 {
            sliderValue = 44
            dayValue = 8   //20180908
        } else if sliderValue >= 44 && sliderValue < 54 {
            sliderValue = 54
            dayValue = 6   //20190706
        } else if sliderValue >= 54 && sliderValue < 59 {
            sliderValue = 59
            dayValue = 20  //20191220
        } else if sliderValue >= 59 && sliderValue < 71 {
            sliderValue = 71
            dayValue = 12  //20201212
        } else { //sliderValue=71 或 sliderValue < 4
            sliderValue = 4
            dayValue = 22  //20150522
        }
        yearValue = sliderValue / 12 + 2015
        monthValue = sliderValue % 12 + 1
        sync()
    }
        
    //關閉App即停止timer，以防止在背景持續執行
    override func viewDidDisappear(_ animated: Bool) {
        timer?.invalidate()
    }
}
