//
//  SkinCell.swift
//  TicTacToe(team2)
//
//  Created by Igor Guryan on 02.10.2024.
//

import UIKit
import SnapKit

class SkinCell: UICollectionViewCell {
    
    func configure(with skin: Skin) {
        xSkinImageView.image = UIImage(named: skin.xSkin)
        oSkinImageView.image = UIImage(named: skin.oSkin)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let xSkinImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let oSkinImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let selectButton: UIButton = {
        let button = UIButton()
        button.setTitle("Choose", for: .normal)
        button.setTitle("Picked", for: .selected)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private enum UIConstants {
        static let xStackSpacing: CGFloat = 4
        static let yStackSpacing: CGFloat = 18
        static let yStackViewEdgeInsets: CGFloat = 20
        
    }
    
}

private extension SkinCell {
    func setupView() {
        
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        let xStackView = UIStackView(arrangedSubviews: [xSkinImageView, oSkinImageView])
        xStackView.axis = .horizontal
        xStackView.spacing = UIConstants.xStackSpacing
        xStackView.distribution = .fillEqually
        let yStackView = UIStackView(arrangedSubviews: [xStackView, selectButton])
        yStackView.axis = .vertical
        yStackView.spacing = UIConstants.yStackSpacing
        yStackView.distribution = .fillEqually
        contentView.addSubview(view)
        view.addSubview(yStackView)
        
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        yStackView.snp.makeConstraints { make in
            make.edges.equalTo(view).inset(UIConstants.yStackViewEdgeInsets)
        }
    }
}

#Preview { SettingsViewController()}
