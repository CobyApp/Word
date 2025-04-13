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
                "GADAdUnitID": "ca-app-pub-1120202923997022/2122183147",
                "SKAdNetworkItems": [
                    ["SKAdNetworkIdentifier": "cstr6suwn9.skadnetwork"],
                    ["SKAdNetworkIdentifier": "4fzdc2evr5.skadnetwork"],
                    ["SKAdNetworkIdentifier": "4pfyvq9l8r.skadnetwork"],
                    ["SKAdNetworkIdentifier": "2fnua5tdw4.skadnetwork"],
                    ["SKAdNetworkIdentifier": "ydx93a7ass.skadnetwork"],
                    ["SKAdNetworkIdentifier": "5a6flpkh64.skadnetwork"],
                    ["SKAdNetworkIdentifier": "p78ax468w3.skadnetwork"],
                    ["SKAdNetworkIdentifier": "v72qych5uu.skadnetwork"],
                    ["SKAdNetworkIdentifier": "ludvb6z3bs.skadnetwork"],
                    ["SKAdNetworkIdentifier": "cp8zw746q7.skadnetwork"],
                    ["SKAdNetworkIdentifier": "c6k4g5qg8m.skadnetwork"],
                    ["SKAdNetworkIdentifier": "s39g8k73mm.skadnetwork"],
                    ["SKAdNetworkIdentifier": "3qy4746246.skadnetwork"],
                    ["SKAdNetworkIdentifier": "3sh42y64q3.skadnetwork"],
                    ["SKAdNetworkIdentifier": "f38h382jlk.skadnetwork"],
                    ["SKAdNetworkIdentifier": "hs6bdukanm.skadnetwork"],
                    ["SKAdNetworkIdentifier": "prcb7njmu6.skadnetwork"],
                    ["SKAdNetworkIdentifier": "v4nxqhlyqp.skadnetwork"],
                    ["SKAdNetworkIdentifier": "wzmmz9fp6w.skadnetwork"],
                    ["SKAdNetworkIdentifier": "yclnxrl5pm.skadnetwork"],
                    ["SKAdNetworkIdentifier": "t38b2kh725.skadnetwork"],
                    ["SKAdNetworkIdentifier": "7ug5zh24hu.skadnetwork"],
                    ["SKAdNetworkIdentifier": "9rd848q2bz.skadnetwork"],
                    ["SKAdNetworkIdentifier": "y5ghdn5j9k.skadnetwork"],
                    ["SKAdNetworkIdentifier": "n6fk4nfna4.skadnetwork"],
                    ["SKAdNetworkIdentifier": "v9wttpbfk9.skadnetwork"],
                    ["SKAdNetworkIdentifier": "n38lu8286q.skadnetwork"],
                    ["SKAdNetworkIdentifier": "47vhws6wlr.skadnetwork"],
                    ["SKAdNetworkIdentifier": "kbd757ywx3.skadnetwork"],
                    ["SKAdNetworkIdentifier": "9t245vhmpl.skadnetwork"],
                    ["SKAdNetworkIdentifier": "a2p9lx4jpn.skadnetwork"],
                    ["SKAdNetworkIdentifier": "22mmun2rn5.skadnetwork"],
                    ["SKAdNetworkIdentifier": "4468km3ulz.skadnetwork"],
                    ["SKAdNetworkIdentifier": "2u9pt9hc89.skadnetwork"],
                    ["SKAdNetworkIdentifier": "8s468mfl3y.skadnetwork"],
                    ["SKAdNetworkIdentifier": "av6w8kgt66.skadnetwork"],
                    ["SKAdNetworkIdentifier": "klf5c3l5u5.skadnetwork"],
                    ["SKAdNetworkIdentifier": "pwa73g5rt2.skadnetwork"],
                    ["SKAdNetworkIdentifier": "4dzt52r2t5.skadnetwork"],
                    ["SKAdNetworkIdentifier": "gta9lk7p23.skadnetwork"],
                    ["SKAdNetworkIdentifier": "e5fvkxwrpn.skadnetwork"],
                    ["SKAdNetworkIdentifier": "uw77j35x4d.skadnetwork"],
                    ["SKAdNetworkIdentifier": "qqp299437r.skadnetwork"],
                    ["SKAdNetworkIdentifier": "275upjj5gd.skadnetwork"],
                    ["SKAdNetworkIdentifier": "wg4vff78zm.skadnetwork"],
                    ["SKAdNetworkIdentifier": "737z793b9f.skadnetwork"],
                    ["SKAdNetworkIdentifier": "r3f2yu3qye.skadnetwork"],
                    ["SKAdNetworkIdentifier": "mlmmfzh3r3.skadnetwork"],
                    ["SKAdNetworkIdentifier": "w9q455wk68.skadnetwork"],
                    ["SKAdNetworkIdentifier": "su67r6k2v3.skadnetwork"]
                ]
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