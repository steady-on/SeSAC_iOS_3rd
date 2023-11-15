//
//  SimpleTableViewController.swift
//  Rx_SamplePractice
//
//  Created by Roen White on 2023/11/14.
//

import UIKit
import RxSwift
import RxCocoa

final class SimpleTableViewController: BaseViewController {

    private let label: UILabel = {
        let label = UILabel()
        label.text = "셀 클릭"
        label.font = .preferredFont(forTextStyle: .body)
        return label
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return table
    }()
    
    private let items = Observable.just((1...20).map { "\($0)" })
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureHiararchy() {
        super.configureHiararchy()
        
        let components = [label, tableView]
        components.forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    override func setConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: label.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    override func bind() {
        items
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self))  { row, element, cell in
                var config = cell.defaultContentConfiguration()
                config.text = "\(element) @ row \(row)"
                cell.contentConfiguration = config
            }
            .disposed(by: disposeBag)
            
        tableView.rx.modelSelected(String.self)
            .map { "\($0) Clicked" }
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
        
        tableView.rx
            .itemAccessoryButtonTapped
            .subscribe(onNext: { indexPath in
                print("Tapped Detail @ \(indexPath.section),\(indexPath.row)")
            })
            .disposed(by: disposeBag)
    }
}
