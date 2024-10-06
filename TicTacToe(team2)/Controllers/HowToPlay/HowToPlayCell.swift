//
//  HowToPlayCell.swift
//  TicTacToe(team2)
//
//  Created by Oksana on 03/10/24.
//

import UIKit
import SnapKit


class HowToPlayCell: UITableViewCell {
    
    //MARK: - Elements
    static let identifier = "HowToPlayCell"
    
    private lazy var purpleCircleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "purple")
        view.layer.cornerRadius = 45 / 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var purpleCapsule: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "lightBlue")
        view.layer.cornerRadius = 30
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "1"
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    
    private lazy var instructionLabel: UILabel = {
           let label = UILabel()
           label.textAlignment = .left
           label.font = .systemFont(ofSize: 18, weight: .light)
           label.numberOfLines = 0
           label.lineBreakMode = .byWordWrapping
           label.translatesAutoresizingMaskIntoConstraints = false
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

    
    //MARK: - Methods
    
        //функция для заполнения данными из контроллера
        public func configure(with number: String, and instruction: String) {
            self.numberLabel.text = number
            self.instructionLabel.text = instruction

        }
    
    private func setupUI() {
        self.contentView.addSubview(purpleCapsule)
        self.contentView.addSubview(purpleCircleView)
        self.contentView.addSubview(numberLabel)
        purpleCapsule.addSubview(instructionLabel)
        
        purpleCircleView.snp.makeConstraints { make in
            make.top.equalTo(contentView.layoutMarginsGuide.snp.top)
            make.leading.equalTo(contentView.layoutMarginsGuide.snp.leading)
            make.height.equalTo(45)
            make.width.equalTo(45)
        }
        
        purpleCapsule.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).inset(5)
            make.bottom.equalTo(contentView.snp.bottom).inset(10)
            make.leading.equalTo(purpleCircleView.snp.trailing).offset(20)
            make.trailing.equalTo(contentView.snp.trailing).offset(-21)
        }
        
        instructionLabel.snp.makeConstraints { make in
            make.top.equalTo(purpleCapsule.snp.top).inset(12)
            make.leading.equalTo(purpleCapsule.snp.leading).offset(24)
            make.trailing.equalTo(purpleCapsule.snp.trailing).inset(24)
            make.bottom.equalTo(purpleCapsule.snp.bottom).inset(12)
        }
        
        numberLabel.snp.makeConstraints { make in
            make.centerX.equalTo(purpleCircleView.snp.centerX)
            make.centerY.equalTo(purpleCircleView.snp.centerY)
        }
    }
}
