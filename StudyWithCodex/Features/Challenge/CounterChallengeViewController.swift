import UIKit

final class CounterChallengeViewController: UIViewController {

    // TODO 1: 화면의 현재 값을 저장할 count 프로퍼티를 만들어 보세요.
    // 시작 값은 0입니다.
    private var count: Int = 0

    private let countLabel: UILabel = {
        let label = UILabel()
        label.text = "?"
        label.font = .monospacedDigitSystemFont(ofSize: 64, weight: .bold)
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    private lazy var minusButton = makeButton(title: "감소", symbolName: "minus")
    private lazy var plusButton = makeButton(title: "증가", symbolName: "plus")
    private lazy var resetButton = makeButton(title: "초기화", symbolName: "arrow.counterclockwise")

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureActions()
        render()
    }

    private func configureView() {
        title = "01 · 카운터"
        view.backgroundColor = .systemGroupedBackground
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "lightbulb"),
            style: .plain,
            target: self,
            action: #selector(showHint)
        )

        let introLabel = makeLabel(
            text: "버튼을 눌러 -10부터 10까지 값을 바꾸는 카운터를 완성하세요.",
            style: .title3,
            color: .label
        )
        introLabel.font = .preferredFont(forTextStyle: .title3).withTraits(.traitBold)

        let uiMission = MissionView(
            number: "A",
            title: "UI 설계",
            details: "UIStackView와 Auto Layout으로 세 버튼을 같은 너비로 배치합니다.",
            symbolName: "rectangle.3.group",
            tintColor: .systemIndigo
        )

        let logicMission = MissionView(
            number: "B",
            title: "로직 설계",
            details: "State(count)를 변경한 뒤 render() 한 곳에서 화면을 갱신합니다.",
            symbolName: "arrow.triangle.2.circlepath",
            tintColor: .systemTeal
        )

        let counterPanel = makeCounterPanel()
        let checklistLabel = makeLabel(
            text: "완료 조건\n□ 시작 값이 0으로 보인다\n□ 증가·감소는 -10...10을 넘지 않는다\n□ 경계에 도달하면 해당 버튼이 비활성화된다\n□ 초기화하면 다시 0이 된다",
            style: .subheadline,
            color: .secondaryLabel
        )

        let contentStack = UIStackView(arrangedSubviews: [
            introLabel, uiMission, logicMission, counterPanel, checklistLabel
        ])
        contentStack.axis = .vertical
        contentStack.spacing = 12
        contentStack.setCustomSpacing(24, after: logicMission)
        contentStack.setCustomSpacing(20, after: counterPanel)
        contentStack.translatesAutoresizingMaskIntoConstraints = false

        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentStack)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentStack.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 20),
            contentStack.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 20),
            contentStack.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -20),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -32)
        ])
    }

    private func makeCounterPanel() -> UIView {
        let buttonStack = UIStackView(arrangedSubviews: [minusButton, resetButton, plusButton])
        buttonStack.axis = .horizontal
        buttonStack.distribution = .fillEqually
        buttonStack.spacing = 8

        let stack = UIStackView(arrangedSubviews: [countLabel, buttonStack])
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false

        let panel = UIView()
        panel.backgroundColor = .secondarySystemGroupedBackground
        panel.layer.cornerRadius = 8
        panel.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: panel.topAnchor, constant: 28),
            stack.leadingAnchor.constraint(equalTo: panel.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: panel.trailingAnchor, constant: -16),
            stack.bottomAnchor.constraint(equalTo: panel.bottomAnchor, constant: -20),
            buttonStack.heightAnchor.constraint(equalToConstant: 48)
        ])
        return panel
    }

    private func configureActions() {
        minusButton.addTarget(self, action: #selector(didTapMinus), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(didTapPlus), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(didTapReset), for: .touchUpInside)
    }

    @objc private func didTapMinus() {
        // TODO 2: count를 1 줄이고 render()를 호출하세요.
        count -= 1
        render()
    }

    @objc private func didTapPlus() {
        // TODO 3: count를 1 늘리고 render()를 호출하세요.
        count += 1
        render()
    }

    @objc private func didTapReset() {
        // TODO 4: count를 시작 값으로 되돌리고 render()를 호출하세요.
        count = 0
        render()
    }

    private func render() {
        // TODO 5: countLabel에 현재 값을 표시하세요.
        countLabel.text = "\(count)"
        // TODO 6: -10이면 감소 버튼, 10이면 증가 버튼을 비활성화하세요.
        if count <= -10 {
            minusButton.isEnabled = false
            plusButton.isEnabled = true
        } else if count >= 10 {
            minusButton.isEnabled = true
            plusButton.isEnabled = false
        } else {
            minusButton.isEnabled = true
            plusButton.isEnabled = true
        }
    }

    @objc private func showHint() {
        let alert = UIAlertController(
            title: "첫 번째 힌트",
            message: "버튼 메서드에서는 count만 바꾸고, 화면 변경은 render()가 맡게 해 보세요.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }

    private func makeButton(title: String, symbolName: String) -> UIButton {
        var configuration = UIButton.Configuration.tinted()
        configuration.title = title
        configuration.image = UIImage(systemName: symbolName)
        configuration.imagePadding = 6
        return UIButton(configuration: configuration)
    }

    private func makeLabel(text: String, style: UIFont.TextStyle, color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .preferredFont(forTextStyle: style)
        label.textColor = color
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        return label
    }
}
