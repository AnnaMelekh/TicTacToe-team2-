//
//  SettingsViewController.swift
//  TicTacToe(team2)
//
//  Created by Igor Guryan on 30.09.2024.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private lazy var gameTimeSwitch: UISwitch = {
        let switchView = UISwitch()
        switchView.isOn = true
        return switchView
    }()
    
    private lazy var gameTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "2:00"
        return label
    }()
    
    private var skinsCollectionView: UICollectionView!
    
    private enum UIConstants {
        static let skinCellWidth: CGFloat = 150
        static let skinCellHeight: CGFloat = 150
    }
    
    private var skins: [Skin] = [
        Skin(oSkin: "Oskin1", xSkin: "Xskin1"),
        Skin(oSkin: "Oskin2", xSkin: "Xskin2"),
        Skin(oSkin: "Oskin3", xSkin: "Xskin3"),
        Skin(oSkin: "Oskin1", xSkin: "Xskin1"),
        Skin(oSkin: "Oskin2", xSkin: "Xskin2"),
        Skin(oSkin: "Oskin3", xSkin: "Xskin3"),
        Skin(oSkin: "Oskin1", xSkin: "Xskin1"),
        Skin(oSkin: "Oskin2", xSkin: "Xskin2"),
        Skin(oSkin: "Oskin3", xSkin: "Xskin3")
    ]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        skinsCollectionView.reloadData()

    }

}


private extension SettingsViewController {
    func setupUI() {
        view.backgroundColor = UIColor(named: "background")
        
        skinsCollectionView =  UICollectionView(frame: .zero, collectionViewLayout: createLayoutForCollection())
        skinsCollectionView.register(SkinCell.self, forCellWithReuseIdentifier: String(describing: SkinCell.self))
        skinsCollectionView.backgroundColor = .clear
        skinsCollectionView.dataSource = self
        skinsCollectionView.delegate = self
        
        view.addSubview(skinsCollectionView)
        
        
//        let yStackView = UIStackView(arrangedSubviews: [gameTimeSwitch, gameTimeLabel])
//        
//        yStackView.axis = .vertical
//        yStackView.alignment = .center
//        yStackView.spacing = 20
//        view.addSubview(yStackView)
//        view.addSubview(skinsCollectionView)
//        
//        yStackView.snp.makeConstraints { make in
//            make.leading.trailing.equalToSuperview().inset(20)
//            make.top.equalTo(view.snp.top)
//            make.height.equalTo(100)
//        }
        skinsCollectionView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(232)
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
                make.bottom.equalToSuperview().offset(-96)
            
        }
    }
    
    private func createLayoutForCollection() -> UICollectionViewFlowLayout {

        let layout = UICollectionViewFlowLayout()
        let basicSpacing: CGFloat = 20
        let itemsPerRow: CGFloat = 2
        let paddingWidth = basicSpacing * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        layout.minimumLineSpacing = basicSpacing
        layout.minimumInteritemSpacing = basicSpacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: basicSpacing, bottom: 0, right: basicSpacing)
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIConstants.skinCellWidth, height: UIConstants.skinCellHeight)
        return layout
    }
}

extension SettingsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        skins.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SkinCell.self), for: indexPath) as! SkinCell
        let skin = skins[indexPath.item]
        cell.configure(with: skin)
        return cell
    }
}

extension SettingsViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        CGSize(width: UIConstants.skinCellWidth, height: UIConstants.skinCellHeight)
//    }
}

#Preview {SettingsViewController()}
