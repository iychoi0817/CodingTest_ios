# 02 화면 이동 풀이

먼저 직접 풀어 본 뒤 확인하세요.

`NavigationChallengeViewController`의 버튼 메서드입니다.

```swift
@objc private func didTapPreview() {
    let nickname = nicknameTextField.text?
        .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

    guard !nickname.isEmpty else {
        showEmptyNicknameAlert()
        return
    }

    let previewViewController = ProfilePreviewViewController()
    previewViewController.nickname = nickname
    navigationController?.pushViewController(previewViewController, animated: true)
}
```

`ProfilePreviewViewController`의 `render()`입니다.

```swift
private func render() {
    nicknameLabel.text = nickname
}
```

첫 화면이 다음 화면을 생성하고 필요한 값을 주입합니다. `pushViewController`를 호출하면 새 화면이 내비게이션 스택 위에 추가되므로 기본 뒤로 가기 동작도 함께 제공됩니다.
