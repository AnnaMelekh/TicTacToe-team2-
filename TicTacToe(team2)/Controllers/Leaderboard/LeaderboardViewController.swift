//
//  LeaderboardViewController.swift
//  TicTacToe(team2)
//
//  Created by Igor Guryan on 30.09.2024.
//

import SnapKit
import UIKit

class LeaderboardViewController: UIViewController {
    
    //MARK: - Properties
    //тестовые данные
    var ticTacModel = TicTacModel()
    var leaderTime: [String] = []
    
    
    private lazy var navigationLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Leaderboard"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .bold)
        
        return label
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "background")
        self.navigationItem.titleView = navigationLabel
        leaderTime = ticTacModel.loadBestTime().sorted()
        
        //проверка есть ли данные / какой юай показать
        switch leaderTime.isEmpty {
        case true:
            setupEmptyDataUI()
        case false:
            setupDataUI()
        }
    }
    
    //MARK: - Private methods
    private func setupEmptyDataUI() {
        
        lazy var leaderboardView: UIView = {
            let view = UIView()
            
            view.translatesAutoresizingMaskIntoConstraints = false
            //view.backgroundColor = UIColor(named: "lightBlue")
            
            return view
        }()
        
        func setLeaderboardView() {
            view.addSubview(leaderboardView)
            
            leaderboardView.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview()
                make.width.equalTo(view.snp.width).multipliedBy(0.45)
                make.height.equalTo(view.snp.height).multipliedBy(0.375)
            }
        }
        
        lazy var noGameLabel: UILabel = {
            let label = UILabel()
            
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "No game history with turn on time"
            label.font = .systemFont(ofSize: 20, weight: .bold)
            label.textAlignment = .center
            label.numberOfLines = 0
            label.heightAnchor.constraint(equalToConstant: 80).isActive = true
            
            return label
        }()
        
        func setNoGameTitle() {
            leaderboardView.addSubview(noGameLabel)
            
            noGameLabel.snp.makeConstraints { make in
                make.top.equalTo(leaderboardView.snp.top)
                make.leading.equalTo(leaderboardView.snp.leading)
                make.trailing.equalTo(leaderboardView.snp.trailing)
            }
            
        }
        
        lazy var leaderboardImageView: UIImageView = {
            let imageView = UIImageView()
            
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.image = UIImage(named: "Leaderboard")
            imageView.contentMode = .scaleToFill
            return imageView
        }()
        
        func setImage() {
            leaderboardView.addSubview(leaderboardImageView)
            
            leaderboardImageView.snp.makeConstraints { make in
                make.top.equalTo(noGameLabel.snp.bottom)
                make.leading.equalTo(leaderboardView.snp.leading)
                make.trailing.equalTo(leaderboardView.snp.trailing)
                make.bottom.equalTo(leaderboardView.snp.bottom)
            }
        }
        
        setLeaderboardView()
        setNoGameTitle()
        setImage()
    }
    
    private func setupDataUI() {
        lazy var tableView: UITableView = {
            let tableView = UITableView()
            tableView.backgroundColor = UIColor(named: "background")
            
            tableView.translatesAutoresizingMaskIntoConstraints = false
            //tableView.backgroundColor = UIColor(named: "lightBlue")
            tableView.allowsSelection = false
            tableView.separatorStyle = .none
            
            //регистрация кастомной ячейки
            tableView.register(LeaderboardCell.self, forCellReuseIdentifier: LeaderboardCell.identifier)
            
            return tableView
        }()
        
        func setTableView() {
            view.addSubview(tableView)
            
            tableView.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.bottom.equalToSuperview()
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
            }
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setTableView()
    }
    
}

//MARK: - Extensions
extension LeaderboardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.leaderTime.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LeaderboardCell.identifier, for: indexPath) as? LeaderboardCell else {
            fatalError("TableView не смог определить ячейку")
        }
        
        let time = self.leaderTime[indexPath.row]
        cell.backgroundColor = UIColor(named: "background")
        //устанавливаю все ячейки одинаковыми
        cell.configure(with: String(indexPath.row + 1), and: "Time \(time)")
        
        //изменяю первую первую
        if indexPath.row == 0 {
            cell.configureFirstCell()
            cell.configure(with: String(indexPath.row + 1), and: "Best time \(time)")
        }
        
        return cell
    }
    
    
}

#Preview { LeaderboardViewController()}
