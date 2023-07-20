//
//  DateViewController.swift
//  NewlyCoinedWord
//
//  Created by Roen White on 2023/07/20.
//

import UIKit

class DateViewController: UIViewController {
    @IBOutlet weak var inputSheetStack: UIStackView!
    @IBOutlet weak var switchOfAdd: UISwitch!
    @IBOutlet weak var cautionMessage: UILabel!
    @IBOutlet weak var dDayTitle: UITextField!
    @IBOutlet weak var pickedDate: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var dDayLists: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputSheetStack.isHidden = true
        
        cautionMessage.isHidden = true
        cautionMessage.text = "⚠️제목을 입력해주세요."
        
        dDayTitle.placeholder = "제목을 입력해주세요"
        pickedDate.text = "선택한 날짜"
        pickedDate.textAlignment = .center
        
        dDayLists.alignment = .center
        
        designDatePicker()
    }
    
    @IBAction func toggleAddDDaySheet(_ sender: UISwitch) {
        inputSheetStack.isHidden.toggle()
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        
//        // +100일뒤
//        guard let after100days = Calendar.current.date(byAdding: .day, value: 100, to: sender.date) else { return }
        
        /// DateFormatter: 1. 시간대 변경 2. 날짜 포멧 변경
        let format = DateFormatter()
        format.dateFormat = "yyyy년 MM월 dd일"
        let value = format.string(from: sender.date)
        
        pickedDate.text = value
    }
    
    @IBAction func addDDayTapped(_ sender: UIButton) {
        guard let title = dDayTitle.text else {
            cautionMessage.isHidden = false
            return
        }
        
        cautionMessage.isHidden = true
        
        let newDDay = DDay(title: title, baseDate: datePicker.date)
        
        
        dDayTitle.text = nil
        datePicker.date = Date()
        
        addNewDDayLabelToView(for: newDDay)
        
        toggleAddDDaySheet(switchOfAdd)
        switchOfAdd.isOn = false
    }
    
    func addNewDDayLabelToView(for new: DDay) {
        let startDate = Date()
        let endDate = new.baseDate

        let calendar2 = Calendar.current
        let someDays = calendar2.dateComponents([.day], from: startDate, to: endDate).day!
        
        let string = "\"\(new.title)\"까지 \(someDays)일 남았습니다."
        
        let randomImageNumber = Int.random(in: 1...5)
        let image = UIImage(named: "\(randomImageNumber)")!
        
//        let imageView = UIImageView(frame: .zero)
//        imageView.image = image
        
        let newDdayLabel = UILabel()
        newDdayLabel.text = string

//        let newStack = UIStackView()
//        newStack.axis = .horizontal
        
//        newStack.addArrangedSubview(imageView)
//        newStack.addArrangedSubview(newDdayLabel)
        
        dDayLists.addArrangedSubview(newDdayLabel)
    }
    
    func designDatePicker() {
        datePicker.tintColor = .systemIndigo
        
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .inline
        } else {
            datePicker.preferredDatePickerStyle = .wheels
        }
    }
    
    //    func testViewProperty() {
    //        background100ImageView.layer.cornerRadius = 20
    //        background100ImageView.backgroundColor = .gray
    //
    //        background100ImageView.layer.shadowColor = UIColor.black.cgColor
    //        background100ImageView.layer.shadowOffset = .zero
    //        background100ImageView.layer.shadowRadius = 10
    //        background100ImageView.layer.shadowOpacity = 0.5
    //        background100ImageView.clipsToBounds = false
    //
    //        date100Label.clipsToBounds = true
    //        date100Label.layer.cornerRadius = 20
    //        date100Label.textAlignment = .center
    //        date100Label.backgroundColor = .gray
    //    }
}

struct DDay {
    let title: String
    let baseDate: Date
}
