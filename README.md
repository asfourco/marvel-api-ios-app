# Marvel API iOS demo app

### Description
A demo app to interface with Marvel's API at developer.marvel.com. This app
will pull a list of comics and display a list of the comic's cover image and
its title. Clicking on a comic book within the list will display to the user 
the details of that particular comic book

### Build requirements

1. XCode 8
2. Swift 3
3. Marvel API (https://developer.marvel.com)
4. CocoaPods:
    1. Alamofire (https://cocoapods.org/pods/Alamofire) - HTTP networking library for API calls
    2. Gloss (https://cocoapods.org/pods/Gloss) - JSON data parsing to Swift object
    3. CryptoSwift (https://github.com/krzyzanowskim/CryptoSwift) - Swift Crypto related functions
    4. AlamofireImage (https://cocoapods.org/pods/AlamofireImage) - HTTP networking library for easy downloading of images asynchronously

### Runtime requirements 
iOS 9.0 or later

### How to build
1. Prepare API authentication
    1. Copy MarvelAPIDemo/apikeys_template.plist to MarvelAPIDemo/apikeys.plist
    2. Add your public and private keys to apikeys.plist

2.  Make sure the pods are up-to-date by running `pod update` at the root of the project directory

3.  Open MarvelAPIDemo.xcworkspace within Xcode to build, run, or test.

### Known issues
1. Response data from marvel for api GET /v1/public/comics returns inconsistent data that contains duplicates 


---
Copyright (C) 2016 - Fadi Asfour. All rights reserved
fadi@asfourconsulting


