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
            selectButton.isHidden = false
        } else {
            selectButton.isHidden = true
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
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let oSkinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
//    lazy var selectButton: UIButton = {
//        let button = UIButton()
//        switch button.state {
//        case .normal:
//            button.backgroundColor = UIColor(named: "gray")
//        case .selected:
//            button.backgroundColor = UIColor(named: "purple")
//        default: break
//        }
//        button.layer.cornerRadius = 30
//        button.setTitle("Choose", for: .normal)
//        button.setTitleColor(.black, for: .normal)
//        button.setTitle("Picked", for: .selected)
//        button.setTitleColor(.white, for: .selected)
//        return button
//    }()
    
    lazy var selectButton: UILabel = {
        let label = UILabel()
        label.text = "Choose"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private enum UIConstants {
        static let xStackSpacing: CGFloat = 4
        static let yStackSpacing: CGFloat = 18
        static let yStackViewEdgeInsets: CGFloat = 20
        
    }
        
}

private extension SkinCell {
    func setupView() {
        
        let view = ViewFactory.createShadowView()
        
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
        
        xStackView.snp.makeConstraints { make in
            make.height.equalTo(yStackView.bounds.height)
        }
    }
    
    
}



#Preview { SettingsViewController()}
