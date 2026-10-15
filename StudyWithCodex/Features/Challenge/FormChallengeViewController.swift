import UIKit

final class FormChallengeViewController: UIViewController {

    private lazy var emailTextField = makeTextField(
        placeholder: "name@example.com",
        contentType: .emailAddress,
        returnKeyType: .next
    )

    private lazy var passwordTextField: UITextField = {
        let textField = makeTextField(
            placeholder: "8자 이상 입력하세요",
            contentType: .newPassword,
            returnKeyType: .done
        )
        textField.isSecureTextEntry = true
        return textField
    }()

    private let feedbackLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일과 비밀번호를 입력하세요."
        label.font = .preferredFont(forTextStyle: .footnote)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    private lazy var submitButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "가입 완료"
        configuration.image = UIImage(systemName: "checkmark")
        configuration.imagePadding = 8

        let button = UIButton(configuration: configuration)
        button.isEnabled = false
        button.addTarget(self, action: #selector(didTapSubmit), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureTextFields()
        render()
    }

    private func configureView() {
        title = "03 · 입력 폼"
        view.backgroundColor = .systemGroupedBackground
        navigationItem.largeTitleDisplayMode = .never

        let introLabel = makeLabel(
            text: "입력 흐름과 검증 상태가 자연스러운 가입 폼을 완성하세요.",
            style: .title3,
            color: .label
        )
        introLabel.font = .preferredFont(forTextStyle: .title3).withTraits(.traitBold)

        let delegateMission = MissionView(
            number: "A",
            title: "입력 흐름 설계",
            details: "UITextFieldDelegate로 Next와 Done 키의 동작을 제어합니다.",
            symbolName: "keyboard",
            tintColor: .systemIndigo
        )

        let validationMission = MissionView(
            number: "B",
            title: "검증 상태 설계",
            details: "입력값을 검사하고 render()에서 안내 문구와 버튼 상태를 갱신합니다.",
            symbolName: "checkmark.shield",
            tintColor: .systemTeal
        )

        let formStack = UIStackView(arrangedSubviews: [
            makeFieldGroup(title: "이메일", textField: emailTextField),
            makeFieldGroup(title: "비밀번호", textField: passwordTextField),
            feedbackLabel,
            submitButton
        ])
        formStack.axis = .vertical
        formStack.spacing = 16
        formStack.translatesAutoresizingMaskIntoConstraints = false

        let formPanel = UIView()
        formPanel.backgroundColor = .secondarySystemGroupedBackground
        formPanel.layer.cornerRadius = 8
        formPanel.addSubview(formStack)

        let checklistLabel = makeLabel(
            text: "완료 조건\n□ Next를 누르면 비밀번호 입력란으로 이동한다\n□ Done 또는 빈 화면을 누르면 키보드가 닫힌다\n□ 올바른 이메일과 8자 이상 비밀번호만 허용한다\n□ 조건 충족 전에는 가입 버튼이 비활성화된다",
            style: .subheadline,
            color: .secondaryLabel
        )

        let contentStack = UIStackView(arrangedSubviews: [
            introLabel, delegateMission, validationMission, formPanel, checklistLabel
        ])
        contentStack.axis = .vertical
        contentStack.spacing = 12
        contentStack.setCustomSpacing(24, after: validationMission)
        contentStack.setCustomSpacing(20, after: formPanel)
        contentStack.translatesAutoresizingMaskIntoConstraints = false

        let scrollView = UIScrollView()
        scrollView.keyboardDismissMode = .interactive
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentStack)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapBackground))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentStack.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 20),
            contentStack.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 20),
            contentStack.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -20),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -32),
            formStack.topAnchor.constraint(equalTo: formPanel.topAnchor, constant: 16),
            formStack.leadingAnchor.constraint(equalTo: formPanel.leadingAnchor, constant: 16),
            formStack.trailingAnchor.constraint(equalTo: formPanel.trailingAnchor, constant: -16),
            formStack.bottomAnchor.constraint(equalTo: formPanel.bottomAnchor, constant: -16),
            submitButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }

    private func configureTextFields() {
        // TODO 1: 두 TextField의 delegate를 self로 지정하세요.
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }

    private func render() {
        var correctEmailText: Bool = false
        var correctPasswordText: Bool = false
        
        // TODO 5: 이메일에 "@"와 "."이 포함됐는지 확인하세요.
        let emailText = emailTextField.text ?? ""
        if emailText.contains("@") && emailText.contains(".") {
            correctEmailText = true
        }
        
        // TODO 6: 비밀번호가 8자 이상인지 확인하세요.
        let passwordText = passwordTextField.text ?? ""
        if passwordText.count >= 8 {
            correctPasswordText = true
        }
        
        // TODO 7: 두 조건에 따라 submitButton과 feedbackLabel을 갱신하세요.
        if correctEmailText && correctPasswordText {
            submitButton.isEnabled = true
            feedbackLabel.text = "모든 조건을 통과했습니다."
        }
    }

    @objc private func didTapBackground() {
        // TODO 4: 현재 화면의 키보드를 닫으세요.
    }

    @objc private func didTapSubmit() {
        view.endEditing(true)

        let alert = UIAlertController(
            title: "가입 완료",
            message: "입력 폼의 모든 조건을 통과했습니다.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }

    private func makeTextField(
        placeholder: String,
        contentType: UITextContentType,
        returnKeyType: UIReturnKeyType
    ) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.textContentType = contentType
        textField.returnKeyType = returnKeyType
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        return textField
    }

    private func makeFieldGroup(title: String, textField: UITextField) -> UIStackView {
        let titleLabel = makeLabel(text: title, style: .headline, color: .label)
        let stackView = UIStackView(arrangedSubviews: [titleLabel, textField])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
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

extension FormChallengeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // TODO 2: 이메일 필드라면 비밀번호 필드를 first responder로 만드세요.
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        }
        // TODO 3: 비밀번호 필드라면 키보드를 닫으세요.
        else {
            textField.endEditing(true)
        }
        return true
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        // TODO 8: 입력값이 바뀔 때마다 render()를 호출하세요.
        render()
    }
}
