//
//  SecondExampleViewController.swift
//  CodebaseAutolayout&UI
//
//  Created by Roen White on 2023/08/22.
//

import UIKit

class SecondExampleViewController: UIViewController {
    
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "example2-background")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    lazy var backgroundDarkFilterImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.backgroundColor = .black.withAlphaComponent(0.5)
        return imageView
    }()
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "example2-profile")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 40
        imageView.layer.masksToBounds = true
        return imageView
    }()
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Roen"
        label.font = .preferredFont(forTextStyle: .title3)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    lazy var statusMessageLabel: UILabel = {
        let label = UILabel()
        label.text = "Codebase로 UI 잡는거 너무 재밌다."
        label.font = .preferredFont(forTextStyle: .callout)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    lazy var divider: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray2
        return view
    }()
    
    lazy var bottomButtonGroup: [UIButton] = {
        var buttonGroup = [UIButton]()
        
        for type in BottomButtonType.allCases {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            
            var config = UIButton.Configuration.plain()
            
            var attributedTitle = AttributedString(type.buttonTitle)
            attributedTitle.font = .preferredFont(forTextStyle: .caption1)
            
            config.attributedTitle = attributedTitle
            config.baseForegroundColor = .white
            config.buttonSize = .small
            
            config.image = UIImage(systemName: type.systemImageName)
            config.imagePlacement = .top
            config.imagePadding = 15
            
            button.configuration = config
            buttonGroup.append(button)
        }
        
        return buttonGroup
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    lazy var profileInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setNavigationItems()
        setUIConstraints()
    }
    
    func setNavigationItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeView))
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "gift.circle"), style: .plain, target: self, action: #selector(fake)),
            UIBarButtonItem(image: UIImage(systemName: "qrcode.viewfinder"), style: .plain, target: self, action: #selector(fake)),
            UIBarButtonItem(image: UIImage(systemName: "gearshape.circle"), style: .plain, target: self, action: #selector(fake))
        ]
        
        navigationItem.leftBarButtonItem?.tintColor = .white
        navigationItem.rightBarButtonItems?.forEach { $0.tintColor = .white }
    }
    
    @objc func closeView() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func fake() {}
    
    func setUIConstraints() {
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundImageView)
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        backgroundDarkFilterImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.addSubview(backgroundDarkFilterImageView)
        NSLayoutConstraint.activate([
            backgroundDarkFilterImageView.topAnchor.constraint(equalTo: backgroundImageView.topAnchor),
            backgroundDarkFilterImageView.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor),
            backgroundDarkFilterImageView.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor),
            backgroundDarkFilterImageView.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor)
        ])
        
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonStackView)
        NSLayoutConstraint.activate([
            buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStackView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1),
            buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            buttonStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 60),
            buttonStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -60)
        ])
        
        bottomButtonGroup.forEach {
            buttonStackView.addArrangedSubview($0)
        }
        
        divider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(divider)
        NSLayoutConstraint.activate([
            divider.heightAnchor.constraint(equalToConstant: 0.2),
            divider.widthAnchor.constraint(equalTo: view.widthAnchor),
            divider.bottomAnchor.constraint(equalTo: buttonStackView.topAnchor)
        ])
        
        profileInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileInfoStackView)
        NSLayoutConstraint.activate([
            profileInfoStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileInfoStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            profileInfoStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            profileInfoStackView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.25),
            profileInfoStackView.bottomAnchor.constraint(equalTo: divider.topAnchor, constant: -20)
        ])
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        statusMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        profileInfoStackView.addArrangedSubview(profileImageView)
        profileInfoStackView.addArrangedSubview(nameLabel)
        profileInfoStackView.addArrangedSubview(statusMessageLabel)
        
        NSLayoutConstraint.activate([
            profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor, multiplier: 1),
            profileImageView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.3)
        ])
    }
}

fileprivate enum BottomButtonType: CaseIterable {
    case chatWithMe
    case editProfile
    case kakaoStory
    
    var systemImageName: String {
        switch self {
        case .chatWithMe: return "bubble.left.fill"
        case .editProfile: return "pencil"
        case .kakaoStory: return "clock.badge.fill"
        }
    }
    
    var buttonTitle: String {
        switch self {
        case .chatWithMe: return "나와의 채팅"
        case .editProfile: return "프로필 편집"
        case .kakaoStory: return "카카오스토리"
        }
    }
}
