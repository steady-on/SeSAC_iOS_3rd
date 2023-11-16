//
//  LaboratoryViewController.swift
//  Rx_SamplePractice
//
//  Created by Roen White on 2023/11/16.
//

import UIKit
import RxSwift
import RxCocoa

class LaboratoryViewController: BaseViewController {
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = .preferredFont(forTextStyle: .body)
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.borderedProminent()
        config.title = "값 변경!"
        button.configuration = config
        return button
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "값 입력"
        return label
    }()
    
    private let disposeBag = DisposeBag()
    private let inputValue = BehaviorSubject(value: "")
    // MARK: Observable은 한번 구독을 시작한 대상? 값을 바꿀 수 없음
    // Observable.just("")
    /// 애초에 이런 용도로 쓰는게 아님
    /// textField.rx.text, button.rx.tap -> 요런 애들!
    /// UI에서 오는 이벤트들은 이벤트 자체를 다른걸로 바꿀 필요도 없고 그냥 그 자체로 Sequence 값이 추가로 들어오는가만 관찰하면 됨
    /// 그래서 한번만 이벤트를 전달하고 더이상 안할거면 구독을 끊어줘야함
    /// 예를 들어 네트워킹으로 값을 받아온다하면 Observable.create로 만들어주고, 응답이 오면 처리 후 dispose 해줘야 함
    /// 안그러면 stream이 계속 됨
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func configureHiararchy() {
        super.configureHiararchy()
        
        let components = [textField, button, label]
        components.forEach { component in
            view.addSubview(component)
            component.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    override func setConstraints() {
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            textField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 50),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 50),
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
    
    override func bind() {
//        textField.rx.text.orEmpty // orEmpty는 text의 옵셔널 언래핑
//        // MARK: component에 직접 값전달
//            .bind(to: label.rx.text)
////            .bind(with: self) { owner, input in
////                owner.label.text = input
////            }
//            .disposed(by: disposeBag)
        
        textField.rx.text.orEmpty
        // ControlProperty: 이것 자체가 Observable이 아니고, ControlProperty 안에 values 프로퍼티로 Observable이 들어 있음
            .bind(with: self) { owner, input in
                owner.inputValue.onNext(input)
            }
            .disposed(by: disposeBag)
        
        inputValue
            .subscribe(with: self) { owner, value in
                owner.label.text = value
            }
            .disposed(by: disposeBag)
    }
}
