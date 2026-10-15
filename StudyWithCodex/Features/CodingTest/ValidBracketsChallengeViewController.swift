import UIKit

final class ValidBracketsChallengeViewController: UIViewController {
    private let resultLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "코딩테스트 · 02"
        view.backgroundColor = .systemGroupedBackground
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "lightbulb"),
            style: .plain,
            target: self,
            action: #selector(showHint)
        )

        let heading = makeLabel("올바른 괄호", style: .title1)
        let introduction = makeLabel("기초 · 문자열 / 스택\n예상 풀이 시간 20분", style: .subheadline)
        introduction.textColor = .secondaryLabel

        let problem = MissionView(
            number: "A", title: "문제",
            details: "괄호 문자열 brackets가 올바르면 true, 아니면 false를 반환하세요. 모든 여는 괄호는 같은 종류의 닫는 괄호와 짝을 이루어야 하고, 가장 최근에 열린 괄호부터 닫혀야 합니다. 예를 들어 ([)]는 종류별 개수가 같아도 순서가 틀려 올바르지 않습니다.",
            symbolName: "doc.text", tintColor: .systemIndigo
        )
        let constraints = MissionView(
            number: "B", title: "제한 사항",
            details: "• 문자열 길이: 0...100,000\n• 문자는 (, ), [, ], {, }만 주어집니다.\n• 빈 문자열은 true를 반환합니다.\n• 목표 시간 복잡도: O(n)",
            symbolName: "list.bullet", tintColor: .systemTeal
        )
        let examples = MissionView(
            number: "C", title: "입출력 예",
            details: "([]){} → true\n([)] → false\n(() → false\n빈 문자열 → true",
            symbolName: "arrow.right", tintColor: .systemOrange
        )
        let instructions = makeLabel(
            "풀이 방법\nXcode에서 Features/CodingTest/ValidBrackets.swift의 solve(_:) 함수 TODO를 완성하세요. 앱을 다시 실행하고 아래 버튼으로 확인하세요.",
            style: .body
        )
        let signature = makeLabel("func solve(_ brackets: String) -> Bool", style: .body)
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
        let cases: [(input: String, expected: Bool)] = [
            ("()[]{}", true),
            ("([]){}", true),
            ("{[()]}", true),
            ("([)]", false),
            ("(()", false),
            (")(", false),
            ("", true),
            ("(", false),
            ("]", false),
            ("(]", false)
        ]
        var passed = 0
        let results = cases.enumerated().map { index, test in
            let actual = ValidBrackets.solve(test.input)
            let isCorrect = actual == test.expected
            if isCorrect { passed += 1 }
            return "\(isCorrect ? "✓" : "✗") 테스트 \(index + 1)\n입력: \(test.input)\n기대: \(test.expected)\n결과: \(actual)"
        }
        let summary = passed == cases.count
            ? "모든 테스트를 통과했어요! 문자열을 한 번만 순회하는지도 확인해 보세요."
            : "\(cases.count)개 중 \(passed)개 통과 · 실패한 입력을 확인해 보세요."
        resultLabel.text = ([summary] + results).joined(separator: "\n\n")
    }

    @objc private func showHint() {
        let alert = UIAlertController(
            title: "힌트",
            message: "가장 최근에 열린 괄호부터 닫혀야 하므로 스택을 활용해 보세요. Swift 배열의 append로 넣고 popLast로 꺼낼 수 있습니다. 개수만 같다고 올바른 괄호는 아닙니다.",
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
