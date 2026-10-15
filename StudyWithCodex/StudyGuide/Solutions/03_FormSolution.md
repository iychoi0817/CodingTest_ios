# 03 입력 폼 풀이

먼저 직접 풀어 본 뒤 확인하세요.

```swift
private func configureTextFields() {
    emailTextField.delegate = self
    passwordTextField.delegate = self
}

private func render() {
    let email = emailTextField.text ?? ""
    let password = passwordTextField.text ?? ""
    let isEmailValid = email.contains("@") && email.contains(".")
    let isPasswordValid = password.count >= 8
    let isFormValid = isEmailValid && isPasswordValid

    submitButton.isEnabled = isFormValid
    feedbackLabel.text = isFormValid
        ? "가입할 준비가 됐습니다."
        : "올바른 이메일과 8자 이상의 비밀번호를 입력하세요."
    feedbackLabel.textColor = isFormValid ? .systemGreen : .secondaryLabel
}

@objc private func didTapBackground() {
    view.endEditing(true)
}
```

Delegate 메서드는 다음과 같이 구현합니다.

```swift
func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField === emailTextField {
        passwordTextField.becomeFirstResponder()
    } else {
        textField.resignFirstResponder()
    }
    return true
}

func textFieldDidChangeSelection(_ textField: UITextField) {
    render()
}
```
