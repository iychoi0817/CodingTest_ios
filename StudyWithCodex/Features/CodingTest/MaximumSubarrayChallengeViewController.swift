import UIKit

final class MaximumSubarrayChallengeViewController: UIViewController {
    private let resultLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "코딩테스트 · 04"
        view.backgroundColor = .systemGroupedBackground
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "lightbulb"),
            style: .plain,
            target: self,
            action: #selector(showHint)
        )

        let heading = makeLabel("최대 연속 부분합", style: .title1)
        let introduction = makeLabel("기초 · 배열 / 상태 갱신\n예상 풀이 시간 25분", style: .subheadline)
        introduction.textColor = .secondaryLabel

        let problem = MissionView(
            number: "A", title: "문제",
            details: "정수 배열 numbers에서 연속된 원소를 하나 이상 선택해 만들 수 있는 합 중 최댓값을 반환하세요. 원소를 건너뛰거나 순서를 바꿀 수 없습니다. 예를 들어 [4, -1, 2, 1]의 합은 6입니다. 모든 숫자가 음수여도 최소 하나는 선택해야 합니다.",
            symbolName: "doc.text", tintColor: .systemIndigo
        )
        let constraints = MissionView(
            number: "B", title: "제한 사항",
            details: "• 배열 길이: 1...100,000 (빈 배열 없음)\n• 각 숫자: -1,000,000...1,000,000\n• 반환값은 인덱스가 아닌 최대 합입니다.\n• 목표 시간 복잡도: O(n)\n• 목표 추가 공간 복잡도: O(1)",
            symbolName: "list.bullet", tintColor: .systemTeal
        )
        let examples = MissionView(
            number: "C", title: "입출력 예",
            details: "[-2, 1, -3, 4, -1, 2, 1, -5, 4] → 6\n선택한 구간: [4, -1, 2, 1]\n[-3, -1, -2] → -1\n[5, 4, -1, 7, 8] → 23",
            symbolName: "arrow.right", tintColor: .systemOrange
        )
        let instructions = makeLabel(
            "풀이 방법\nXcode에서 Features/CodingTest/MaximumSubarray.swift의 solve(_:) 함수 TODO를 완성하세요. 앱을 다시 실행하고 아래 버튼으로 확인하세요.",
            style: .body
        )
        let signature = makeLabel("func solve(_ numbers: [Int]) -> Int", style: .body)
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
        let cases: [(input: [Int], expected: Int)] = [
            ([-2, 1, -3, 4, -1, 2, 1, -5, 4], 6),
            ([1], 1),
            ([-1], -1),
            ([-8, -3, -6, -2, -5, -4], -2),
            ([5, 4, -1, 7, 8], 23),
            ([0, 0, 0], 0),
            ([2, -1, 2, 3, 4, -5], 10),
            ([-2, -1, 4, -1, 2], 5),
            ([4, -10, 3, 2], 5),
            ([1_000_000, 1_000_000, -1, 1_000_000], 2_999_999)
        ]
        var passed = 0
        let results = cases.enumerated().map { index, test in
            let actual = MaximumSubarray.solve(test.input)
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
            message: "현재 위치에서 끝나는 구간만 생각해 보세요. 이전 구간에 현재 숫자를 더하는 것과 현재 숫자부터 새로 시작하는 것 중 어느 쪽이 더 클까요? 전체 최댓값도 별도로 기억하세요. 초기값을 0으로 두면 모두 음수인 경우를 놓칠 수 있습니다.",
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
