import ProjectDescription

let projectName = "Word"
let organizationName = "Coby"
let bundleID = "com.coby.Word"
let targetVersion = "17.0"
let version = "1.0.1"
let bundleVersion = "1"

let project = Project(
    name: projectName,
    organizationName: organizationName,
    settings: .settings(
        base: SettingsDictionary()
            .automaticCodeSigning(devTeam: "3Y8YH8GWMM")
            .swiftVersion("6.0"),
        configurations: [
            .debug(name: .debug),
            .release(name: .release)
        ]
    ),
    targets: [
        .target(
            name: projectName,
            destinations: [.iPhone],
            product: .app,
            bundleId: bundleID,
            deploymentTargets: .iOS(targetVersion),
            infoPlist: .extendingDefault(with: [
                "CFBundleShortVersionString": "\(version)",
                "CFBundleVersion": "\(bundleVersion)",
                "UIMainStoryboardFile": "",
                "UILaunchStoryboardName": "LaunchScreen",
                "CFBundleDisplayName": "단어백선생"
            ]),
            sources: ["\(projectName)/Sources/**"],
            resources: ["\(projectName)/Resources/**"],
            dependencies: [
                .external(name: "CobyDS"),
                .external(name: "ComposableArchitecture")
            ]
        )
    ],
    schemes: [
        .scheme(
            name: "\(projectName) Debug",
            buildAction: .buildAction(targets: ["\(projectName)"]),
            runAction: .runAction(configuration: .debug)
        ),
        .scheme(
            name: "\(projectName) Release",
            buildAction: .buildAction(targets: ["\(projectName)"]),
            runAction: .runAction(configuration: .release)
        )
    ]
)
