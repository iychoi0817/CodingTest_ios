import UIKit

final class CodingTestChallengeViewController: UIViewController {
    private let resultLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "코딩테스트 · 01"
        view.backgroundColor = .systemGroupedBackground
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "lightbulb"),
            style: .plain,
            target: self,
            action: #selector(showHint)
        )

        let heading = makeLabel("연속 중복 숫자 제거", style: .title1)
        let introduction = makeLabel("입문 · 배열 / 반복문\n예상 풀이 시간 15분", style: .subheadline)
        introduction.textColor = .secondaryLabel

        let problem = MissionView(
            number: "A", title: "문제",
            details: "정수 배열 numbers에서 연속으로 등장하는 같은 숫자를 하나만 남긴 배열을 반환하세요. 원래 순서는 유지해야 합니다. 떨어져 있는 같은 숫자는 제거하지 않습니다.",
            symbolName: "doc.text", tintColor: .systemIndigo
        )
        let constraints = MissionView(
            number: "B", title: "제한 사항",
            details: "• 배열 길이: 0...100,000\n• 각 숫자: 0...9\n• 빈 배열은 빈 배열을 반환합니다.\n• 목표 시간 복잡도: O(n)",
            symbolName: "list.bullet", tintColor: .systemTeal
        )
        let examples = MissionView(
            number: "C", title: "입출력 예",
            details: "[1, 1, 3, 3, 0, 1, 1] → [1, 3, 0, 1]\n[4, 4, 4, 3, 3] → [4, 3]\n[1, 2, 1] → [1, 2, 1]\n[] → []",
            symbolName: "arrow.right", tintColor: .systemOrange
        )
        let instructions = makeLabel(
            "풀이 방법\nXcode에서 Features/CodingTest/RemoveConsecutiveDuplicates.swift의 solve(_:) 함수 TODO를 완성하세요. 앱을 다시 실행하고 아래 버튼으로 확인하세요.",
            style: .body
        )
        let signature = makeLabel("func solve(_ numbers: [Int]) -> [Int]", style: .body)
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
        let cases: [(input: [Int], expected: [Int])] = [
            ([1, 1, 3, 3, 0, 1, 1], [1, 3, 0, 1]),
            ([4, 4, 4, 3, 3], [4, 3]),
            ([1, 2, 1], [1, 2, 1]),
            ([], []),
            ([7], [7]),
            ([0, 0, 0, 0], [0])
        ]
        var passed = 0
        let results = cases.enumerated().map { index, test in
            let actual = RemoveConsecutiveDuplicates.solve(test.input)
            let isCorrect = actual == test.expected
            if isCorrect { passed += 1 }
            return "\(isCorrect ? "✓" : "✗") 테스트 \(index + 1)\n입력: \(test.input)\n기대: \(test.expected)\n결과: \(actual)"
        }
        let summary = passed == cases.count
            ? "모든 테스트를 통과했어요! 배열을 한 번만 순회하는지도 확인해 보세요."
            : "\(cases.count)개 중 \(passed)개 통과 · 실패한 입력을 확인해 보세요."
        resultLabel.text = ([summary] + results).joined(separator: "\n\n")
    }

    @objc private func showHint() {
        let alert = UIAlertController(
            title: "힌트",
            message: "전체 배열에서 중복을 찾기보다, 결과 배열의 마지막 숫자와 현재 숫자를 비교해 보세요. 빈 배열의 last는 nil입니다.",
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
