# StudyWithCodex UIKit Lab

UIKit을 작은 문제로 반복 학습하는 프로젝트입니다. 앱을 실행하고 열린 단계부터 직접 구현합니다.

## 학습 순서

1. 기초: View, Auto Layout, 화면 이동, Delegate
2. 중급: Table/Collection View, 네트워크, 비동기 처리
3. 심화: MVVM, Repository, 테스트와 의존성 주입

각 문제는 두 가지 관점으로 풉니다.

- UI 설계: 어떤 UIKit 컴포넌트를 쓰고 어떻게 배치할지 결정합니다.
- 로직 설계: 상태, 사용자 행동, 화면 갱신의 책임을 나눕니다.

## 문제 풀기

앱에서 `01. 카운터 만들기`를 선택한 뒤 아래 파일의 `TODO 1`부터 순서대로 해결하세요.

`StudyWithCodex/Features/Challenge/CounterChallengeViewController.swift`

막히면 화면 오른쪽 위 전구 버튼을 누르고, 그래도 어려우면 `StudyGuide/Solutions/01_CounterSolution.md`를 확인합니다.

1단계를 완료하면 `02. 화면 이동`이 열립니다. 아래 두 파일의 `TODO`를 순서대로 해결하세요.

- `StudyWithCodex/Features/Challenge/NavigationChallengeViewController.swift`
- `StudyWithCodex/Features/Challenge/ProfilePreviewViewController.swift`

2단계 풀이는 `StudyGuide/Solutions/02_NavigationSolution.md`에 있습니다.

2단계를 완료하면 `03. 입력 폼`이 열립니다. `FormChallengeViewController.swift`에서 Delegate, 키보드, 입력 검증 관련 `TODO`를 해결하세요. 풀이는 `StudyGuide/Solutions/03_FormSolution.md`에서 확인할 수 있습니다.

## 코딩테스트

학습 목록 맨 아래의 `코딩테스트`에서 첫 문제 `연속 중복 숫자 제거`를 선택하세요. UIKit 학습 진행과 관계없이 바로 시작할 수 있습니다.

`StudyWithCodex/Features/CodingTest/RemoveConsecutiveDuplicates.swift`의 `solve(_:)` TODO를 완성한 뒤 앱을 다시 실행하세요. 문제 화면의 `풀이 확인` 버튼으로 예제, 빈 배열, 단일 원소, 모두 같은 숫자 등 6개 테스트의 기대값과 실제 결과를 확인할 수 있습니다. 전구 버튼으로 힌트를 볼 수 있습니다.

두 번째 문제 `올바른 괄호`에서는 `()`, `[]`, `{}`의 짝과 닫히는 순서를 검사합니다. `StudyWithCodex/Features/CodingTest/ValidBrackets.swift`의 TODO를 완성하세요. 문제 화면에서 힌트와 빈 문자열, 중첩 괄호, 잘못된 순서 등 10개 테스트를 확인할 수 있습니다.

세 번째 문제 `두 수의 합`에서는 합이 목표값인 서로 다른 두 원소의 인덱스를 찾습니다. `StudyWithCodex/Features/CodingTest/TwoSum.swift`의 TODO를 완성하세요. 정답 쌍은 최대 하나이며 인덱스를 오름차순으로 반환합니다. 문제 화면에 중복 숫자, 음수, 정답이 없는 경우 등 10개 테스트와 힌트가 있습니다.

네 번째 문제 `최대 연속 부분합`에서는 연속된 원소를 하나 이상 선택했을 때의 최대 합을 구합니다. `StudyWithCodex/Features/CodingTest/MaximumSubarray.swift`의 TODO를 완성하세요. 입력은 비어 있지 않으며, 모든 숫자가 음수인 경우도 처리해야 합니다. 목표는 시간 O(n), 추가 공간 O(1)입니다. 문제 화면에 테스트 10개와 힌트가 있습니다.
