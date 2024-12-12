import ProjectDescription

let projectName = "Word"
let organizationName = "Coby"
let bundleID = "com.coby.Word"
let targetVersion = "17.0"
let version = "1.0.0"
let bundleVersion = "0"

// MARK: Struct
let project = Project(
    name: projectName,
    organizationName: organizationName,
    settings: .settings(
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
            infoPlist: createInfoPlist(),
            sources: ["\(projectName)/Sources/**"],
            resources: ["\(projectName)/Resources/**"],
            dependencies: defaultDependencies()
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

private func createInfoPlist() -> InfoPlist {
    let plist: [String: Plist.Value] = [
        "CFBundleShortVersionString": "\(version)",
        "CFBundleVersion": "\(bundleVersion)",
        "UIMainStoryboardFile": "",
        "UILaunchStoryboardName": "LaunchScreen"
    ]
    return .extendingDefault(with: plist)
}

private func defaultDependencies() -> [TargetDependency] {
    [
        .external(name: "CobyDS"),
        .external(name: "ComposableArchitecture")
    ]
}
