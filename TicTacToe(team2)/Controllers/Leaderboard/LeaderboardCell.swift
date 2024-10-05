//
//  LeaderboardCell.swift
//  TicTacToe(team2)
//
//  Created by Даниил Павленко on 02.10.2024.
//

import SnapKit
import UIKit

class LeaderboardCell: UITableViewCell {
    
    //MARK: - Properties
    static let identifier = "LeaderboardCell"
    
    lazy var purpleCircleView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "lightBlue")
        view.layer.cornerRadius = 69 / 2
        
        return view
    }()
    
    lazy var purpleCapsule: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "lightBlue")
        view.layer.cornerRadius = 30
        
        return view
    }()
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .left
        label.text = "1"
        label.font = .systemFont(ofSize: 18, weight: .light)
        
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .light)
        
        return label
    }()
    
    //MARK: - Initialize
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public methods
    //функция для изменения фона цвета у первой ячейки
    public func configureFirstCell() {
        purpleCapsule.backgroundColor = UIColor(named: "purple")
        purpleCircleView.backgroundColor = UIColor(named: "purple")
    }
    
    //функция для заполнения данными из контроллера
    public func configure(with number: String, and time: String) {
        self.numberLabel.text = number
        self.timeLabel.text = time
    }
    
    //MARK: - Private methods
    private func setupUI() {
        self.contentView.addSubview(purpleCircleView)
        self.contentView.addSubview(purpleCapsule)
        self.contentView.addSubview(numberLabel)
        self.contentView.addSubview(timeLabel)
        
        purpleCircleView.translatesAutoresizingMaskIntoConstraints = false
        purpleCapsule.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        purpleCircleView.snp.makeConstraints { make in
            make.top.equalTo(contentView.layoutMarginsGuide.snp.top)
            make.bottom.equalTo(contentView.layoutMarginsGuide.snp.bottom)
            make.leading.equalTo(contentView.layoutMarginsGuide.snp.leading)
            make.height.equalTo(69)
            make.width.equalTo(69)
        }
        
        purpleCapsule.snp.makeConstraints { make in
            make.top.equalTo(contentView.layoutMarginsGuide.snp.top)
            make.bottom.equalTo(contentView.layoutMarginsGuide.snp.bottom)
            make.leading.equalTo(purpleCircleView.snp.trailing).offset(10)
            make.trailing.equalTo(contentView.layoutMarginsGuide.snp.trailing)
        }
        
        numberLabel.snp.makeConstraints { make in
            make.centerX.equalTo(purpleCircleView.snp.centerX)
            make.centerY.equalTo(purpleCircleView.snp.centerY)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(purpleCapsule.snp.centerY)
            make.leading.equalTo(purpleCapsule.snp.leading).offset(24)
        }
    }
}
