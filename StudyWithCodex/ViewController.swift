//
//  ViewController.swift
//  StudyWithCodex
//
//  Created by directionsoft on 9/21/26.
//

import UIKit

final class ViewController: UIViewController {

    private let roadmap = LearningRoadmap.stages

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGroupedBackground
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(LessonCell.self, forCellReuseIdentifier: LessonCell.reuseIdentifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        title = "UIKit Lab"
        navigationItem.backButtonDisplayMode = .minimal
    }

    private func configureView() {
        view.backgroundColor = .systemGroupedBackground
        view.addSubview(tableView)
        tableView.tableHeaderView = RoadmapHeaderView()

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        roadmap.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        roadmap[section].lessons.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let stage = roadmap[section]
        return "\(stage.level.title) · \(stage.level.subtitle)"
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let lesson = roadmap[indexPath.section].lessons[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: LessonCell.reuseIdentifier,
            for: indexPath
        ) as? LessonCell else {
            return UITableViewCell()
        }

        cell.configure(with: lesson)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let lesson = roadmap[indexPath.section].lessons[indexPath.row]

        guard lesson.isUnlocked else {
            let alert = UIAlertController(
                title: "아직 잠겨 있어요",
                message: "앞 단계를 완료하면 차례대로 열어 보세요.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            present(alert, animated: true)
            return
        }

        let challengeViewController: UIViewController
        switch lesson.number {
        case 1:
            challengeViewController = CounterChallengeViewController()
        case 2:
            challengeViewController = NavigationChallengeViewController()
        case 3:
            challengeViewController = FormChallengeViewController()
        case 10:
            challengeViewController = CodingTestChallengeViewController()
        case 11:
            challengeViewController = ValidBracketsChallengeViewController()
        case 12:
            challengeViewController = TwoSumChallengeViewController()
        case 13:
            challengeViewController = MaximumSubarrayChallengeViewController()
        default:
            return
        }

        navigationController?.pushViewController(challengeViewController, animated: true)
    }
}
