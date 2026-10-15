import Foundation

struct LearningStage {
    let level: Level
    let lessons: [Lesson]

    enum Level {
        case basic
        case intermediate
        case advanced
        case codingTest

        var title: String {
            switch self {
            case .basic: "기초"
            case .intermediate: "중급"
            case .advanced: "심화"
            case .codingTest: "코딩테스트"
            }
        }

        var subtitle: String {
            switch self {
            case .basic: "UIKit의 뼈대 익히기"
            case .intermediate: "데이터와 화면 연결하기"
            case .advanced: "확장 가능한 앱 설계하기"
            case .codingTest: "Swift로 알고리즘 연습하기"
            }
        }
    }
}

struct Lesson {
    let number: Int
    let title: String
    let summary: String
    let symbolName: String
    let isUnlocked: Bool
    let isCompleted: Bool
}

enum LearningRoadmap {
    static let stages: [LearningStage] = [
        LearningStage(
            level: .basic,
            lessons: [
                Lesson(number: 1, title: "카운터 만들기", summary: "View · Auto Layout · Target/Action", symbolName: "plus.forwardslash.minus", isUnlocked: true, isCompleted: true),
                Lesson(number: 2, title: "화면 이동", summary: "NavigationController · 데이터 전달", symbolName: "arrow.right.square", isUnlocked: true, isCompleted: true),
                Lesson(number: 3, title: "입력 폼", summary: "TextField · Delegate · Keyboard", symbolName: "rectangle.and.pencil.and.ellipsis", isUnlocked: true, isCompleted: false)
            ]
        ),
        LearningStage(
            level: .intermediate,
            lessons: [
                Lesson(number: 4, title: "할 일 목록", summary: "TableView · Cell 재사용", symbolName: "checklist", isUnlocked: false, isCompleted: false),
                Lesson(number: 5, title: "사진 그리드", summary: "CollectionView · Diffable Data Source", symbolName: "square.grid.2x2", isUnlocked: false, isCompleted: false),
                Lesson(number: 6, title: "날씨 불러오기", summary: "URLSession · Codable · async/await", symbolName: "cloud.sun", isUnlocked: false, isCompleted: false)
            ]
        ),
        LearningStage(
            level: .advanced,
            lessons: [
                Lesson(number: 7, title: "화면 구조 분리", summary: "MVVM · 의존성 주입", symbolName: "square.3.layers.3d", isUnlocked: false, isCompleted: false),
                Lesson(number: 8, title: "데이터 저장", summary: "Repository · Cache · Persistence", symbolName: "externaldrive", isUnlocked: false, isCompleted: false),
                Lesson(number: 9, title: "테스트 가능한 앱", summary: "Unit Test · UI Test · Mock", symbolName: "checkmark.seal", isUnlocked: false, isCompleted: false)
            ]
        ),
        LearningStage(
            level: .codingTest,
            lessons: [
                Lesson(number: 10, title: "연속 중복 숫자 제거", summary: "입문 · 배열 · 반복문 · O(n)", symbolName: "chevron.left.forwardslash.chevron.right", isUnlocked: true, isCompleted: true),
                Lesson(number: 11, title: "올바른 괄호", summary: "기초 · 문자열 · 스택 · O(n)", symbolName: "parentheses", isUnlocked: true, isCompleted: true),
                Lesson(number: 12, title: "두 수의 합", summary: "기초 · 배열 · 딕셔너리 · O(n)", symbolName: "sum", isUnlocked: true, isCompleted: false),
                Lesson(number: 13, title: "최대 연속 부분합", summary: "기초 · 배열 · 상태 갱신 · O(n)", symbolName: "chart.line.uptrend.xyaxis", isUnlocked: true, isCompleted: false)
            ]
        )
    ]
}
