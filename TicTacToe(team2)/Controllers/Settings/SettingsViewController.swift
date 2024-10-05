//
//  SettingsViewController.swift
//  TicTacToe(team2)
//
//  Created by Igor Guryan on 30.09.2024.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var checkedSkin: Int = 0
    let selectMusicLabel = UILabel()
    let selectedMusicButton = UIButton()
    let musicOptionsTableView = UITableView()
    var musicOptions = [ "Classical", "Instrumental", "Nature"]
    var isMusicOptionsVisible = false
    
    private lazy var topSettingsStack: UIStackView = {
        let stackView = ViewFactory.createShadowStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally // или все-таки .fillequally
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        stackView.spacing = 20
        return stackView
    }()
    
    
    private lazy var gameTimeSwitch: UISwitch = {
        let switchView = UISwitch()
        return switchView
    }()
    
    private lazy var gameMusicSwitch: UISwitch = {
        let switchView = UISwitch()
        switchView.onTintColor = UIColor(named: "blue")
        return switchView
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
    
    private var skins: [Skin] = [
        Skin(oSkin: "Oskin1", xSkin: "Xskin1"),
        Skin(oSkin: "Oskin2", xSkin: "Xskin2"),
        Skin(oSkin: "Oskin3", xSkin: "Xskin3", isChecked: true),
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
        
        //        let yStackView = UIStackView(arrangedSubviews: [gameTimeSwitch, gameTimeLabel])
        //
        //        yStackView.axis = .vertical
        //        yStackView.alignment = .center
        //        yStackView.spacing = 20
        //
        //        let topSettingsStack = createTopSettinsStack()
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(topSettingsStack)
        contentView.addSubview(skinsCollectionView)
        
        let gameTimeSwitchView = createUpperBlock(title: "Game time", view: gameTimeSwitch)
        let gameMusicView = createUpperBlock(title: "Music", view: gameMusicSwitch)
        let selectMusicView = createUpperBlock(title: "Select Music", view: musicOptionsTableView)
        
        topSettingsStack.addArrangedSubview(gameTimeSwitchView)
        topSettingsStack.addArrangedSubview(gameMusicView)
        topSettingsStack.addArrangedSubview(selectMusicView)
        
        setupMusicSelection()
        
        topSettingsStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().offset(100)
            //            make.height.equalTo()
            make.width.equalTo(view.frame.width - 40)
        }
        
        skinsCollectionView.snp.makeConstraints{ make in
            make.top.equalTo(topSettingsStack.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(contentView.snp.bottom)
        }
    }
    
    func setupMusicSelection() {
        selectMusicLabel.text = "Select Music"
        selectMusicLabel.isHidden = true
        view.addSubview(selectMusicLabel)
        
        selectedMusicButton.setTitle("Select Music", for: .normal)
        selectedMusicButton.setTitleColor(.black, for: .normal)
        selectedMusicButton.isHidden = true
        selectedMusicButton.addTarget(self, action: #selector(selectedMusicTapped), for: .touchUpInside)
        view.addSubview(selectedMusicButton)
        
        musicOptionsTableView.delegate = self
        musicOptionsTableView.dataSource = self
        musicOptionsTableView.isHidden = true
        musicOptionsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(musicOptionsTableView)
        
        gameMusicSwitch.addTarget(self, action: #selector(musicSwitchSwitched(_:)), for: .valueChanged)
        
        selectMusicLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(gameMusicSwitch.snp.bottom).offset(20)
        }
        selectedMusicButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalTo(selectMusicLabel.snp.centerY)
        }
        musicOptionsTableView.snp.makeConstraints { make in
            make.top.equalTo(selectedMusicButton.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(150)
        }
    }
    
    @objc func musicSwitchSwitched(_ sender: UISwitch) {
        let isOn = sender.isOn
        UIView.animate(withDuration: 0.3) {
            self.selectMusicLabel.isHidden = !isOn
            self.selectedMusicButton.isHidden = !isOn
            if !isOn {
                self.musicOptionsTableView.isHidden = true
            }
        }
    }
    
    @objc func selectedMusicTapped() {
        isMusicOptionsVisible.toggle()
        UIView.animate(withDuration: 0.3) {
            self.musicOptionsTableView.isHidden = !self.isMusicOptionsVisible
        }
    }
    
    
    
    func createUpperBlock(title: String, view: UIView) -> UIView {
        let blockView = UIView()
        blockView.backgroundColor = UIColor(named: "lightBlue")
        blockView.layer.cornerRadius = 25
        blockView.translatesAutoresizingMaskIntoConstraints = false
        
        //            blockView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        //blockView.isLayoutMarginsRelativeArrangement = true
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.textAlignment = .left
        titleLabel.textColor = .black
        titleLabel.text = title
        
        let contentStack: UIStackView
        
        if title == "Game time" || title == "Music" {
            guard let switchControl = view as? UISwitch else { return blockView }
            switchControl.isOn = false
            switchControl.onTintColor = UIColor(named: "Blue")
            
            contentStack = UIStackView(arrangedSubviews: [titleLabel, switchControl])
            contentStack.axis = .horizontal
            //                contentStack.spacing = 10
            contentStack.alignment = .center
            contentStack.distribution = .equalCentering
        } else {
            contentStack = UIStackView(arrangedSubviews: [titleLabel])
            contentStack.axis = .vertical
            contentStack.spacing = 10
            contentStack.alignment = .leading
            
        }
        
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        blockView.addSubview(contentStack)
        contentStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().inset(10)
        }
        return blockView
    }
    
    
    func createLayoutForCollection() -> UICollectionViewFlowLayout {
        
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

extension SettingsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        musicOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = musicOptions[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMusic = musicOptions[indexPath.row]
        selectedMusicButton.setTitle(selectedMusic, for: .normal)
        musicOptionsTableView.isHidden = true
    }
    
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
        skins[indexPath.item].isChecked.toggle()
        checkedSkin = indexPath.item
        skinsCollectionView.reloadData()
    }
}

#Preview {SettingsViewController()}
