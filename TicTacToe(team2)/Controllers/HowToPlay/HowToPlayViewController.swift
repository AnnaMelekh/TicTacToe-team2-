//
//  HowToPlayViewController.swift
//  TicTacToe(team2)
//
//  Created by Igor Guryan on 30.09.2024.
//

import UIKit

class HowToPlayViewController: UIViewController {
    
    //MARK: - Elements

private lazy var navigationLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "How to play"
    label.textAlignment = .center
    label.font = .systemFont(ofSize: 24, weight: .bold)
    return label
}()

private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.backgroundColor = UIColor(named: "background")
    tableView.allowsSelection = false
    tableView.separatorStyle = .none
    tableView.register(HowToPlayCell.self, forCellReuseIdentifier: HowToPlayCell.identifier)
    tableView.delegate = self
    tableView.dataSource = self
    tableView.estimatedRowHeight = 100
    tableView.rowHeight = UITableView.automaticDimension
    tableView.showsVerticalScrollIndicator = true
    return tableView
}()

//MARK: - Life Cycle

override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.titleView = navigationLabel
    setupUI()
    
}

private func setupUI() {
    view.backgroundColor = UIColor(named: "background")
    view.addSubview(tableView)
    
    
    NSLayoutConstraint.activate([
        tableView.topAnchor.constraint(equalTo: view.topAnchor),
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    
}

//MARK: - Instruction Array

let instructionArray: [String] = [
    "Draw a grid with three rows and three columns, creating nine squares in total.",
    
    "Players take turns placing their marker (X or O) in an empty square. To make a move, a player selects a number corresponding to the square where they want to place their marker.",
    
    "Player X starts by choosing a square (e.g., square 5). Player O follows by choosing an empty square (e.g., square 1). Continue alternating turns until the game ends.",
    
    "The first player to align three of their markers horizontally, vertically, or diagonally wins. Examples of Winning Combinations: Horizontal: Squares 1, 2, 3 or 4, 5, 6 or 7, 8, 9 Vertical: Squares 1, 4, 7 or 2, 5, 8 or 3, 6, 9 Diagonal: Squares 1, 5, 9 or 3, 5, 7"
]
}
//MARK: - Extensions


extension HowToPlayViewController: UITableViewDelegate, UITableViewDataSource {
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.instructionArray.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: HowToPlayCell.identifier, for: indexPath) as? HowToPlayCell else {
        fatalError("TableView не смог определить ячейку")
    }
    cell.backgroundColor = UIColor(named: "background")
    let instruction = self.instructionArray[indexPath.row]
    cell.configure(with: String(indexPath.row + 1), and: instruction)
    
    return cell
}
}

#Preview {
HowToPlayViewController()
}
