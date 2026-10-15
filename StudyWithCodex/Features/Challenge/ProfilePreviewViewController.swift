import UIKit

final class ProfilePreviewViewController: UIViewController {

    var nickname: String?

    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "전달받은 닉네임"
        label.font = .preferredFont(forTextStyle: .largeTitle).withTraits(.traitBold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        render()
    }

    private func configureView() {
        title = "프로필"
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never

        let symbolView = UIImageView(image: UIImage(systemName: "person.crop.circle.fill"))
        symbolView.tintColor = .systemIndigo
        symbolView.contentMode = .scaleAspectFit

        let descriptionLabel = UILabel()
        descriptionLabel.text = "UIKit Lab에 오신 것을 환영합니다."
        descriptionLabel.font = .preferredFont(forTextStyle: .body)
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.textAlignment = .center

        let stackView = UIStackView(arrangedSubviews: [symbolView, nicknameLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            symbolView.heightAnchor.constraint(equalToConstant: 96),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }

    private func render() {
        // TODO 5: 전달받은 nickname을 nicknameLabel에 표시하세요.
        nicknameLabel.text = nickname
    }
}
