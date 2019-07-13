# TheStories

Welcome to my assignment test. This assignment will be creating app likes a Pinterest Layout but with a much smaller feature set. In this assignment, the developer is using [VIPER](https://www.objc.io/issues/13-architecture/viper/)  architecture which is based on uncle bob's [clean architecture](http://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html))

## File Organization
To organize groups, files and code into more specifically.I use this structure as below:
- `Classes` - contains of application-related (classes).
- `Services` - contains web service processes.
- `Components` - contains part of object that can be reused.
- `Constants` - contains static constant.
- `Extensions` - contains iOS framework to customize framework.
- `View` - contains controller (Xib)
- `Presenter` - contains presenter of each view that manages event to communicate into router and interactor.
- `Entity` - contains entities that app using.
- `Router` - contains application routing.

## Built with
Using `Xcode 10.2` and written with `Swift 5`.

## Development Process
Use  `sh resetpods.sh`  in terminal to run and update xcode package.

# Dependencies
Using `Cocoapods` with version  `1.6.1` for manage dependencies. This project are use:
- `Alamofire` used to networking.

## Credit
Created by [William](https://www.linkedin.com/in/william-b90619b7)
