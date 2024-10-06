//
//  SettingsViewController.swift
//  TicTacToe(team2)
//
//  Created by Igor Guryan on 30.09.2024.
//

import UIKit
import AVFoundation

class SettingsViewController: UIViewController {
    
    var settingsManager = SettingsManager()
    var settings: Settings?
    var pickedSkin = Skin(oSkin: "Oskin2", xSkin: "Xskin2", isChecked: true)
    var skins = Skins().skins
    var ticTac = TicTacModel()
    
    private lazy var topSettingsStack: UIStackView = {
        let stackView = ViewFactory.createShadowStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        stackView.spacing = 20
        return stackView
    }()
    
    
    private lazy var gameTimeSwitch: UISwitch = {
        let switchView = UISwitch()
        switchView.isOn = settings?.isGameTimeEnabled ?? false
        switchView.addTarget(self, action: #selector(gameTimeSwitchChanged), for: .valueChanged)
        return switchView
    }()
    
    private lazy var newTimeSwitch: UISwitch = {
        let switchView = UISwitch()
        switchView.isOn = settings?.isGameTimeEnabled ?? false
        switchView.addTarget(self, action: #selector(gameTimeSwitchChanged), for: .valueChanged)
        return switchView
    }()
    
    @objc
    private func gameTimeSwitchChanged(_ sender: UISwitch) {
        if sender.isOn {
            timeView.isHidden = false
        } else {
            timeView.isHidden = true
        }
    }
    
    private var audioPlayer: AVAudioPlayer?
    
    private lazy var gameMusicSwitch: UISwitch = {
        let switchView = UISwitch()
        switchView.isOn = settings?.isMusicEnabled ?? false
        switchView.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        return switchView
    }()
    
    private lazy var timeView: UIView = {
      let view = UIView()
        view.backgroundColor = UIColor(named: "lightBlue")
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        
        return view
    }()
    
    private lazy var buttonOne: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("30 min", for: .normal)
        button.backgroundColor = UIColor(named: "lightBlue")
        button.setBackgroundColor(UIColor(named: "blue")!, for: .highlighted)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(pressButtonOne), for: .touchUpInside)
        return button
    }()
    
    private let buttonTwo: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("60 min", for: .normal)
        button.backgroundColor = UIColor(named: "lightBlue")
        button.setBackgroundColor(UIColor(named: "blue")!, for: .highlighted)
        button.setBackgroundColor(.black, for: .highlighted)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    private let buttonThree: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("120 min", for: .normal)
        button.backgroundColor = UIColor(named: "lightBlue")
        button.setBackgroundColor(UIColor(named: "blue")!, for: .highlighted)
        button.setBackgroundColor(.black, for: .highlighted)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    let label: UILabel = {
      let label = UILabel()
        label.text = "Duration"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .black
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

    override func viewDidLoad() {
        super.viewDidLoad()
        getSettings()
        setupNavigationBar()
        setupUI()
        setupSwitches()
    }
    
   //MARK: - Setup Audio Player
   
    @objc func switchChanged(_ sender: UISwitch) {
        BackgroundMusicPlayer.shared.setMusicEnabled(sender.isOn)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        saveSettings(isGameTimeEnabled: gameTimeSwitch.isOn, gameTime: 40, skin: pickedSkin, availableSkins: settings?.availableSkins, isMusicEnabled: gameMusicSwitch.isOn)
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
            
            view.addSubview(scrollView)
            scrollView.addSubview(contentView)
            contentView.addSubview(topSettingsStack)
            contentView.addSubview(skinsCollectionView)
            
            let gameTimeSwitchView = createUpperBlock(title: "Game time", view: gameTimeSwitch)
            let gameMusicView = createUpperBlock(title: "Music", view: gameMusicSwitch)
            topSettingsStack.addArrangedSubview(gameTimeSwitchView)
            topSettingsStack.addArrangedSubview(gameMusicView)
            topSettingsStack.addArrangedSubview(timeView)
            
            timeView.addSubview(label)
            timeView.addSubview(buttonOne)
            timeView.addSubview(buttonTwo)
            timeView.addSubview(buttonThree)
            
            
            
            topSettingsStack.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(20)
                make.top.equalToSuperview().offset(100)
                
            }
            skinsCollectionView.snp.makeConstraints{ make in
                make.top.equalTo(topSettingsStack.snp.bottom).offset(10)
                make.leading.trailing.equalToSuperview()
                make.bottom.equalTo(contentView.snp.bottom)
            }
            
            timeView.snp.makeConstraints { make in
                make.height.equalTo(200)
                make.width.equalTo(50)
            }
            
            label.snp.makeConstraints { make in
                make.top.trailing.equalToSuperview()
                make.leading.equalToSuperview().inset(20)
                make.height.equalTo(40)
            }
            
            buttonOne.snp.makeConstraints { make in
                make.top.equalTo(label.snp.bottom)
                make.leading.equalToSuperview().inset(20)
                make.trailing.equalToSuperview()
                make.height.equalTo(50)
                
            }
            
            buttonTwo.snp.makeConstraints { make in
                make.top.equalTo(buttonOne.snp.bottom)
                make.leading.equalToSuperview().inset(20)
                make.trailing.equalToSuperview()
                make.height.equalTo(50)
            }
            
            buttonThree.snp.makeConstraints { make in
                make.top.equalTo(buttonTwo.snp.bottom)
                make.leading.equalToSuperview().inset(20)
                make.trailing.equalToSuperview()
                make.height.equalTo(50)
                make.bottom.equalToSuperview()
            }
            
        }
        
