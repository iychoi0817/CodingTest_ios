import UIKit

final class TwoSumChallengeViewController: UIViewController {
    private let resultLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "코딩테스트 · 03"
        view.backgroundColor = .systemGroupedBackground
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "lightbulb"),
            style: .plain,
            target: self,
            action: #selector(showHint)
        )

        let heading = makeLabel("두 수의 합", style: .title1)
        let introduction = makeLabel("기초 · 배열 / 딕셔너리\n예상 풀이 시간 20분", style: .subheadline)
        introduction.textColor = .secondaryLabel

        let problem = MissionView(
            number: "A", title: "문제",
            details: "정수 배열 numbers에서 합이 target인 서로 다른 두 원소를 찾아 인덱스를 오름차순으로 반환하세요. 인덱스는 0부터 시작하며, 같은 원소를 두 번 사용할 수 없습니다. 정답 쌍이 없으면 빈 배열을 반환하세요.",
            symbolName: "doc.text", tintColor: .systemIndigo
        )
        let constraints = MissionView(
            number: "B", title: "제한 사항",
            details: "• 배열 길이: 0...100,000\n• 각 숫자 및 target: -1,000,000...1,000,000\n• 정답 쌍은 최대 하나입니다.\n• 같은 값도 인덱스가 다르면 사용 가능합니다.\n• 목표 평균 시간 복잡도: O(n)",
            symbolName: "list.bullet", tintColor: .systemTeal
        )
        let examples = MissionView(
            number: "C", title: "입출력 예",
            details: "[2, 7, 11, 15], target = 9 → [0, 1]\n[3, 2, 4], target = 6 → [1, 2]\n[3, 3], target = 6 → [0, 1]\n[5], target = 10 → []",
            symbolName: "arrow.right", tintColor: .systemOrange
        )
        let instructions = makeLabel(
            "풀이 방법\nXcode에서 Features/CodingTest/TwoSum.swift의 solve(_:) 함수 TODO를 완성하세요. 앱을 다시 실행하고 아래 버튼으로 확인하세요.",
            style: .body
        )
        let signature = makeLabel("func solve(_ numbers: [Int], target: Int) -> [Int]", style: .body)
        signature.font = .monospacedSystemFont(ofSize: 14, weight: .regular)

        var configuration = UIButton.Configuration.filled()
        configuration.title = "풀이 확인"
        configuration.image = UIImage(systemName: "play.fill")
        configuration.imagePadding = 8
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 14, leading: 16, bottom: 14, trailing: 16)
        let checkButton = UIButton(configuration: configuration)
        checkButton.addTarget(self, action: #selector(checkSolution), for: .touchUpInside)

        resultLabel.font = .preferredFont(forTextStyle: .subheadline)
        resultLabel.adjustsFontForContentSizeCategory = true
        resultLabel.numberOfLines = 0
        resultLabel.textColor = .secondaryLabel
        resultLabel.text = "아직 확인하지 않았어요. TODO를 완성한 뒤 풀이를 확인하세요."
        resultLabel.accessibilityTraits.insert(.updatesFrequently)

        let stack = UIStackView(arrangedSubviews: [
            heading, introduction, problem, constraints, examples,
            instructions, signature, checkButton, resultLabel
        ])
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false

        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(stack)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stack.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -20),
            stack.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -32)
        ])
    }

    @objc private func checkSolution() {
        let cases: [(input: [Int], target: Int, expected: [Int])] = [
            ([2, 7, 11, 15], 9, [0, 1]),
            ([3, 2, 4], 6, [1, 2]),
            ([3, 3], 6, [0, 1]),
            ([-3, 4, 3, 90], 0, [0, 2]),
            ([0, 4, 3, 0], 0, [0, 3]),
            ([1, 2, 3], 10, []),
            ([], 0, []),
            ([5], 10, []),
            ([1, 5, 2, 8], 10, [2, 3]),
            ([-5, -2, -8], -10, [1, 2])
        ]
        var passed = 0
        let results = cases.enumerated().map { index, test in
            let actual = TwoSum.solve(test.input, target: test.target)
            let isCorrect = actual == test.expected
            if isCorrect { passed += 1 }
            return "\(isCorrect ? "✓" : "✗") 테스트 \(index + 1)\n입력: \(test.input)\ntarget: \(test.target)\n기대: \(test.expected)\n결과: \(actual)"
        }
        let summary = passed == cases.count
            ? "모든 테스트를 통과했어요! 배열을 한 번만 순회하는지도 확인해 보세요."
            : "\(cases.count)개 중 \(passed)개 통과 · 실패한 입력을 확인해 보세요."
        resultLabel.text = ([summary] + results).joined(separator: "\n\n")
    }

    @objc private func showHint() {
        let alert = UIAlertController(
            title: "힌트",
            message: "현재 숫자가 x라면 필요한 짝은 target - x입니다. 이미 본 숫자의 인덱스를 딕셔너리에 저장해 빠르게 찾아보세요. 같은 원소를 재사용하지 않으려면 조회와 저장 중 무엇을 먼저 해야 할까요?",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }

    private func makeLabel(_ text: String, style: UIFont.TextStyle) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .preferredFont(forTextStyle: style)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        return label
    }
}
