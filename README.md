# KBLibrary

注意事项：
1.iOS采用cocoapods管理该库后Xcode编译可能会报错：'sharedApplication' is unavailable: not available on iOS (App Extension) - Use view controller based solutions where appropriate instead。请找到Pods->KBLibrary->Build Settings->Require Only App-Extension-Safe API，将该bool值改为No，再次编译即可。
