import ProjectDescription

// MARK: - Basic Targets

let baseSettings: Settings = .settings(
    base: [
        "SWIFT_STRICT_CONCURRENCY": "complete",
        "SWIFT_VERSION": "6.0",
        "MARKETING_VERSION": "0.0.1",
        "CURRENT_PROJECT_VERSION": "1"
    ],
    defaultSettings: .recommended
)

// MARK: - Feature Targets

let foundationTerminalSharedTarget: ProjectDescription.Target = .target(
    name: "FoundationTerminalShared",
    destinations: .iOS,
    product: .staticLibrary,
    bundleId: "eu.rikidar.foundation-terminal-shared",
    sources: [
        "Modules/Shared/**/*.swift"
    ],
    dependencies: [
        .external(name: "Defaults")
    ]
)

let foundationTerminalHTMLLogicTarget: ProjectDescription.Target = .target(
    name: "FoundationTerminalHTMLLogic",
    destinations: .iOS,
    product: .staticLibrary,
    bundleId: "eu.rikidar.foundation-terminal-html",
    sources: [
        "Modules/HTML Logic/**/*.swift"
    ],
    dependencies: [
        .target(foundationTerminalSharedTarget),
        .external(name: "SwiftHTMLParser")
    ]
)

// MARK: - Main Target
let foundationTerminalTarget: ProjectDescription.Target = .target(
    name: "Foundation Terminal",
    destinations: .iOS,
    product: .app,
    bundleId: "eu.rikidar.foundation-terminal",
    infoPlist: .extendingDefault(
        with: [
            "UILaunchScreen": [
                "UIColorName": "",
                "UIImageName": "",
            ],
        ]
    ),
    sources: ["Foundation Terminal/Sources/**"],
    resources: [
        "Foundation Terminal/Resources/**",
        "Foundation Terminal/**/*.xcassets",
        "Foundation Terminal/**/*.xcstrings",
        "PrivacyInfo.xcprivacy",
    ],
    dependencies: [
        .external(name: "Defaults"),
        .external(name: "ButtonKit"),
        .target(foundationTerminalSharedTarget),
        .target(foundationTerminalHTMLLogicTarget)
    ],
    settings: baseSettings
)

let foundationTerminalTestsTarget: ProjectDescription.Target = .target(
    name: "FoundationTerminalTests",
    destinations: .iOS,
    product: .unitTests,
    bundleId: "eu.rikidar.foundation-terminal.Tests",
    infoPlist: .default,
    sources: ["Foundation Terminal/Tests/**"],
    resources: [],
    dependencies: [.target(name: "Foundation Terminal")]
)

let project = Project(
    name: "Foundation Terminal",
    targets: [
        foundationTerminalTarget,
        foundationTerminalSharedTarget,
        foundationTerminalHTMLLogicTarget,
        foundationTerminalTestsTarget
    ]
)
