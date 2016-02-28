# Spotify Login Demo
have an video in background 
##How to use
1.Add the JCVideoController to your project.

2.Create a view controller that inherits from JCVideoController

3.Must set videoURL before super.view.did
```swift
override func viewDidLoad() {
        self.url = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource("m", ofType: "mp4")!)
        
        super.viewDidLoad()

    }
```
4.you can addSubview in contendView
```
//        add loginBtn
        self.contentView.addSubview(loginBtn)
//        add signUpBtn
        self.contentView.addSubview(signUpBtn)
```
