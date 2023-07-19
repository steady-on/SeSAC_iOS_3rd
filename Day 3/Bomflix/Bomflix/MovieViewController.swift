//
//  MovieViewController.swift
//  Bomflix
//
//  Created by Roen White on 2023/07/19.
//

import UIKit

class MovieViewController: UIViewController {

    @IBOutlet var mainContentsImage: UIImageView!
    
    @IBOutlet var firstRecommandContents: UIImageView!
    @IBOutlet var secondRecommandContents: UIImageView!
    @IBOutlet var thirdRecommandContents: UIImageView!
    
    @IBOutlet var randomPlayButton: UIButton!
    
    /// 사용자에게 화면이 보이기 직전에 실행되는 부분
    /// 모서리 둥글기, 그림자 등 스토리보드에서 설정할 수 없는 UI를 설정할 때 주로 사용
    /// View Controller 생명주기
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setRandomPosterToMainImage()
        setInitialImage()
        setInitialPlayButton()
        
        designPreviewImageView(outletName: firstRecommandContents, borderColor: UIColor.systemPink.cgColor)
        designPreviewImageView(outletName: secondRecommandContents, borderColor: UIColor.systemGreen.cgColor)
        designPreviewImageView(outletName: thirdRecommandContents, borderColor: UIColor.systemIndigo.cgColor)
    }
    
    @IBAction func setRandomContentsTapped(_ sender: UIButton) {
        setRandomPosterToMainImage()
    }
    
    @IBAction func likedButtonClicked(_ sender: UIButton) {
        // alertController 생성
        let alert = UIAlertController(title: "내가 찜한 컨텐츠",
                                      message: "아직 준비중인 기능입니다\n곧 만나요~~!",
                                      preferredStyle: .alert)
        // alert에 들어가는 버튼 생성
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let accept = UIAlertAction(title: "확인", style: .default)
        // 버튼 조립
        alert.addAction(cancel)
        alert.addAction(accept)
        // alert 호출
        present(alert, animated: true)
    }
    
    func randomMovies() -> String {
        let movies = ["극한직업", "도둑들", "명량", "베테랑", "부산행", "신과함께인과연", "신과함께죄와벌", "아바타", "알라딘", "암살", "어벤져스엔드게임", "왕의남자", "태극기휘날리며", "택시운전사", "해운대"]
        let randomMovie = movies.randomElement()!
        return randomMovie
    }
    
    func setRandomPosterToMainImage() {
        let randomNumber = Int.random(in: 1...5)
        mainContentsImage.image = UIImage(named: "\(randomNumber)")
    }
    
    func setInitialImage() {
//        firstRecommandContents.setBackgroundImage(UIImage(named: "극한직업"), for: .normal)
//        firstRecommandContents.contentMode = .scaleAspectFill
        
        secondRecommandContents.image = UIImage(named: "암살")
        secondRecommandContents.layer.cornerRadius = 60
        secondRecommandContents.layer.borderWidth = 2
        secondRecommandContents.layer.borderColor = UIColor.gray.cgColor
        
        secondRecommandContents.backgroundColor = .blue
        secondRecommandContents.contentMode = .scaleAspectFill
    }
    
    func setInitialPlayButton() {
        //        randomPlayButton.setTitle("재생", for: .normal)
        //        randomPlayButton.setTitle("눌러주세요", for: .highlighted)
                
                let normalPlayButtonImage = UIImage(named: "play_normal")
                let highlightedPlayButtonImage = UIImage(named: "play_highlighted")
                
                randomPlayButton.setImage(normalPlayButtonImage, for: .normal)
                randomPlayButton.setImage(highlightedPlayButtonImage, for: .highlighted)
                
        //        randomPlayButton.setTitleColor(.black, for: .normal)
        //        randomPlayButton.setTitleColor(.red, for: .highlighted)
                
                randomPlayButton.layer.cornerRadius = 10
                randomPlayButton.layer.borderColor = UIColor.red.cgColor
                randomPlayButton.layer.borderWidth = 4
    }
    
    func designPreviewImageView(outletName name: UIImageView, borderColor: CGColor) {
        name.layer.cornerRadius = 30
        name.layer.borderColor = borderColor
        name.layer.borderWidth = 5
        name.backgroundColor = .blue
        name.contentMode = .scaleAspectFill
        
        name.image = UIImage(named: randomMovies())
    }
}
