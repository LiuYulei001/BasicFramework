# BasicFramework 将持续更新！ 下载记得给个星啊！谢谢支持！

https://github.com/LiuYulei001/BasicFramework.git

BasicFramework是一个新工程基础框架，包含了日常积累的分类方法及工具，模块化清晰，基于Objective-C的ARC进行编写，意在解决新项目对于常见功能模块的重复开发，代码支持iOS7以后版本；

超小内存，绝无垃圾文件及无用集成，方便实用，轻量级框架！

模块简介
主项目中的分层主要包含四个模块，Main(主要)、Expand(扩展)、Resource(资源)、Vender(第三方)等；

Main(主要)模块的内容
此模块主要目的是为了存放项目的页面内容，比如MVC的内容模块的提取，方便继承调用；

Expand(扩展)模块的内容
此模块主要包含Const、Macros、Tool、NetWork、Category、DataBase六个子模块；

Macros(宏)主要存放宏定义的地方；

Tool(工具类)主要存放一些常用的工具类；

Network(网络)主要是根据需求对afnetworking进行二次封装；

Category(分类)主要用于存放平时要扩展的分类；

Resource(资源)模块的内容：
资源模块主要包含三方面，Global(全局)、Image(图片)、Plist(配置文件)；

Global用于存放项目一些全局的内容，包含启动项的内容LaunchScreen.storyboard、头部引用PrefixHeader.pch、语言包File.strings

Image用于存放图片资源，可以根据功能模块进行再分不同的xcassets文件；

Plist用于存放plist文件，统一存放方便管理；