        func setupNavigationBar() {
            navigationItem.title = "Settings"
        }
        
        func setupSwitches() {
            gameTimeSwitch.isOn = settings?.isGameTimeEnabled ?? true
            gameMusicSwitch.isOn = settings?.isMusicEnabled ?? true
        }
        
        func saveSettings(
            isGameTimeEnabled: Bool?,
            gameTime: Int?,
            skin: Skin?,
            availableSkins: [Skin]?,
            isMusicEnabled: Bool?) {
                settingsManager.getSettings(completion: { result in
                    switch result {
                    case .success(let settings):
                        self.settings = settings
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                })
                
                settingsManager.saveSettings(
                    isGameTimeEnabled: isGameTimeEnabled ?? settings?.isGameTimeEnabled,
                    gameTime: gameTime ?? settings?.gameTime,
                    skin: skin ?? settings?.skin,
                    availableSkins: availableSkins ?? settings?.availableSkins,
                    isMusicEnabled: isMusicEnabled ?? settings?.isMusicEnabled,
                    completion: { [weak self] result in
                        switch result {
                        case .success(let settings):
                            self?.settings = settings
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                )
            }
        
        func getSettings() {
            settingsManager.getSettings(completion: { result in
                switch result {
                case .success(let settings):
                    self.settings = settings
                    print("Data was loaded")
                case .failure(let error):
                    print(error.localizedDescription)
                    print("Didnt loaddata")
                }
            })
        }

        
        func createUpperBlock(title: String, view: UIView) -> UIView {
            let blockView = UIView()
            blockView.backgroundColor = UIColor(named: "lightBlue")
            blockView.layer.cornerRadius = 25
            blockView.translatesAutoresizingMaskIntoConstraints = false

            let titleLabel = UILabel()
            titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
            titleLabel.textAlignment = .left
            titleLabel.textColor = .black
            titleLabel.text = title
            
            let contentStack: UIStackView
            
            if title == "Game time" || title == "Music" {
                guard let switchControl = view as? UISwitch else { return blockView }
                switchControl.isOn = false
                switchControl.onTintColor = UIColor(named: "blue")
                
                contentStack = UIStackView(arrangedSubviews: [titleLabel, switchControl])
                contentStack.axis = .horizontal
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


extension SettingsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        (settings?.availableSkins ?? []).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SkinCell.self), for: indexPath) as! SkinCell
        let skin = settings?.availableSkins[indexPath.item]
        cell.configure(with: skin ?? Skin(oSkin: "Oskin1", xSkin: "Xskin1", isChecked: true))
        print(skin!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for index in 0..<skins.count {
            settings?.availableSkins[index].isChecked = false
        }
        settings?.availableSkins[indexPath.item].isChecked.toggle()
        pickedSkin = settings?.availableSkins[indexPath.item] ?? skins[indexPath.item]
        skinsCollectionView.reloadData()
        print(pickedSkin)
    }
    
    private func configureButton(titleName: String) -> UIButton {
        let button = UIButton(type: .system)
        var config = UIButton.Configuration.borderless()
        config.title = titleName
        config.imagePadding = 10
        config.attributedTitle = AttributedString(
        titleName,
        attributes: AttributeContainer([.font: UIFont.systemFont(ofSize: 20, weight: .semibold),
                                        .foregroundColor: UIColor.black])
        )
        button.configuration = config
        button.backgroundColor = UIColor(named: "lightBlue")
        button.layer.cornerRadius = 30
        
        return button
    }
    
    @objc
    private func pressButtonOne() {
        ticTac.gameTime = 60
    }
    
    @objc
    private func pressButtonTwo() {
        ticTac.gameTime = 60
    }
    
    @objc
    private func pressButtonThree() {
        ticTac.gameTime = 120
    }
}

#Preview {SettingsViewController()}
