# 01 카운터 풀이

먼저 직접 풀어 본 뒤 확인하세요.

```swift
private var count = 0

@objc private func didTapMinus() {
    count -= 1
    render()
}

@objc private func didTapPlus() {
    count += 1
    render()
}

@objc private func didTapReset() {
    count = 0
    render()
}

private func render() {
    countLabel.text = String(count)
    minusButton.isEnabled = count > -10
    plusButton.isEnabled = count < 10
}
```

버튼 메서드는 상태만 변경하고, 화면 표시는 `render()`가 전담합니다. 같은 UI 갱신 코드를 반복하지 않으며 상태와 화면의 관계를 한 곳에서 확인할 수 있습니다.
