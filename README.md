# Spotify Login Demo
have an video in background 
##How to use
1.Add the JCVideoController to your project.

2.Must set videoURL before super.view.did
```swift
override func viewDidLoad() {
        self.url = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource("m", ofType: "mp4")!)
        
        super.viewDidLoad()

    }
```

