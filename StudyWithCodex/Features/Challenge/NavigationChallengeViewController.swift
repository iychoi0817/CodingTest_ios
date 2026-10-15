import UIKit

final class NavigationChallengeViewController: UIViewController {

    private let nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "닉네임을 입력하세요"
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = .done
        textField.autocorrectionType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var previewButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "프로필 미리보기"
        configuration.image = UIImage(systemName: "arrow.right")
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 8

        let button = UIButton(configuration: configuration)
        button.addTarget(self, action: #selector(didTapPreview), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    private func configureView() {
        title = "02 · 화면 이동"
        view.backgroundColor = .systemGroupedBackground
        navigationItem.largeTitleDisplayMode = .never

        let introLabel = makeLabel(
            text: "입력한 닉네임을 다음 화면으로 전달하세요.",
            style: .title3,
            color: .label
        )
        introLabel.font = .preferredFont(forTextStyle: .title3).withTraits(.traitBold)

        let navigationMission = MissionView(
            number: "A",
            title: "화면 설계",
            details: "UINavigationController의 스택에 결과 화면을 push합니다.",
            symbolName: "square.stack.3d.forward.dottedline",
            tintColor: .systemIndigo
        )

        let dataMission = MissionView(
            number: "B",
            title: "데이터 설계",
            details: "입력 화면이 결과 화면의 nickname 프로퍼티에 값을 전달합니다.",
            symbolName: "arrow.right.doc.on.clipboard",
            tintColor: .systemTeal
        )

        let inputTitleLabel = makeLabel(text: "닉네임", style: .headline, color: .label)
        let inputStack = UIStackView(arrangedSubviews: [inputTitleLabel, nicknameTextField, previewButton])
        inputStack.axis = .vertical
        inputStack.spacing = 12
        inputStack.translatesAutoresizingMaskIntoConstraints = false

        let inputPanel = UIView()
        inputPanel.backgroundColor = .secondarySystemGroupedBackground
        inputPanel.layer.cornerRadius = 8
        inputPanel.addSubview(inputStack)

        let checklistLabel = makeLabel(
            text: "완료 조건\n□ 빈 닉네임이면 경고창이 나타난다\n□ 버튼을 누르면 다음 화면으로 이동한다\n□ 다음 화면에 입력한 닉네임이 표시된다\n□ 뒤로 가면 입력 내용이 유지된다",
            style: .subheadline,
            color: .secondaryLabel
        )

        let contentStack = UIStackView(arrangedSubviews: [
            introLabel, navigationMission, dataMission, inputPanel, checklistLabel
        ])
        contentStack.axis = .vertical
        contentStack.spacing = 12
        contentStack.setCustomSpacing(24, after: dataMission)
        contentStack.setCustomSpacing(20, after: inputPanel)
        contentStack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(contentStack)
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            contentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            contentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nicknameTextField.heightAnchor.constraint(equalToConstant: 48),
            previewButton.heightAnchor.constraint(equalToConstant: 48),
            inputStack.topAnchor.constraint(equalTo: inputPanel.topAnchor, constant: 16),
            inputStack.leadingAnchor.constraint(equalTo: inputPanel.leadingAnchor, constant: 16),
            inputStack.trailingAnchor.constraint(equalTo: inputPanel.trailingAnchor, constant: -16),
            inputStack.bottomAnchor.constraint(equalTo: inputPanel.bottomAnchor, constant: -16)
        ])
    }

    @objc private func didTapPreview() {
        // TODO 1: nicknameTextField.text에서 앞뒤 공백을 제거한 값을 만드세요.
        let trimmedNickName = nicknameTextField.text?.trimmingCharacters(in: .whitespaces) ?? ""
        // TODO 2: 값이 비어 있다면 showEmptyNicknameAlert()를 호출하고 종료하세요.
        if trimmedNickName.isEmpty {
            showEmptyNicknameAlert()
            return
        }
        // TODO 3: ProfilePreviewViewController를 만들고 nickname을 전달하세요.
        let vc = ProfilePreviewViewController()
        vc.nickname = trimmedNickName
        
        // TODO 4: navigationController?.pushViewController(_:animated:)로 이동하세요.
        self.navigationController?.pushViewController(vc, animated: true)
    }

    private func showEmptyNicknameAlert() {
        let alert = UIAlertController(
            title: "닉네임이 필요해요",
            message: "한 글자 이상 입력한 뒤 다시 시도하세요.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }

    private func makeLabel(text: String, style: UIFont.TextStyle, color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .preferredFont(forTextStyle: style)
        label.textColor = color
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        return label
    }
}
