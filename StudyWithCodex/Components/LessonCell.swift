import UIKit

final class LessonCell: UITableViewCell {
    static let reuseIdentifier = "LessonCell"

    func configure(with lesson: Lesson) {
        var content = UIListContentConfiguration.subtitleCell()
        content.text = "\(lesson.number). \(lesson.title)"
        content.secondaryText = lesson.summary
        content.image = UIImage(systemName: lesson.isCompleted ? "checkmark.circle.fill" : lesson.symbolName)
        content.imageProperties.tintColor = lesson.isCompleted ? .systemGreen : (lesson.isUnlocked ? .systemIndigo : .tertiaryLabel)
        content.textProperties.color = lesson.isUnlocked ? .label : .secondaryLabel
        content.secondaryTextProperties.color = .secondaryLabel
        contentConfiguration = content

        accessoryType = lesson.isUnlocked ? .disclosureIndicator : .none
        if lesson.isUnlocked {
            accessoryView = nil
        } else {
            let lockView = UIImageView(image: UIImage(systemName: "lock.fill"))
            lockView.tintColor = .tertiaryLabel
            accessoryView = lockView
        }
        selectionStyle = lesson.isUnlocked ? .default : .none
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        accessoryView = nil
        accessoryType = .none
    }
}
