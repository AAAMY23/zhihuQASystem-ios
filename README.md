# zhihuQASystem-ios
设计目标：  
---------
前后端协作设计并实现一个类似知乎的问答系统，本部分是iOS端项目代码，目前项目已基本完成。  

项目内容：
--------
User Story 1  
√ 用户注册  
√ 用户登录  
√ 发布问题  
√ 查看问题列表  
√ 修改问题  
√ 删除问题  

User Story 2  
√ 修改个人中心  
√ 回答问题  
√ 修改回答  
√ 删除回答  

User Story 3  
√ 热门问题列表  
√ 对回答点赞和踩  
√ 个人中心查看自己已发布的问题  
√ 个人中心查看自己的回答  

项目要点:  
--------
1、本项目整体采用MVC架构  
2、利用cocoapods进行第三方库的下载与管理  
3、利用afnetworking进行网络请求  
4、利用sdweblmage进行网络图片加载  
5、利用mbprogresshud优化等待动画,提升用户体验  
6、利用nsuserdefauts进行用户信息以及token的缓存  
7、前期利用mock进行服务端数据模拟,接口调试通过后,从服务端获取实际数据并展示，所以在涉及到网络请求的部分会看到有注释掉的mock地址。  

运行方法：  
----------
打包下载文档，在macbook上下载xcode最新版（注：旧版有些功能不能正常运行），使用iphone12模拟机即可运行。  
![image](https://user-images.githubusercontent.com/72694307/124938483-e9319d80-e03a-11eb-9a03-0a92bbae9549.png)

