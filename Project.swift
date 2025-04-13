import ProjectDescription

let projectName = "Word"
let organizationName = "Coby"
let bundleID = "com.coby.Word"
let targetVersion = "17.0"
let version = "1.1.0"
let bundleVersion = "2"

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
                "CFBundleDisplayName": "단어백선생",
                "GADApplicationIdentifier": "ca-app-pub-1120202923997022~2317624263",
                "GADAdUnitID": "ca-app-pub-1120202923997022/2122183147"
            ]),
            sources: ["\(projectName)/Sources/**"],
            resources: ["\(projectName)/Resources/**"],
            dependencies: [
                .external(name: "CobyDS"),
                .external(name: "ComposableArchitecture"),
                .external(name: "GoogleMobileAds")
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
