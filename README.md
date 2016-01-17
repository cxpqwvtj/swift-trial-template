# swift-trial-template

Xcodeプラグインのセットアップ
- XcodeColors
- https://github.com/robbiehanson/XcodeColors
- cloneしてビルドすれば配置される。その後、Xcode再起動

gitignore設定

1. Xcodeからプロジェクト作成
1. iOS Application - Single View Application を選択
1. Product Name, Organization Name, Organization Identifier など必要に応じて入力
1. プロジェクト作成
1. Team(DevelopmentTeam)が設定されていれば、project.pbxproj から削除
1. Info.plist から Main Interface削除
1. メインターゲットのフォルダ内にClassesとResourcesフォルダ追加
1. swiftファイルをClasses内に。その他ファイルをResources内に
1. プロジェクトファイルで見つからないファイルを一旦削除
1. ClassesとResourcesフォルダをプロジェクトに追加。(Create groupsを選択)
1. Build Phases - Copy Bundle Resources からplistを削除
1. General - Choose Info.plist File... で Info.plist を選択

```Podfile
platform :ios, '9.1'
pod 'CocoaLumberjack/Swift', '~> 2.2'

use_frameworks!
```

```terminal
pod install
```

- Classesの下にModel,View,ViewControllerフォルダを追加
- ロガー設定
- AppDelegateで最初に起動するViewController切り替え
