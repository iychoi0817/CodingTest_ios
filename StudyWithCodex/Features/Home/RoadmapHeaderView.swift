import UIKit

final class RoadmapHeaderView: UIView {
    private let progressView: UIProgressView = {
        let view = UIProgressView(progressViewStyle: .default)
        view.progress = 2.0 / 9.0
        view.progressTintColor = .systemIndigo
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: frame.width, height: 174))
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        let eyebrowLabel = makeLabel(text: "LEARNING PATH", style: .caption1, color: .systemIndigo)
        eyebrowLabel.font = .preferredFont(forTextStyle: .caption1).withTraits(.traitBold)

        let titleLabel = makeLabel(text: "작게 만들고, 깊게 이해하기", style: .title2, color: .label)
        titleLabel.font = .preferredFont(forTextStyle: .title2).withTraits(.traitBold)

        let descriptionLabel = makeLabel(
            text: "각 문제에서 UI 구현과 로직 설계를 함께 연습합니다.",
            style: .body,
            color: .secondaryLabel
        )
        descriptionLabel.numberOfLines = 0

        let progressLabel = makeLabel(text: "진행도  2 / 9", style: .footnote, color: .secondaryLabel)

        let stackView = UIStackView(arrangedSubviews: [
            eyebrowLabel, titleLabel, descriptionLabel, progressLabel, progressView
        ])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.setCustomSpacing(14, after: descriptionLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }

    private func makeLabel(text: String, style: UIFont.TextStyle, color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .preferredFont(forTextStyle: style)
        label.textColor = color
        label.adjustsFontForContentSizeCategory = true
        return label
    }
}

extension UIFont {
    func withTraits(_ traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        guard let descriptor = fontDescriptor.withSymbolicTraits(traits) else { return self }
        return UIFont(descriptor: descriptor, size: pointSize)
    }
}
