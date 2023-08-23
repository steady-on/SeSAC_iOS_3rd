//
//  ThirdExampleViewController.swift
//  CodebaseAutolayout&UI
//
//  Created by Roen White on 2023/08/22.
//

import UIKit

class ThirdExampleViewController: UIViewController {
    
    let chats = ["지금은 9°C에요", "78% 만큼 습해요", "1m/s의 바람이 불어요", "오늘도 행복한 하루 보내세요"]
    
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "example3-background")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    lazy var currentTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "8월 22일 21시 44분"
        label.textColor = .white
        label.font = UIFont(customFont: .cafe24SupermagicRegular, size: 14)
        return label
    }()
    
    lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.sizeToFit()
        return view
    }()
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        var symbolConfig = UIImage.SymbolConfiguration(scale: .large)
        imageView.image = UIImage(systemName: "location.fill", withConfiguration: symbolConfig)
        imageView.tintColor = .white
        return imageView
    }()
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.text = "서울, 신림동"
        label.font = UIFont(customFont: .cafe24SupermagicRegular, size: 20)
        label.textColor = .white
        return label
    }()
    lazy var shareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .white
        return button
    }()
    lazy var rewindButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    lazy var messageStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .equalSpacing
        stack.spacing = 16
        return stack
    }()
    
    lazy var messageViewGroup: [UIView] = {
        var viewGroup = [UIView]()
        
        for chat in chats {
            let label = UILabel()
            label.text = chat
            label.font = UIFont(customFont: .cafe24SupermagicRegular, size: 17)
            label.numberOfLines = 0
            
            viewGroup.append(label)
        }
        
        let weatherImageView = UIImageView()
        weatherImageView.image = UIImage(named: "cloud")
        weatherImageView.contentMode = .scaleAspectFit
        
        viewGroup.insert(weatherImageView, at: viewGroup.endIndex - 1)
        
        return viewGroup
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setUpConstraints()
    }
    
    
    private func setUpConstraints() {
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundImageView)
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor ),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        currentTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(currentTimeLabel)
        NSLayoutConstraint.activate([
            currentTimeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            currentTimeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            currentTimeLabel.trailingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: currentTimeLabel.bottomAnchor, constant: 20),
            headerView.leadingAnchor.constraint(equalTo: currentTimeLabel.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: currentTimeLabel.trailingAnchor)
        ])
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(iconImageView)
        NSLayoutConstraint.activate([
            iconImageView.heightAnchor.constraint(equalTo: iconImageView.widthAnchor, multiplier: 1),
            iconImageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.topAnchor.constraint(equalTo: headerView.topAnchor),
            iconImageView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
        ])
        
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(locationLabel)
        NSLayoutConstraint.activate([
            locationLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 20)
        ])
        
        rewindButton.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(rewindButton)
        NSLayoutConstraint.activate([
            rewindButton.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            rewindButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor)
        ])
        
        
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(shareButton)
        NSLayoutConstraint.activate([
            shareButton.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            shareButton.trailingAnchor.constraint(equalTo: rewindButton.leadingAnchor, constant: -20)
        ])
        
        messageStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(messageStackView)
        NSLayoutConstraint.activate([
            messageStackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            messageStackView.leadingAnchor.constraint(equalTo: currentTimeLabel.leadingAnchor),
            messageStackView.trailingAnchor.constraint(equalTo: currentTimeLabel.trailingAnchor)
        ])
        
        messageViewGroup.forEach { message in
            message.translatesAutoresizingMaskIntoConstraints = false
            let view = UIView()
            view.backgroundColor = .white
            view.layer.cornerRadius = 10
            
            view.addSubview(message)
            NSLayoutConstraint.activate([
                message.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
                message.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
                message.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
                message.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
            ])
            
            if message is UIImageView {
                NSLayoutConstraint.activate([
                    message.widthAnchor.constraint(equalToConstant: 100),
                    message.heightAnchor.constraint(equalTo: message.widthAnchor, multiplier: 1)
                ])
            }
            
            messageStackView.addArrangedSubview(view)
        }
    }
    
    func putInBubble(for subview: UIView) -> UIView {
        let bubbleView = UIView()
        
        bubbleView.backgroundColor = .white
        bubbleView.layer.cornerRadius = 15
        
        bubbleView.addSubview(subview)
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: bubbleView.layoutMarginsGuide.topAnchor),
            subview.leadingAnchor.constraint(equalTo: bubbleView.layoutMarginsGuide.leadingAnchor),
            subview.trailingAnchor.constraint(equalTo: bubbleView.layoutMarginsGuide.trailingAnchor),
            subview.bottomAnchor.constraint(equalTo: bubbleView.layoutMarginsGuide.bottomAnchor)
        ])
        
        return bubbleView
    }
}
