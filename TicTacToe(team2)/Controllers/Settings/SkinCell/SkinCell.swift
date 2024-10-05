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
        if skin.isChecked {
            selectLabel.backgroundColor = UIColor(named: "blue")
            selectLabel.textColor = .white
            selectLabel.text = "Picked"
        } else {
            selectLabel.backgroundColor = UIColor(named: "lightBlue")
            selectLabel.textColor = .black
            selectLabel.text = "Choose"
        }
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
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let oSkinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    lazy var selectLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose"
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = true
        label.backgroundColor = UIColor(named: "gray")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private enum UIConstants {
        static let xStackSpacing: CGFloat = 4
        static let yStackSpacing: CGFloat = 18
        static let yStackViewEdgeInsets: CGFloat = 20
        static let skinToLabelSpacing: CGFloat = 20
        static let labelHeight: CGFloat = 40
        
    }
        
}

private extension SkinCell {
    func setupView() {
        
        let view = ViewFactory.createShadowView()
        
        let xStackView = UIStackView(arrangedSubviews: [xSkinImageView, oSkinImageView])
        xStackView.axis = .horizontal
        xStackView.spacing = UIConstants.xStackSpacing
        xStackView.distribution = .fillEqually
        
        
        let yStackView = UIStackView(arrangedSubviews: [xStackView, selectLabel])
        yStackView.axis = .vertical
        yStackView.spacing = UIConstants.yStackSpacing
        yStackView.distribution = .fill
        
        yStackView.distribution = .fill
        contentView.addSubview(view)
        view.addSubview(yStackView)
        
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        yStackView.snp.makeConstraints { make in
            make.edges.equalTo(view).inset(UIConstants.yStackViewEdgeInsets)
        }
        
        selectLabel.snp.makeConstraints { make in
            make.height.equalTo(UIConstants.labelHeight)
        }
        
    }
    
    
}



#Preview{ SettingsViewController()}
