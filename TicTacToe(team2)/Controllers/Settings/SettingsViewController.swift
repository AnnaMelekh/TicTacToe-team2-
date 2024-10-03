//
//  SettingsViewController.swift
//  TicTacToe(team2)
//
//  Created by Igor Guryan on 30.09.2024.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var checkedSkin: Int = 0
    
    
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
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.frame = view.bounds
        scrollView.contentSize = contentSize
        return scrollView
    }()
    
    private var contentSize: CGSize {
        CGSize(width: view.frame.width, height: view.frame.height * 2)
    }
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        contentView.frame.size = contentSize
        return contentView
    }()
    
//    private enum UIConstants {
//        static let skinCellWidth: CGFloat = view.frame.width / 3
//        static let skinCellHeight: CGFloat = view.frame.width / 3
//    }
    
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
        skinsCollectionView.isScrollEnabled = false
        skinsCollectionView.backgroundColor = .clear
        skinsCollectionView.dataSource = self
        skinsCollectionView.delegate = self
        

        
        
        
        let yStackView = UIStackView(arrangedSubviews: [gameTimeSwitch, gameTimeLabel])
        
        yStackView.axis = .vertical
        yStackView.alignment = .center
        yStackView.spacing = 20
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(yStackView)
        contentView.addSubview(skinsCollectionView)
        
        yStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().offset(100)
        }
        skinsCollectionView.snp.makeConstraints{ make in
            make.top.equalTo(yStackView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(view.frame.height + 20)
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
        layout.sectionInset = UIEdgeInsets(top: basicSpacing, left: basicSpacing, bottom: 0, right: basicSpacing)
        layout.itemSize = CGSize(width: widthPerItem, height: widthPerItem)
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
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for index in 0..<skins.count {
            skins[index].isChecked = false
        }
        skins[indexPath.item].isChecked = true
        checkedSkin = indexPath.item
        print(checkedSkin)
        skinsCollectionView.reloadData()
    }
    }

extension SettingsViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        CGSize(width: UIConstants.skinCellWidth, height: UIConstants.skinCellHeight)
//    }
}

#Preview {SettingsViewController()}
