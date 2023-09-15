//
//  BWTableView.swift
//  Bookworm
//
//  Created by Roen White on 2023/09/06.
//

import UIKit

class BWTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        configureTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureTableView() {
        backgroundColor = .systemGroupedBackground
        separatorStyle = .none
        rowHeight = 144
        register(BWTableViewCell.self, forCellReuseIdentifier: BWTableViewCell.identifier)
    }
}
