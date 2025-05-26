//
//  YesViewCell.swift
//  Tpeso
//
//  Created by 何康 on 2025/5/26.
//

import UIKit

class YesViewCell: BaseViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
