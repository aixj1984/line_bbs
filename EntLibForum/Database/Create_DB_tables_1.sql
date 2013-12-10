CREATE DATABASE EntLib_BBS
GO

USE EntLib_BBS
GO


 if exists (select * from sysobjects where id = OBJECT_ID('[yaf_AccessMask]') and OBJECTPROPERTY(id, 'IsUserTable') = 1) DROP TABLE [yaf_AccessMask] 
 CREATE TABLE [yaf_AccessMask] (  [AccessMaskID] [int] IDENTITY (1, 1) NOT NULL ,  [BoardID] [int] NOT NULL , [Name] [nvarchar] (50) NOT NULL ,  [Flags] [int] NOT NULL )
 ALTER TABLE [yaf_AccessMask] WITH NOCHECK ADD CONSTRAINT [DF_yaf_AccessMask_Flags] DEFAULT ((0)) FOR [Flags],CONSTRAINT [PK_yaf_AccessMask] PRIMARY KEY  NONCLUSTERED ( [AccessMaskID] )

 SET IDENTITY_INSERT [yaf_AccessMask] ON

 INSERT [yaf_AccessMask] ( [AccessMaskID] , [BoardID] , [Name] , [Flags] ) VALUES ( 1 , 1 , 'Admin Access Mask' , 1023 )
 INSERT [yaf_AccessMask] ( [AccessMaskID] , [BoardID] , [Name] , [Flags] ) VALUES ( 2 , 1 , 'Moderator Access Mask' , 487 )
 INSERT [yaf_AccessMask] ( [AccessMaskID] , [BoardID] , [Name] , [Flags] ) VALUES ( 3 , 1 , 'Member Access Mask' , 167 )
 INSERT [yaf_AccessMask] ( [AccessMaskID] , [BoardID] , [Name] , [Flags] ) VALUES ( 4 , 1 , 'Read Only Access Mask' , 1 )
 INSERT [yaf_AccessMask] ( [AccessMaskID] , [BoardID] , [Name] , [Flags] ) VALUES ( 17 , 1 , '没有访问权限组' , 0 )

 SET IDENTITY_INSERT [yaf_AccessMask] OFF

 if exists (select * from sysobjects where id = OBJECT_ID('[yaf_Active]') and OBJECTPROPERTY(id, 'IsUserTable') = 1) DROP TABLE [yaf_Active] 
 CREATE TABLE [yaf_Active] ( [SessionID] [nvarchar] (24) NOT NULL ,  [BoardID] [int] NOT NULL ,  [UserID] [int] NOT NULL , [IP] [nvarchar] (15) NOT NULL , [Login] [datetime]  NOT NULL , [LastActive] [datetime]  NOT NULL , [Location] [nvarchar] (50) NOT NULL ,  [ForumID] [int] NULL ,  [TopicID] [int] NULL , [Browser] [nvarchar] (50) NULL , [Platform] [nvarchar] (50) NULL )
 ALTER TABLE [yaf_Active] WITH NOCHECK ADD CONSTRAINT [PK_yaf_Active] 
 PRIMARY KEY  CLUSTERED ( [SessionID], BoardID ) 

 INSERT [yaf_Active] ( [SessionID] , [BoardID] , [UserID] , [IP] , [Login] , [LastActive] , [Location] , [Browser] , [Platform] ) VALUES ( '3g5yy555xiahufvk4ssfpm5' , 1 , 2 , '127.0.0.1' , '2009-11-25 16:34:35.060' , '2009-11-25 17:05:42.113' , '/default.aspx' , 'IE 8.0' , 'WinNT' )

 if exists (select * from sysobjects where id = OBJECT_ID('[yaf_Attachment]') and OBJECTPROPERTY(id, 'IsUserTable') = 1) DROP TABLE [yaf_Attachment] 
 CREATE TABLE [yaf_Attachment] (  [AttachmentID] [int] IDENTITY (1, 1) NOT NULL ,  [MessageID] [int] NOT NULL , [FileName] [nvarchar] (250) NOT NULL ,  [Bytes] [int] NOT NULL ,  [FileID] [int] NULL , [ContentType] [nvarchar] (50) NULL ,  [Downloads] [int] NOT NULL , [FileData] [image] NULL )
 ALTER TABLE [yaf_Attachment] WITH NOCHECK ADD CONSTRAINT [PK_yaf_Attachment] PRIMARY KEY  NONCLUSTERED ( [AttachmentID] )

 SET IDENTITY_INSERT [yaf_Attachment] ON

 INSERT [yaf_Attachment] ( [AttachmentID] , [MessageID] , [FileName] , [Bytes] , [ContentType] , [Downloads] ) VALUES ( 11 , 56 , 'attachment.gif' , 97 , 'image/gif' , 25 )
 INSERT [yaf_Attachment] ( [AttachmentID] , [MessageID] , [FileName] , [Bytes] , [ContentType] , [Downloads] ) VALUES ( 12 , 56 , 'EntLibcom_Forum_v3.0.gif' , 43384 , 'image/gif' , 24 )
 INSERT [yaf_Attachment] ( [AttachmentID] , [MessageID] , [FileName] , [Bytes] , [ContentType] , [Downloads] ) VALUES ( 15 , 57 , 'agree.gif' , 1034 , 'image/gif' , 7 )

 SET IDENTITY_INSERT [yaf_Attachment] OFF

 if exists (select * from sysobjects where id = OBJECT_ID('[yaf_BannedIP]') and OBJECTPROPERTY(id, 'IsUserTable') = 1) DROP TABLE [yaf_BannedIP] 
 CREATE TABLE [yaf_BannedIP] (  [ID] [int] IDENTITY (1, 1) NOT NULL ,  [BoardID] [int] NOT NULL , [Mask] [nvarchar] (15) NOT NULL , [Since] [datetime]  NOT NULL )
 ALTER TABLE [yaf_BannedIP] WITH NOCHECK ADD CONSTRAINT [PK_yaf_BannedIP] PRIMARY KEY  NONCLUSTERED ( [ID] )
 CREATE UNIQUE INDEX [IX_yaf_BannedIP] ON [yaf_BannedIP] ( BoardID, Mask ) 

 SET IDENTITY_INSERT [yaf_BannedIP] ON

 INSERT [yaf_BannedIP] ( [ID] , [BoardID] , [Mask] , [Since] ) VALUES ( 1 , 1 , '192.168.1.111' , '2008-09-09 20:47:27.357' )

 SET IDENTITY_INSERT [yaf_BannedIP] OFF

 if exists (select * from sysobjects where id = OBJECT_ID('[yaf_Board]') and OBJECTPROPERTY(id, 'IsUserTable') = 1) DROP TABLE [yaf_Board] 
 CREATE TABLE [yaf_Board] (  [BoardID] [int] IDENTITY (1, 1) NOT NULL , [Name] [nvarchar] (50) NOT NULL , [AllowThreaded] [bit] NOT NULL )
 ALTER TABLE [yaf_Board] WITH NOCHECK ADD CONSTRAINT [PK_yaf_Board] PRIMARY KEY  NONCLUSTERED ( [BoardID] )

 SET IDENTITY_INSERT [yaf_Board] ON

 INSERT [yaf_Board] ( [BoardID] , [Name] , [AllowThreaded] ) VALUES ( 1 , 'EntLib.com 开源ASP.NET论坛' , 0 )

 SET IDENTITY_INSERT [yaf_Board] OFF

 if exists (select * from sysobjects where id = OBJECT_ID('[yaf_Category]') and OBJECTPROPERTY(id, 'IsUserTable') = 1) DROP TABLE [yaf_Category] 
 CREATE TABLE [yaf_Category] (  [CategoryID] [int] IDENTITY (1, 1) NOT NULL ,  [BoardID] [int] NOT NULL , [Name] [nvarchar] (128) NOT NULL , [SortOrder] [smallint] NOT NULL , [IconName] [nvarchar] (128) NOT NULL )
 ALTER TABLE [yaf_Category] WITH NOCHECK ADD CONSTRAINT [PK_yaf_Category] PRIMARY KEY  NONCLUSTERED ( [CategoryID] )
 CREATE UNIQUE INDEX [IX_yaf_Category] ON [yaf_Category] ( BoardID , Name ) 

 SET IDENTITY_INSERT [yaf_Category] ON

 INSERT [yaf_Category] ( [CategoryID] , [BoardID] , [Name] , [SortOrder] , [IconName] ) VALUES ( 1 , 1 , 'EntLib.com专业的电子商务系统' , 1 ,  '产业专区.gif')
 INSERT [yaf_Category] ( [CategoryID] , [BoardID] , [Name] , [SortOrder] , [IconName] ) VALUES ( 6 , 1 , 'Enterprise Library 微软企业类库' , 2 ,  '产业专区.gif')
 INSERT [yaf_Category] ( [CategoryID] , [BoardID] , [Name] , [SortOrder] , [IconName] ) VALUES ( 7 , 1 , '其他开源项目' , 3 ,  '产业专区.gif')

 SET IDENTITY_INSERT [yaf_Category] OFF

 if exists (select * from sysobjects where id = OBJECT_ID('[yaf_CheckEmail]') and OBJECTPROPERTY(id, 'IsUserTable') = 1) DROP TABLE [yaf_CheckEmail] 
 CREATE TABLE [yaf_CheckEmail] (  [CheckEmailID] [int] IDENTITY (1, 1) NOT NULL ,  [UserID] [int] NOT NULL , [Email] [nvarchar] (50) NOT NULL , [Created] [datetime]  NOT NULL , [Hash] [nvarchar] (32) NOT NULL )
 ALTER TABLE [yaf_CheckEmail] WITH NOCHECK ADD CONSTRAINT [PK_yaf_CheckEmail] PRIMARY KEY  NONCLUSTERED ( [CheckEmailID] )
 CREATE UNIQUE INDEX [IX_yaf_CheckEmail] ON [yaf_CheckEmail] ( Hash ) 

 if exists (select * from sysobjects where id = OBJECT_ID('[yaf_Choice]') and OBJECTPROPERTY(id, 'IsUserTable') = 1) DROP TABLE [yaf_Choice] 
 CREATE TABLE [yaf_Choice] (  [ChoiceID] [int] IDENTITY (1, 1) NOT NULL ,  [PollID] [int] NOT NULL , [Choice] [nvarchar] (50) NOT NULL ,  [Votes] [int] NOT NULL )
 ALTER TABLE [yaf_Choice] WITH NOCHECK ADD CONSTRAINT [PK_yaf_Choice] PRIMARY KEY  NONCLUSTERED ( [ChoiceID] )

 if exists (select * from sysobjects where id = OBJECT_ID('[yaf_EventLog]') and OBJECTPROPERTY(id, 'IsUserTable') = 1) DROP TABLE [yaf_EventLog] 
 CREATE TABLE [yaf_EventLog] (  [EventLogID] [int] IDENTITY (1, 1) NOT NULL , [EventTime] [datetime]  NOT NULL ,  [UserID] [int] NULL , [Source] [nvarchar] (50) NOT NULL , [Description] [ntext] NOT NULL ,  [TYPE] [int] NOT NULL )
 ALTER TABLE [yaf_EventLog] WITH NOCHECK ADD CONSTRAINT [DF_yaf_EventLog_EventTime] DEFAULT (getdate()) FOR [EventTime],CONSTRAINT [DF_yaf_EventLog_TYPE] DEFAULT ((0)) FOR [TYPE],CONSTRAINT [PK_yaf_EventLog] PRIMARY KEY  NONCLUSTERED ( [EventLogID] )

 if exists (select * from sysobjects where id = OBJECT_ID('[yaf_Forum]') and OBJECTPROPERTY(id, 'IsUserTable') = 1) DROP TABLE [yaf_Forum] 
 CREATE TABLE [yaf_Forum] (  [ForumID] [int] IDENTITY (1, 1) NOT NULL ,  [CategoryID] [int] NOT NULL ,  [ParentID] [int] NULL , [Name] [nvarchar] (128) NOT NULL , [Description] [nvarchar] (255) NOT NULL , [SortOrder] [smallint] NOT NULL , [LastPosted] [datetime]  NULL ,  [LastTopicID] [int] NULL ,  [LastMessageID] [int] NULL ,  [LastUserID] [int] NULL , [LastUserName] [nvarchar] (50) NULL ,  [NumTopics] [int] NOT NULL ,  [NumPosts] [int] NOT NULL , [RemoteURL] [nvarchar] (100) NULL ,  [Flags] [int] NOT NULL , [ThemeURL] [nvarchar] (50) NULL , [ForumIcon] [nvarchar] (100) NULL )
 ALTER TABLE [yaf_Forum] WITH NOCHECK ADD CONSTRAINT [DF_yaf_Forum_Flags] DEFAULT ((0)) FOR [Flags],CONSTRAINT [PK_yaf_Forum] PRIMARY KEY  NONCLUSTERED ( [ForumID] )
 CREATE UNIQUE INDEX [IX_yaf_Forum] ON [yaf_Forum] ( CategoryID , Name ) 

 SET IDENTITY_INSERT [yaf_Forum] ON

 INSERT [yaf_Forum] ( [ForumID] , [CategoryID] , [Name] , [Description] , [SortOrder] , [LastPosted] , [LastTopicID] , [LastMessageID] , [LastUserID] , [NumTopics] , [NumPosts] , [Flags] , [ForumIcon] ) VALUES ( 1 , 1 , '软件系统发布' , '最新的程序、系统及补丁发布信息，欢迎下载和讨论。' , 1 , '2009-11-25 17:05:35.363' , 45 , 139 , 2 , 2 , 28 , 0 , 'icon_ecommerce_633947587873537816.gif' )
 INSERT [yaf_Forum] ( [ForumID] , [CategoryID] , [Name] , [Description] , [SortOrder] , [LastPosted] , [LastTopicID] , [LastMessageID] , [LastUserID] , [NumTopics] , [NumPosts] , [Flags] , [ForumIcon] ) VALUES ( 7 , 1 , 'EntLib安装使用' , 'EntLib电子商务系统安装使用升级的方法、问题讨论区' , 2 , '2008-09-08 22:53:46.933' , 25 , 120 , 2 , 1 , 6 , 0 , 'icon_entlibhelp_633947587659425570.gif' )
 INSERT [yaf_Forum] ( [ForumID] , [CategoryID] , [Name] , [Description] , [SortOrder] , [LastPosted] , [LastTopicID] , [LastMessageID] , [LastUserID] , [NumTopics] , [NumPosts] , [Flags] , [ForumIcon] ) VALUES ( 8 , 6 , 'Enterprise Library 技术交流' , '学习、交流、分享微软企业类库。' , 1 , '2009-11-25 16:56:47.650' , 46 , 138 , 2 , 1 , 1 , 0 , 'icon_enterpriselibrary_633947587083382622.gif' )
 INSERT [yaf_Forum] ( [ForumID] , [CategoryID] , [Name] , [Description] , [SortOrder] , [LastPosted] , [LastTopicID] , [LastMessageID] , [LastUserID] , [NumTopics] , [NumPosts] , [Flags] , [ForumIcon] ) VALUES ( 9 , 7 , 'EntLib.com Forum 论坛系统' , '针对YetAnotherForum开源论坛系统分析、中文化、定制化功能开发和分享。' , 1 , '2009-11-25 16:38:22.990' , 44 , 136 , 2 , 3 , 5 , 0 , 'icon_EntLibForumLogo_633947586944184660.gif' )

 SET IDENTITY_INSERT [yaf_Forum] OFF

 if exists (select * from sysobjects where id = OBJECT_ID('[yaf_ForumAccess]') and OBJECTPROPERTY(id, 'IsUserTable') = 1) DROP TABLE [yaf_ForumAccess] 
 CREATE TABLE [yaf_ForumAccess] (  [GroupID] [int] NOT NULL ,  [ForumID] [int] NOT NULL ,  [AccessMaskID] [int] NOT NULL )
 ALTER TABLE [yaf_ForumAccess] WITH NOCHECK ADD CONSTRAINT [PK_yaf_ForumAccess] 
 PRIMARY KEY CLUSTERED ( [GroupID], ForumID ) 

 INSERT [yaf_ForumAccess] ( [GroupID] , [ForumID] , [AccessMaskID] ) VALUES ( 1 , 1 , 1 )
 INSERT [yaf_ForumAccess] ( [GroupID] , [ForumID] , [AccessMaskID] ) VALUES ( 1 , 7 , 1 )
 INSERT [yaf_ForumAccess] ( [GroupID] , [ForumID] , [AccessMaskID] ) VALUES ( 1 , 8 , 1 )
 INSERT [yaf_ForumAccess] ( [GroupID] , [ForumID] , [AccessMaskID] ) VALUES ( 1 , 9 , 1 )
 INSERT [yaf_ForumAccess] ( [GroupID] , [ForumID] , [AccessMaskID] ) VALUES ( 2 , 1 , 4 )
 INSERT [yaf_ForumAccess] ( [GroupID] , [ForumID] , [AccessMaskID] ) VALUES ( 2 , 7 , 4 )
 INSERT [yaf_ForumAccess] ( [GroupID] , [ForumID] , [AccessMaskID] ) VALUES ( 2 , 8 , 4 )
 INSERT [yaf_ForumAccess] ( [GroupID] , [ForumID] , [AccessMaskID] ) VALUES ( 2 , 9 , 17 )
 INSERT [yaf_ForumAccess] ( [GroupID] , [ForumID] , [AccessMaskID] ) VALUES ( 3 , 1 , 3 )
 INSERT [yaf_ForumAccess] ( [GroupID] , [ForumID] , [AccessMaskID] ) VALUES ( 3 , 7 , 3 )
 INSERT [yaf_ForumAccess] ( [GroupID] , [ForumID] , [AccessMaskID] ) VALUES ( 3 , 8 , 3 )
 INSERT [yaf_ForumAccess] ( [GroupID] , [ForumID] , [AccessMaskID] ) VALUES ( 3 , 9 , 3 )

 if exists (select * from sysobjects where id = OBJECT_ID('[yaf_Group]') and OBJECTPROPERTY(id, 'IsUserTable') = 1) DROP TABLE [yaf_Group] 
 CREATE TABLE [yaf_Group] (  [GroupID] [int] IDENTITY (1, 1) NOT NULL ,  [BoardID] [int] NOT NULL , [Name] [nvarchar] (50) NOT NULL ,  [Flags] [int] NOT NULL )
 ALTER TABLE [yaf_Group] WITH NOCHECK ADD CONSTRAINT [DF_yaf_Group_Flags] DEFAULT ((0)) FOR [Flags],CONSTRAINT [PK_yaf_Group] PRIMARY KEY  NONCLUSTERED ( [GroupID] )
 CREATE UNIQUE INDEX [IX_yaf_Group] ON [yaf_Group] ( BoardID ,Name ) 

 SET IDENTITY_INSERT [yaf_Group] ON

 INSERT [yaf_Group] ( [GroupID] , [BoardID] , [Name] , [Flags] ) VALUES ( 1 , 1 , 'Administration' , 1 )
 INSERT [yaf_Group] ( [GroupID] , [BoardID] , [Name] , [Flags] ) VALUES ( 2 , 1 , 'Guest' , 2 )
 INSERT [yaf_Group] ( [GroupID] , [BoardID] , [Name] , [Flags] ) VALUES ( 3 , 1 , 'Member' , 4 )

 SET IDENTITY_INSERT [yaf_Group] OFF

 if exists (select * from sysobjects where id = OBJECT_ID('[yaf_Mail]') and OBJECTPROPERTY(id, 'IsUserTable') = 1) DROP TABLE [yaf_Mail] 
 CREATE TABLE [yaf_Mail] (  [MailID] [int] IDENTITY (1, 1) NOT NULL , [FromUser] [nvarchar] (50) NOT NULL , [ToUser] [nvarchar] (50) NOT NULL , [Created] [datetime]  NOT NULL , [Subject] [nvarchar] (256) NOT NULL , [Body] [ntext] NOT NULL )
 ALTER TABLE [yaf_Mail] WITH NOCHECK ADD CONSTRAINT [PK_yaf_Mail] PRIMARY KEY  NONCLUSTERED ( [MailID] )

 if exists (select * from sysobjects where id = OBJECT_ID('[yaf_Message]') and OBJECTPROPERTY(id, 'IsUserTable') = 1) DROP TABLE [yaf_Message] 
 CREATE TABLE [yaf_Message] (  [MessageID] [int] IDENTITY (1, 1) NOT NULL ,  [TopicID] [int] NOT NULL ,  [ReplyTo] [int] NULL ,  [Position] [int] NOT NULL ,  [Indent] [int] NOT NULL ,  [UserID] [int] NOT NULL , [UserName] [nvarchar] (50) NULL , [Posted] [datetime]  NOT NULL , [Message] [ntext] NOT NULL , [IP] [nvarchar] (15) NOT NULL , [Edited] [datetime]  NULL ,  [Flags] [int] NOT NULL )
 ALTER TABLE [yaf_Message] WITH NOCHECK ADD CONSTRAINT [DF_yaf_Message_Flags] DEFAULT ((23)) FOR [Flags],CONSTRAINT [PK_yaf_Message] PRIMARY KEY  NONCLUSTERED ( [MessageID] )

 SET IDENTITY_INSERT [yaf_Message] ON

 INSERT [yaf_Message] ( [MessageID] , [TopicID] , [Position] , [Indent] , [UserID] , [Posted] , [Message] , [IP] , [Edited] , [Flags] ) VALUES ( 56 , 19 , 0 , 0 , 2 , '2008-05-09 23:36:07.280' , '[b]Web Server 监视器 [/b]
 
Web Server监视器用来对Web Server进行自动监控和异常提醒。
当前版本：v1.0
运行环境：.Net Framework 2.0/3.0/3.5 
 
[b]Web Server Monitor主要功能：[/b] 
 
（1）多线程监控Web Server，返回Web Server的页面，并在浏览器中显示页面效果和HTML代码。
（2）多线程监控Web Server，返回并显示HTML，同时比较HTML的长度是否在设定的范围内，否则认为出现异常。
（3）如果监控发现异常，会记录异常信息，同时可以通过Email提醒用户。
（4）支持Proxy Server的设置。
（5）支持自动循环执行，同时用户可以进行定制，设置间隔时间。 
 
[b]Web Server Monitor 运行界面[/b]： 
1. 访问www.EntLib.com网站时的页面效果：  
[img]http://www.entlib.com/image/page/webservermonitor.gif[/img]

2. HTML 代码显示效果：
[img]http://www.entlib.com/image/page/webservermonitor1.gif[/img]

3. 检测结果：
[img]http://www.entlib.com/image/page/webservermonitor2.gif[/img]' , '127.0.0.1' , '2008-05-09 23:36:55.653' , 30 )
 INSERT [yaf_Message] ( [MessageID] , [TopicID] , [Position] , [Indent] , [UserID] , [Posted] , [Message] , [IP] , [Edited] , [Flags] ) VALUES ( 57 , 20 , 0 , 0 , 2 , '2008-05-10 19:26:18.810' , '在[url=http://teddyma.cnblogs.com/]Teddy[/url]提供的[url=http://www.yetanotherforum.net]Yet Another Forum[/url]汉化论坛源码的基础上，针对YAF进行了一些定制化的开发和更新。

[b]主要修改如下：[/b]
1.移除了URL Rewriter 特性及其代码，目标是想要一个简单的、标准的论坛系统。
2.用户注册页面中，设定Time Zone只能为：中国时区。
3.在个人配置页面，即时消息服务部分删除了Yahoo IM/ICQ/American IM 等等文本输入框。
4.同时，在post显示页面，也屏蔽了Yahoo IM/ICQ/American IM 等等图标的显示。
5.在论坛右下角-论坛跳转下拉框中，修复了一个小BUG了（有时会出现2个空白的选项）。
6.在post现实页面，修改了个人签名向下对齐，原来为向上对齐，靠近post的内容，不符合一般论坛的习惯。
7.清理了Web.config 文件，删除了一些没用的配置，同时设置Encoding为gb2312。
<globalization requestEncoding="gb2312" responseEncoding="gb2312"/>
8.在Web.config增加了一个配置项，用来设置是否向订阅用户发送邮件（Post/Forum订阅），因为一些论坛可能没有SMTP Server。
<add key="EnableMailServer" value="false" />
9.清理了论坛一些没用的文件，同时也删除了language目录下其他语种，仅保留了china/english。
10.删除了项目中的install 目录及其相关的文件，安装可以通过直接复制数据库文件和项目文件，这样更方便。
11.修正：在快速发帖/回复贴子页面中，设置回车键就可以提交回复内容，方便用户操作。
12.更改FlatEarth Theme，以便最好显示中文字体，同时更改一些中文图标。
13.删除了对RegisterForum Web Service 的引用，及其相关的upgrade version 检测等代码。
14.用户注册和登陆部分，对用户密码不进行加密处理（原代码对Password进行MD5运算），便于对用户管理部分与其他系统进行集成。

访问[url=http://forum.entlib.com/]EntLib.com 论坛[/url]查看论坛的运行效果及界面：

可以到[url=http://forum.entlib.com/]EntLib.com 论坛[/url]下载该论坛的全部源代码（ASP.NET/C#）。

对Yet Another Forum 英文原版感兴趣的，可以直接到 http://www.yetanotherforum.net 下载。


2008-05-10
http://www.entlib.com
' , '127.0.0.1' , '2008-05-10 23:20:59.483' , 22 )
 INSERT [yaf_Message] ( [MessageID] , [TopicID] , [Position] , [Indent] , [UserID] , [Posted] , [Message] , [IP] , [Flags] ) VALUES ( 63 , 25 , 0 , 0 , 14 , '2008-05-16 17:27:38.343' , '<p><img alt="" src="/editors/FCKEditorV2/editor/images/smiley/msn/regular_smile.gif" />&nbsp;#-o&nbsp;</p>
<p><strong>Unity 简单示例代码和向导</strong></p>' , '127.0.0.1' , 21 )
 INSERT [yaf_Message] ( [MessageID] , [TopicID] , [ReplyTo] , [Position] , [Indent] , [UserID] , [Posted] , [Message] , [IP] , [Edited] , [Flags] ) VALUES ( 64 , 25 , 63 , 1 , 1 , 14 , '2008-05-16 17:30:34.327' , '<div><span style="background-color: #ff6600">sdfsdfs </span></div>
<div>asfdsdf sad fsd f</div>
<div>sadfsd</div>
<div>sdfsdfsd sdfsd sdfsd sdf sd fsdf sdf sd fsd sd sd sdjf lsjdflksdjflsjdf lsjdfkszxdx sdfs</div>
<div>safdasdf</div>
<div>asdfasdf</div>
<div>&nbsp;</div>
<div>sadfsad</div>
<div>asdfsd</div>
<h3 style="color: red">sadfsa;dk fasd sdfsd</h3>
<pre>
sdfsdf sdf sdf sdf s d
sdf
sdf
sdf
sdf</pre>' , '127.0.0.1' , '2008-05-16 17:36:06.497' , 21 )
 INSERT [yaf_Message] ( [MessageID] , [TopicID] , [ReplyTo] , [Position] , [Indent] , [UserID] , [Posted] , [Message] , [IP] , [Flags] ) VALUES ( 66 , 25 , 63 , 2 , 1 , 14 , '2008-05-16 21:53:52.640' , '<p><img height="27" width="120" alt="" src="/userfiles123/image/biztalk.png" /></p>' , '127.0.0.1' , 21 )
 INSERT [yaf_Message] ( [MessageID] , [TopicID] , [ReplyTo] , [Position] , [Indent] , [UserID] , [Posted] , [Message] , [IP] , [Flags] ) VALUES ( 67 , 25 , 63 , 3 , 1 , 14 , '2008-05-16 22:47:24.467' , '<p><img height="28" width="96" alt="" src="/userfiles123/down.gif" /></p>' , '127.0.0.1' , 21 )
 INSERT [yaf_Message] ( [MessageID] , [TopicID] , [ReplyTo] , [Position] , [Indent] , [UserID] , [Posted] , [Message] , [IP] , [Flags] ) VALUES ( 68 , 25 , 63 , 4 , 1 , 14 , '2008-05-16 23:23:21.590' , '<p><img height="40" width="15" alt="" src="/userfiles123/CenterBottom.gif" /></p>
<p><img height="41" width="165" alt="" src="/userfiles123/14image/download.png" /></p>' , '127.0.0.1' , 21 )
 INSERT [yaf_Message] ( [MessageID] , [TopicID] , [Position] , [Indent] , [UserID] , [Posted] , [Message] , [IP] , [Flags] ) VALUES ( 84 , 33 , 0 , 0 , 2 , '2008-05-21 16:45:15.827' , '<div align="center"><b>最新版FCKEditor</b><b>在ASP.NET </b><b>环境下的配置及演示程序（附Demo</b><b>程序）</b></div>
<div>?</div>
<div>FCKeditor文本编辑程序（共享软件）为用户提供在线的文档编辑服务，其具有与微软office软件一样的功能，与之不同的是FCKeditor不需要用户安装任何形式的客户端，FCKeditor程序非常精简但功能强大，因此而受到广大应用者的青睐。</div>
<div>?</div>
<div><b>ASP.NET & FCKEditor v2.6</b><b>演示项目如下：<br />
<input type="image" height="293" width="270" src="/useruploadfiles/admin/image/FCKEditor/FCKEditor_Demo_Project.gif" /><br />
<br />
<div>其中fckeditor 目录是直接从FCKEditor 官方网站(<a href="http://www.fckeditor.net/"><font color="#800080">http://www.fckeditor.net</font></a> )下载的最新版本v2.6 的核心文件。整个项目需要引用FredCK.FCKeditorV2.dll，该dll 文件包含在下载文件 FCKeditor.Net / ASP.NET 控件中。关于FCKEditor 编辑器的基本介绍，请参考如下文章：</div>
<div><a href="http://forum.entlib.com/Default.aspx?g=posts&t=30"><font color="#800080">EntLib.com Forum / YAF <span><span>开源论坛集成</span> FCKEditor v2.6 <span>编辑器</span></span></font></a></div>
<div><a href="http://forum.entlib.com/Default.aspx?g=posts&t=27"><font color="#800080">FCKEditor v2.6 ASP.NET<span><span>下的配置和使用</span></span></font></a></div>
<div>?</div>
<div><b>如下是Demo</b><b>程序的演示界面：</b></div>
<br />
<input type="image" height="420" width="810" src="/useruploadfiles/admin/image/FCKEditor/FCKEditor_Demo_Project2.gif" /><br />
</b></div>' , '127.0.0.1' , 21 )
 INSERT [yaf_Message] ( [MessageID] , [TopicID] , [ReplyTo] , [Position] , [Indent] , [UserID] , [Posted] , [Message] , [IP] , [Flags] ) VALUES ( 89 , 24 , 62 , 2 , 1 , 14 , '2008-06-16 12:57:21.607' , 'abc' , '127.0.0.1' , 30 )
 INSERT [yaf_Message] ( [MessageID] , [TopicID] , [Position] , [Indent] , [UserID] , [Posted] , [Message] , [IP] , [Flags] ) VALUES ( 91 , 36 , 0 , 0 , 2 , '2008-08-10 11:53:36.390' , '<div align="center"><b>最新版FCKEditor</b><b>在ASP.NET </b><b>环境下的配置及演示程序（附Demo</b><b>程序）</b></div>
<div>&nbsp;</div>
<div>FCKeditor文本编辑程序（共享软件）为用户提供在线的文档编辑服务，其具有与微软office软件一样的功能，与之不同的是FCKeditor不需要用户安装任何形式的客户端，FCKeditor程序非常精简但功能强大，因此而受到广大应用者的青睐。<br />
<br />
<br />
&nbsp;</div>' , '127.0.0.1' , 21 )
 INSERT [yaf_Message] ( [MessageID] , [TopicID] , [ReplyTo] , [Position] , [Indent] , [UserID] , [Posted] , [Message] , [IP] , [Flags] ) VALUES ( 92 , 36 , 91 , 1 , 1 , 2 , '2008-08-10 11:53:45.280' , 'AAA' , '127.0.0.1' , 22 )
 INSERT [yaf_Message] ( [MessageID] , [TopicID] , [ReplyTo] , [Position] , [Indent] , [UserID] , [Posted] , [Message] , [IP] , [Flags] ) VALUES ( 93 , 36 , 91 , 2 , 1 , 2 , '2008-08-10 11:53:53.280' , 'ABB' , '127.0.0.1' , 22 )
 INSERT [yaf_Message] ( [MessageID] , [TopicID] , [ReplyTo] , [Position] , [Indent] , [UserID] , [Posted] , [Message] , [IP] , [Flags] ) VALUES ( 94 , 36 , 91 , 3 , 1 , 2 , '2008-08-10 11:54:04.420' , 'CCC' , '127.0.0.1' , 22 )
 INSERT [yaf_Message] ( [MessageID] , [TopicID] , [ReplyTo] , [Position] , [Indent] , [UserID] , [Posted] , [Message] , [IP] , [Flags] ) VALUES ( 95 , 36 , 91 , 4 , 1 , 2 , '2008-08-10 11:54:11.030' , 'DDD' , '127.0.0.1' , 22 )
 INSERT [yaf_Message] ( [MessageID] , [TopicID] , [ReplyTo] , [Position] , [Indent] , [UserID] , [Posted] , [Message] , [IP] , [Flags] ) VALUES ( 96 , 36 , 91 , 5 , 1 , 2 , '2008-08-10 11:54:22.140' , 'EEE' , '127.0.0.1' , 22 )
 INSERT [yaf_Message] ( [MessageID] , [TopicID] , [ReplyTo] , [Position] , [Indent] , [UserID] , [Posted] , [Message] , [IP] , [Flags] ) VALUES ( 97 , 36 , 91 , 6 , 1 , 2 , '2008-08-10 11:54:36.873' , 'FFF' , '127.0.0.1' , 22 )
 INSERT [yaf_Message] ( [MessageID] , [TopicID] , [ReplyTo] , [Position] , [Indent] , [UserID] , [Posted] , [Message] , [IP] , [Flags] ) VALUES ( 98 , 36 , 91 , 7 , 1 , 2 , '2008-08-10 11:54:43.780' , 'GGG' , '127.0.0.1' , 22 )
 INSERT [yaf_Message] ( [MessageID] , [TopicID] , [ReplyTo] , [Position] , [Indent] , [UserID] , [Posted] , [Message] , [IP] , [Flags] ) VALUES ( 99 , 36 , 91 , 8 , 1 , 2 , '2008-08-10 11:54:51.730' , 'III' , '127.0.0.1' , 22 )
 INSERT [yaf_Message] ( [MessageID] , [TopicID] , [ReplyTo] , [Position] , [Indent] , [UserID] , [Posted] , [Message] , [IP] , [Flags] ) VALUES ( 100 , 36 , 91 , 9 , 1 , 2 , '2008-08-10 11:55:04.700' , 'HHH' , '127.0.0.1' , 22 )
 INSERT [yaf_Message] ( [MessageID] , [TopicID] , [ReplyTo] , [Position] , [Indent] , [UserID] , [Posted] , [Message] , [IP] , [Flags] ) VALUES ( 101 , 36 , 91 , 10 , 1 , 2 , '2008-08-10 11:55:11.310' , 'JJJ' , '127.0.0.1' , 22 )
 INSERT [yaf_Message] ( [MessageID] , [TopicID] , [ReplyTo] , [Position] , [Indent] , [UserID] , [Posted] , [Message] , [IP] , [Flags] ) VALUES ( 102 , 36 , 91 , 11 , 1 , 2 , '2008-08-10 11:55:19.480' , 'LLL' , '127.0.0.1' , 22 )
 INSERT [yaf_Message] ( [MessageID] , [TopicID] , [ReplyTo] , [Position] , [Indent] , [UserID] , [Posted] , [Message] , [IP] , [Flags] ) VALUES ( 103 , 36 , 91 , 12 , 1 , 2 , '2008-08-10 11:55:28.497' , 'KKK' , '127.0.0.1' , 22 )
 INSERT [yaf_Message] ( [MessageID] , [TopicID] , [ReplyTo] , [Position] , [Indent] , [UserID] , [Posted] , [Message] , [IP] , [Flags] ) VALUES ( 104 , 36 , 91 , 13 , 1 , 2 , '2008-08-10 11:55:37.857' , 'MMM' , '127.0.0.1' , 22 )
 INSERT [yaf_Message] ( [MessageID] , [TopicID] , [ReplyTo] , [Position] , [Indent] , [UserID] , [Posted] , [Message] , [IP] , [Flags] ) VALUES ( 105 , 36 , 91 , 14 , 1 , 2 , '2008-08-10 11:55:48.840' , 'NNN' , '127.0.0.1' , 22 )
 INSERT [yaf_Message] ( [MessageID] , [TopicID] , [ReplyTo] , [Position] , [Indent] , [UserID] , [Posted] , [Message] , [IP] , [Flags] ) VALUES ( 106 , 36 , 91 , 15 , 1 , 2 , '2008-08-10 11:55:56.293' , 'OOO' , '127.0.0.1' , 22 )
 INSERT [yaf_Message] ( [MessageID] , [TopicID] , [ReplyTo] , [Position] , [Indent] , [UserID] , [Posted] , [Message] , [IP] , [Flags] ) VALUES ( 107 , 36 , 91 , 16 , 1 , 2 , '2008-08-10 11:56:02.890' , 'PPP' , '127.0.0.1' , 22 )
 INSERT [yaf_Message] ( [MessageID] , [TopicID] , [ReplyTo] , [Position] , [Indent] , [UserID] , [Posted] , [Message] , [IP] , [Flags] ) VALUES ( 108 , 36 , 91 , 17 , 1 , 2 , '2008-08-10 11:56:10.530' , 'QQQ' , '127.0.0.1' , 22 )
 INSERT [yaf_Message] ( [MessageID] , [TopicID] , [ReplyTo] , [Position] , [Indent] , [UserID] , [Posted] , [Message] , [IP] , [Flags] ) VALUES ( 109 , 36 , 91 , 18 , 1 , 2 , '2008-08-10 11:56:24.230' , 'RRR' , '127.0.0.1' , 22 )
 INSERT [yaf_Message] ( [MessageID] , [TopicID] , [ReplyTo] , [Position] , [Indent] , [UserID] , [Posted] , [Message] , [IP] , [Flags] ) VALUES ( 110 , 36 , 91 , 19 , 1 , 2 , '2008-08-10 11:56:37.340' , 'SSS' , '127.0.0.1' , 22 )
 INSERT [yaf_Message] ( [MessageID] , [TopicID] , [ReplyTo] , [Position] , [Indent] , [UserID] , [Posted] , [Message] , [IP] , [Flags] ) VALUES ( 111 , 36 , 91 , 20 , 1 , 2 , '2008-08-10 11:56:43.420' , 'TTT' , '127.0.0.1' , 22 )
 INSERT [yaf_Message] ( [MessageID] , [TopicID] , [ReplyTo] , [Position] , [Indent] , [UserID] , [Posted] , [Message] , [IP] , [Flags] ) VALUES ( 112 , 36 , 91 , 21 , 1 , 2 , '2008-08-10 11:56:51.700' , 'U' , '127.0.0.1' , 22 )
 INSERT [yaf_Message] ( [MessageID] , [TopicID] , [ReplyTo] , [Position] , [Indent] , [UserID] , [Posted] , [Message] , [IP] , [Flags] ) VALUES ( 113 , 36 , 91 , 22 , 1 , 2 , '2008-08-10 11:56:57.467' , 'VVV' , '127.0.0.1' , 22 )
 INSERT [yaf_Message] ( [MessageID] , [TopicID] , [ReplyTo] , [Position] , [Indent] , [UserID] , [Posted] , [Message] , [IP] , [Flags] ) VALUES ( 114 , 36 , 91 , 23 , 1 , 2 , '2008-08-10 11:57:03.950' , 'WWW' , '127.0.0.1' , 22 )
 INSERT [yaf_Message] ( [MessageID] , [TopicID] , [ReplyTo] , [Position] , [Indent] , [UserID] , [Posted] , [Message] , [IP] , [Flags] ) VALUES ( 115 , 36 , 91 , 24 , 1 , 2 , '2008-08-10 11:57:38.577' , 'AAAAAAAAAAAAAAAA' , '127.0.0.1' , 22 )
 INSERT [yaf_Message] ( [MessageID] , [TopicID] , [ReplyTo] , [Position] , [Indent] , [UserID] , [Posted] , [Message] , [IP] , [Flags] ) VALUES ( 116 , 36 , 91 , 25 , 1 , 2 , '2008-08-10 11:57:57.903' , 'bbbbbbbbbbbbbbbbbb' , '127.0.0.1' , 21 )
 INSERT [yaf_Message] ( [MessageID] , [TopicID] , [ReplyTo] , [Position] , [Indent] , [UserID] , [Posted] , [Message] , [IP] , [Flags] ) VALUES ( 119 , 19 , 56 , 3 , 1 , 2 , '2008-09-08 22:41:22.217' , 'abcde' , '127.0.0.1' , 30 )
 INSERT [yaf_Message] ( [MessageID] , [TopicID] , [ReplyTo] , [Position] , [Indent] , [UserID] , [Posted] , [Message] , [IP] , [Flags] ) VALUES ( 120 , 25 , 63 , 5 , 1 , 2 , '2008-09-08 22:53:46.933' , '好好好好好好' , '127.0.0.1' , 21 )
 INSERT [yaf_Message] ( [MessageID] , [TopicID] , [ReplyTo] , [Position] , [Indent] , [UserID] , [Posted] , [Message] , [IP] , [Flags] ) VALUES ( 131 , 20 , 57 , 1 , 1 , 2 , '2009-11-02 16:05:13.813' , 'OK. IT''S SO GOOD. ' , '127.0.0.1' , 22 )
 INSERT [yaf_Message] ( [MessageID] , [TopicID] , [ReplyTo] , [Position] , [Indent] , [UserID] , [Posted] , [Message] , [IP] , [Flags] ) VALUES ( 132 , 20 , 57 , 2 , 1 , 2 , '2009-11-02 16:10:42.517' , 'OK. <br />
<br />
I LIKE THIS OPEN-SOURCE FORUM.<br />' , '127.0.0.1' , 21 )
 INSERT [yaf_Message] ( [MessageID] , [TopicID] , [ReplyTo] , [Position] , [Indent] , [UserID] , [Posted] , [Message] , [IP] , [Flags] ) VALUES ( 135 , 38 , 122 , 1 , 1 , 2 , '2009-11-25 16:35:41.857' , '<compilation defaultLanguage="c#" debug="true">
   <assemblies>
    <add assembly="System.Core, Version=3.5.0.0, Culture=neutral, PublicKeyToken=B77A5C561934E089"/>
    <add assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31BF3856AD364E35"/>
    <add assembly="System.Xml.Linq, Version=3.5.0.0, Culture=neutral, PublicKeyToken=B77A5C561934E089"/>
    <add assembly="System.Data.DataSetExtensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=B77A5C561934E089"/></assemblies></compilation>' , '127.0.0.1' , 30 )
 INSERT [yaf_Message] ( [MessageID] , [TopicID] , [Position] , [Indent] , [UserID] , [Posted] , [Message] , [IP] , [Edited] , [Flags] ) VALUES ( 136 , 44 , 0 , 0 , 2 , '2009-11-25 16:38:22.990' , '<div style="text-align: center; line-height: 18pt" align="center"><b><span style="color: #3b3e39; font-size: 10pt">发布</span></b><b><span style="color: #3b3e39; font-size: 10pt">EntLib.com Forum &ndash; </span></b><b><span style="color: #3b3e39; font-size: 10pt">开源</span></b><b><span style="color: #3b3e39; font-size: 10pt">ASP.NET</span></b><b><span style="color: #3b3e39; font-size: 10pt">论坛</span></b><b><span style="color: #3b3e39; font-size: 10pt"> v4.0</span></b><b><span style="color: #3b3e39; font-size: 10pt">（提供源码下载）</span></b></div>
<div style="text-align: left; line-height: 18pt" align="left">&nbsp;</div>
<div style="text-align: left; line-height: 18pt" align="left"><span style="color: #3b3e39; font-size: 10pt">&nbsp;EntLib.com Forum </span><span style="color: #3b3e39; font-size: 10pt">开源</span><span style="color: #3b3e39; font-size: 10pt">ASP.NET </span><span style="color: #3b3e39; font-size: 10pt">论坛系统是</span><span style="color: #3b3e39; font-size: 10pt"><a href="http://forum.entlib.com/"><font color="#41519a">EntLib.com <span>小组</span></font></a></span><span style="color: #3b3e39; font-size: 10pt">基于</span><span style="color: #3b3e39; font-size: 10pt">YAF</span><span style="color: #3b3e39; font-size: 10pt">开源论坛进行中文汉化及改良的版本。现在，已经陆续发布了</span><span style="color: #3b3e39; font-size: 10pt">2.0, 2.5, 3.0, 3.5 </span><span style="color: #3b3e39; font-size: 10pt">等几个版本，</span><span style="color: #3b3e39; font-size: 10pt">EntLib</span><span style="color: #3b3e39; font-size: 10pt">官方网站的累计下载量已经超过</span><span style="color: #3b3e39; font-size: 10pt"> <b>10</b></span><b><span style="color: #3b3e39; font-size: 10pt">，</span></b><b><span style="color: #3b3e39; font-size: 10pt">000</span></b><span style="color: #3b3e39; font-size: 10pt">次。</span><span style="color: #3b3e39; font-size: 10pt">EntLib.com </span><span style="color: #3b3e39; font-size: 10pt">开源论坛小组持续对论坛进行优化，并根据用户的反馈，改进和添加一些新的功能。</span></div>
<div style="text-align: left; line-height: 18pt" align="left">&nbsp;</div>
<div style="text-align: left; line-height: 18pt" align="left"><span style="color: #3b3e39; font-size: 10pt">本开源论坛支持虚拟主机用户、更换或自定义模板</span><span style="color: #3b3e39; font-size: 10pt">Theme</span><span style="color: #3b3e39; font-size: 10pt">、最新</span><span style="color: #3b3e39; font-size: 10pt">FCKEditor</span><span style="color: #3b3e39; font-size: 10pt">编辑器、个性化论坛图标等等功能。</span><b><span style="color: red; font-size: 10pt">本论坛提供全部源代码（</span></b><b><span style="color: red; font-size: 10pt">100% ASP.NET C#</span></b><b><span style="color: red; font-size: 10pt">）和后台数据库脚本下载。</span></b></div>
<div style="text-align: left; line-height: 18pt" align="left">&nbsp;</div>
<div style="text-align: left; line-height: 18pt" align="left"><b><span style="color: #3b3e39; font-size: 10pt">论坛系统的运行环境：</span></b></div>
<div style="text-align: left; line-height: 18pt" align="left"><span style="color: #3b3e39; font-size: 10pt">ASP.Net 3.5 </span><span style="color: #3b3e39; font-size: 10pt">和</span><span style="color: #3b3e39; font-size: 10pt"> SQL Server 2005 / 2008</span></div>
<div style="text-align: left; line-height: 18pt" align="left">&nbsp;</div>
<div style="text-align: left; line-height: 18pt" align="left"><b><span style="color: #3b3e39; font-size: 10pt">开发，编译工具：</span></b></div>
<div style="text-align: left; line-height: 18pt" align="left"><span style="color: #3b3e39; font-size: 10pt">Visual Studio 2008</span></div>
<div style="text-align: left; line-height: 18pt" align="left">&nbsp;</div>
<div style="text-align: left; line-height: 18pt" align="left"><b><span style="color: #3b3e39; font-size: 10pt">本次更新功能列表：</span></b></div>
<div style="text-align: left; line-height: 18pt" align="left"><span style="color: #3b3e39; font-size: 9pt">Readme v4.0</span></div>
<div style="text-align: left; line-height: 18pt" align="left"><span style="color: #3b3e39; font-size: 9pt">============</span></div>
<div align="left"><span style="font-size: 9pt">1.</span><span style="font-size: 9pt">论坛FCKEditor 编辑器升级到最新版FCKEditor v2.6.3。新版FCKEditor 编辑器修正了一些Bugs，同时更好地支持ASP.NET AJAX等。</span></div>
<div><span style="font-size: 9pt">2.</span><span style="font-size: 9pt">可以自由配置添加广告内容，使论坛版主可以获得广告收入。需要在yaf_registry 表中添加一条记录：</span></div>
<div align="left"><span style="font-size: 9pt">3.</span><span style="font-size: 9pt">论坛帖子添加几层楼的信息，如楼主、1楼、2楼等等。需要修改[dbo].[yaf_post_list]存储过程，返回Row_Number()信息：</span></div>
<div align="left"><span style="font-size: 9pt">ROW_NUMBER() OVER(ORDER BY a.Posted ASC) as RowNumber</span></div>
<div align="left"><span style="font-size: 9pt">4. </span><span style="font-size: 9pt">去除回帖、发新帖的验证码，方便用户回帖。</span></div>
<div align="left"><span style="font-size: 9pt">5. </span><span style="font-size: 9pt">优化FCKEditor 编辑器。</span></div>
<div align="left"><span style="font-size: 9pt">6. </span><span style="font-size: 9pt">论坛页面布局调整，加快论坛的显示速度和性能。</span></div>
<div align="left"><span style="font-size: 9pt">7. </span><span style="font-size: 9pt">将【置顶】和【公告】的显示进行了适当调整（包括增加图标等等），与一般帖子进行区隔。</span></div>
<div style="text-align: left; line-height: 18pt" align="left"><span style="font-size: 9pt">8. </span><span style="font-size: 9pt">添加论坛图标的后台设置和上传图标的功能，该功能需要论坛版主操作。</span></div>
<div style="text-align: center; line-height: 18pt">&nbsp;<img alt="" src="http://forum.entlib.com/useruploadfiles/entlibforum/image/entlibforum/entlibforum_v4_1.gif" width="689" height="200" /></div>
<div style="text-align: left; line-height: 18pt" align="left"><span style="color: #3b3e39; font-size: 9pt"><br />
<br />
2009-11-25</span></div>
<div style="text-align: left; line-height: 18pt" align="left"><span style="color: #3b3e39; font-size: 9pt"><a href="http://forum.entlib.com/"><span style="color: purple; text-decoration: none; text-underline: none">http://forum.entlib.com</span></a> </span></div>
<div style="text-align: left; line-height: 18pt" align="left"><span style="color: #3b3e39; font-size: 9pt">EntLib.com Forum </span><span style="color: #3b3e39; font-size: 9pt">开源</span><span style="color: #3b3e39; font-size: 9pt">ASP.NET/C#</span><span style="color: #3b3e39; font-size: 9pt">论坛小组</span></div>
<div style="text-align: left; line-height: 18pt" align="left">&nbsp;</div>
<div style="text-align: left; line-height: 18pt" align="left"><b><span style="color: #3b3e39; font-size: 10pt">论坛运行界面（</span></b><b><span style="color: #3b3e39; font-size: 10pt">V4.0 </span></b><b><span style="color: #3b3e39; font-size: 10pt">版本）：</span></b></div>
<div>&nbsp;<img alt="" src="http://forum.entlib.com/useruploadfiles/entlibforum/image/entlibforum/entlibforum_v4_2.gif" width="690" height="464" /><br />
&nbsp;</div>' , '127.0.0.1' , '2009-11-25 16:51:41.160' , 21 )
 INSERT [yaf_Message] ( [MessageID] , [TopicID] , [Position] , [Indent] , [UserID] , [Posted] , [Message] , [IP] , [Edited] , [Flags] ) VALUES ( 137 , 45 , 0 , 0 , 2 , '2009-11-25 16:39:33.743' , '<div align="center"><b>EntLib.com </b><b>电子商务系统 v2.0 &ndash; </b><b>前台购物网站/</b><b>网店发布免费下载！</b></div>
<div>&nbsp;</div>
<div style="text-align: center">&nbsp;<img alt="EntLib.com 电子商务系统 v2.0" width="700" height="312" src="http://forum.entlib.com/useruploadfiles/entlibboy/image/eCommerce_website/entlib_ecommerce_shoppingsite_released.gif" /></div>
<div>EntLib.com 电子商务系统是由电子商务领域的资深专家创办，在长期从事电子商务业务及其软件系统的分析和开发过程中，积累了大量宝贵的经验，形成了一套规范的电子商务业务流程，设计、开发完成了EntLib.com 电子商务系统全套解决方案。</div>
<div>&nbsp;</div>
<div>这里，首先发布EntLib.com 电子商务系统 v2.0 的前台购物网站部分，欢迎免费下载，免费试用！可以到这里<a href="http://forum.entlib.com/Default.aspx?g=posts&amp;t=674"><span><span>查看前台购物网站的部分截图</span></span>。</a></div>
<div>&nbsp;</div>
<div>其中网站中的产品数据、产品图片等等均来自于礼品中心网(<a href="http://www.giftcenter.cn/">www.giftcenter.cn</a> )，在此表示感谢。</div>
<div>&nbsp;</div>
<div><b>EntLib.com </b><b>电子商务系统运行环境：</b></div>
<div>（1）操作系统支持 Windows XP，Windows Vista，Windows 7，Windows Server 2003，Windows Server 2008。</div>
<div>（2）微软.Net Framework v3.5（微软提供免费下载）</div>
<div><a href="http://www.microsoft.com/downloads/details.aspx?familyid=333325fd-ae52-4e35-b531-508d977d32a6&amp;displaylang=zh-cn">http://www.microsoft.com/downloads/details.aspx?familyid=333325fd-ae52-4e35-b531-508d977d32a6&amp;displaylang=zh-cn</a></div>
<div>（3）数据库采用微软SQL Server 2005 / 2008 或SQL Server Express 免费版本。</div>
<div>&nbsp;</div>
<div>EntLib.com eCommerce Team（电子商务小组）</div>
<div><a href="http://www.entlib.com/">http://www.entlib.com</a></div>
<div>&nbsp;</div>' , '127.0.0.1' , '2009-11-25 16:41:04.807' , 21 )
 INSERT [yaf_Message] ( [MessageID] , [TopicID] , [Position] , [Indent] , [UserID] , [Posted] , [Message] , [IP] , [Flags] ) VALUES ( 138 , 46 , 0 , 0 , 2 , '2009-11-25 16:56:47.650' , '<br />
<div style="text-align: center"><input src="http://forum.entlib.com/useruploadfiles/%E7%BE%8E%E5%A5%B3%E7%A8%8B%E5%BA%8F%E5%91%98/image/EnterpriseLibrary/EnterpriseLibraryTopic.jpg" width="748" height="108" type="image" /></div>
<br />
Enterprise Library for .Net Framework 3.5 &ndash; EntLib v4.1 是patterns &amp; practices 小组为.NET Framework 3.5 开发一套企业库，目前最新版本为v4.1，共包括9个Application Block，包括数据访问（Data Access Application Block）、异常管理（Exception Handling Application Block）、数据验证（Validation Application Block）等等，对企业应用开发非常有帮助，也非常实用。<br />
<h3><strong>数据访问（Data Access Application Block）</strong></h3>
<a id="AggRecentPosts1_RecentPosts_ctl05_Hyperlink2" href="http://blog.entlib.com/entlibforum/archive/2009/08/26/enterprise-library-data-access-application-block-part-1.aspx"><font color="#41519a">Enterprise Library &ndash; Data Access Application Block 学习手册（最新版）- Part 1</font></a><br />
<a id="AggRecentPosts1_RecentPosts_ctl04_Hyperlink2" href="http://blog.entlib.com/entlibforum/archive/2009/08/26/enterprise-library-data-access-application-block-part-2.aspx"><font color="#41519a">Enterprise Library &ndash; Data Access Application Block 学习手册（最新版）- Part 2</font></a><br />
<a id="AggRecentPosts1_RecentPosts_ctl03_Hyperlink2" href="http://blog.entlib.com/entlibforum/archive/2009/08/27/enterprise-library-data-access-application-block-part-3.aspx"><font color="#41519a">Enterprise Library &ndash; Data Access Application Block 学习手册（最新版）- Part 3</font></a><br />
<h3><strong>异常管理（Exception Handling Application Block）</strong></h3>
<a id="AggRecentPosts1_RecentPosts_ctl02_Hyperlink2" href="http://blog.entlib.com/entlibforum/archive/2009/08/31/enterprise-library-exception-handling-application-block-part-1.aspx"><font color="#41519a">Enterprise Library - Exception Handling Application Block 学习手册（最新版）Part 1</font></a><br />
<a id="AggRecentPosts1_RecentPosts_ctl01_Hyperlink2" href="http://blog.entlib.com/entlibforum/archive/2009/09/01/enterprise-library-exception-handling-application-block-part-2.aspx"><font color="#41519a">Enterprise Library - Exception Handling Application Block 学习手册（最新版） Part 2</font></a><br />
<h3><strong>日志管理（Logging Application Block） </strong></h3>
<a id="AggRecentPosts1_RecentPosts_ctl00_Hyperlink2" href="http://blog.entlib.com/entlibforum/archive/2009/09/02/enterprise-library-logging-handling-application-block-part-1.aspx"><font color="#41519a">Enterprise Library - Logging Application Block 学习手册（最新版） Part 1</font></a><br />
<a id="AggRecentPosts1_RecentPosts_ctl05_Hyperlink2" href="http://blog.entlib.com/entlibforum/archive/2009/09/03/enterprise-library-logging-handling-application-block-part-2.aspx"><font color="#41519a">Enterprise Library - Logging Application Block 学习手册（最新版） Part 2</font></a><br />
<a id="AggRecentPosts1_RecentPosts_ctl04_Hyperlink2" href="http://blog.entlib.com/entlibforum/archive/2009/09/05/enterprise-library-logging-handling-application-block-part-3.aspx"><font color="#41519a">Enterprise Library - Logging Application Block 学习手册（最新版） Part 3</font></a><br />
<h3><strong>数据验证（Validation Application Block）</strong></h3>
<a id="AggRecentPosts1_RecentPosts_ctl03_Hyperlink2" href="http://blog.entlib.com/entlibforum/archive/2009/09/06/enterprise-library-validation-handling-application-block-part-1.aspx"><font color="#41519a">Enterprise Library - Validation Application Block 学习手册（最新版） Part 1</font></a><br />
<a id="AggRecentPosts1_RecentPosts_ctl02_Hyperlink2" href="http://blog.entlib.com/entlibforum/archive/2009/09/07/enterprise-library-validation-handling-application-block-part-2.aspx"><font color="#41519a">Enterprise Library - Validation Application Block 学习手册（最新版） Part 2</font></a><br />
<a id="AggRecentPosts1_RecentPosts_ctl01_Hyperlink2" href="http://blog.entlib.com/entlibforum/archive/2009/09/07/enterprise-library-validation-handling-application-block-part-3.aspx"><font color="#41519a">Enterprise Library - Validation Application Block 学习手册（最新版） Part 3</font></a><br />
<a id="AggRecentPosts1_RecentPosts_ctl00_Hyperlink2" href="http://blog.entlib.com/entlibforum/archive/2009/09/08/enterprise-library-validation-handling-application-block-part-4.aspx"><font color="#41519a">Enterprise Library - Validation Application Block 学习手册（最新版） Part 4</font></a><br />
<a id="AggRecentPosts1_RecentPosts_ctl09_Hyperlink2" href="http://blog.entlib.com/entlibforum/archive/2009/09/09/enterprise-library-validation-handling-application-block-part-5.aspx"><font color="#41519a">Enterprise Library - Validation Application Block 学习手册（最新版） Part 5</font></a><br />
<a id="AggRecentPosts1_RecentPosts_ctl08_Hyperlink2" href="http://blog.entlib.com/entlibforum/archive/2009/09/10/enterprise-library-validation-handling-application-block-part-6.aspx"><font color="#41519a">Enterprise Library - Validation Application Block 学习手册（最新版） Part 6</font></a><br />
<a id="AggRecentPosts1_RecentPosts_ctl07_Hyperlink2" href="http://blog.entlib.com/entlibforum/archive/2009/09/12/enterprise-library-validation-handling-application-block-part-7.aspx"><font color="#41519a">Enterprise Library - Validation Application Block 学习手册（最新版） Part 7</font></a><br />
<h3><strong>依赖注入容器（Unity Application Block） </strong></h3>
<a id="AggRecentPosts1_RecentPosts_ctl06_Hyperlink2" href="http://blog.entlib.com/entlibforum/archive/2009/09/14/enterprise-library-unity-application-block-part-1.aspx"><font color="#41519a">Enterprise Library - Unity Application Block 学习手册（最新版） Part 1</font></a><br />
<a id="AggRecentPosts1_RecentPosts_ctl05_Hyperlink2" href="http://blog.entlib.com/entlibforum/archive/2009/09/15/enterprise-library-unity-application-block-part-2.aspx"><font color="#41519a">Enterprise Library - Unity Application Block 学习手册（最新版） Part 2</font></a><br />
<a id="AggRecentPosts1_RecentPosts_ctl04_Hyperlink2" href="http://blog.entlib.com/entlibforum/archive/2009/09/16/enterprise-library-unity-application-block-part-3.aspx"><font color="#41519a">Enterprise Library - Unity Application Block 学习手册（最新版） Part 3</font></a><br />
<a id="AggRecentPosts1_RecentPosts_ctl02_Hyperlink2" href="http://blog.entlib.com/entlibforum/archive/2009/09/23/enterprise-library-unity-application-block-part-4.aspx"><font color="#41519a">Enterprise Library - Unity Application Block 学习手册（最新版） Part 4</font></a><br />
<h3><strong>缓存管理（Caching Application Block）</strong></h3>
<a id="AggRecentPosts1_RecentPosts_ctl00_Hyperlink2" href="http://blog.entlib.com/entlibforum/archive/2009/09/27/enterprise-library-caching-application-block-part-1.aspx"><font color="#41519a">Enterprise Library - Caching Application Block 学习手册（最新版） Part 1</font></a><br />
<a id="AggRecentPosts1_RecentPosts_ctl03_Hyperlink2" href="http://blog.entlib.com/entlibforum/archive/2009/09/29/enterprise-library-caching-application-block-part-2.aspx"><font color="#41519a">Enterprise Library - Caching Application Block 学习手册（最新版） Part 2</font></a><br />
<a id="AggRecentPosts1_RecentPosts_ctl02_Hyperlink2" href="http://blog.entlib.com/entlibforum/archive/2009/09/30/enterprise-library-caching-application-block-part-3.aspx"><font color="#41519a">Enterprise Library - Caching Application Block 学习手册（最新版） Part 3</font></a><br />
<h3><strong>加密/解密（Cryptography Application Block）</strong></h3>
<a id="AggRecentPosts1_RecentPosts_ctl01_Hyperlink2" href="http://blog.entlib.com/entlibforum/archive/2009/10/11/enterprise-library-cryptography-application-block-part-1.aspx"><font color="#41519a">Enterprise Library - Cryptography Application Block 学习手册（最新版） Part 1</font></a><br />
<a id="AggRecentPosts1_RecentPosts_ctl00_Hyperlink2" href="http://blog.entlib.com/entlibforum/archive/2009/10/11/enterprise-library-cryptography-application-block-part-2.aspx"><font color="#41519a">Enterprise Library - Cryptography Application Block 学习手册（最新版） Part 2</font></a><br />
<h3><strong>安全管理（Security Application Block）</strong></h3>
<a id="AggRecentPosts1_RecentPosts_ctl01_Hyperlink2" href="http://blog.entlib.com/entlibforum/archive/2009/10/12/enterprise-library-security-application-block-part-1.aspx"><font color="#41519a">Enterprise Library - Security Application Block 学习手册（最新版） Part 1</font></a><br />
<a id="AggRecentPosts1_RecentPosts_ctl00_Hyperlink2" href="http://blog.entlib.com/entlibforum/archive/2009/10/12/enterprise-library-security-application-block-part-2.aspx"><font color="#41519a">Enterprise Library - Security Application Block 学习手册（最新版） Part 2</font></a><br />
<br />
<br />
<div style="text-align: center"><input src="http://blog.entlib.com/userfiles/entlibforum/image/EnterpriseLibrary/entlib_accelerator2.jpg" type="image" /><br />
&nbsp;</div>' , '127.0.0.1' , 21 )
 INSERT [yaf_Message] ( [MessageID] , [TopicID] , [ReplyTo] , [Position] , [Indent] , [UserID] , [Posted] , [Message] , [IP] , [Flags] ) VALUES ( 139 , 45 , 137 , 1 , 1 , 2 , '2009-11-25 17:05:35.363' , 'so cool. i like it so much. ' , '127.0.0.1' , 22 )

 SET IDENTITY_INSERT [yaf_Message] OFF

 if exists (select * from sysobjects where id = OBJECT_ID('[yaf_NntpForum]') and OBJECTPROPERTY(id, 'IsUserTable') = 1) DROP TABLE [yaf_NntpForum] 
 CREATE TABLE [yaf_NntpForum] (  [NntpForumID] [int] IDENTITY (1, 1) NOT NULL ,  [NntpServerID] [int] NOT NULL , [GroupName] [nvarchar] (100) NOT NULL ,  [ForumID] [int] NOT NULL ,  [LastMessageNo] [int] NOT NULL , [LastUpdate] [datetime]  NOT NULL , [Active] [bit] NOT NULL )
 ALTER TABLE [yaf_NntpForum] WITH NOCHECK ADD CONSTRAINT [PK_yaf_NntpForum] PRIMARY KEY  NONCLUSTERED ( [NntpForumID] )

 if exists (select * from sysobjects where id = OBJECT_ID('[yaf_NntpServer]') and OBJECTPROPERTY(id, 'IsUserTable') = 1) DROP TABLE [yaf_NntpServer] 
 CREATE TABLE [yaf_NntpServer] (  [NntpServerID] [int] IDENTITY (1, 1) NOT NULL ,  [BoardID] [int] NOT NULL , [Name] [nvarchar] (50) NOT NULL , [Address] [nvarchar] (100) NOT NULL ,  [Port] [int] NULL , [UserName] [nvarchar] (50) NULL , [UserPass] [nvarchar] (50) NULL )
 ALTER TABLE [yaf_NntpServer] WITH NOCHECK ADD CONSTRAINT [PK_yaf_NntpServer] PRIMARY KEY  NONCLUSTERED ( [NntpServerID] )

 if exists (select * from sysobjects where id = OBJECT_ID('[yaf_NntpTopic]') and OBJECTPROPERTY(id, 'IsUserTable') = 1) DROP TABLE [yaf_NntpTopic] 
 CREATE TABLE [yaf_NntpTopic] (  [NntpTopicID] [int] IDENTITY (1, 1) NOT NULL ,  [NntpForumID] [int] NOT NULL , [Thread] [char] (32) NOT NULL ,  [TopicID] [int] NOT NULL )
 ALTER TABLE [yaf_NntpTopic] WITH NOCHECK ADD CONSTRAINT [PK_yaf_NntpTopic] PRIMARY KEY  NONCLUSTERED ( [NntpTopicID] )

 if exists (select * from sysobjects where id = OBJECT_ID('[yaf_PMessage]') and OBJECTPROPERTY(id, 'IsUserTable') = 1) DROP TABLE [yaf_PMessage] 
 CREATE TABLE [yaf_PMessage] (  [PMessageID] [int] IDENTITY (1, 1) NOT NULL ,  [FromUserID] [int] NOT NULL , [Created] [datetime]  NOT NULL , [Subject] [nvarchar] (256) NOT NULL , [Body] [ntext] NOT NULL ,  [Flags] [int] NOT NULL )
 ALTER TABLE [yaf_PMessage] WITH NOCHECK ADD CONSTRAINT [PK_yaf_PMessage] PRIMARY KEY  NONCLUSTERED ( [PMessageID] )

 if exists (select * from sysobjects where id = OBJECT_ID('[yaf_Poll]') and OBJECTPROPERTY(id, 'IsUserTable') = 1) DROP TABLE [yaf_Poll] 
 CREATE TABLE [yaf_Poll] (  [PollID] [int] IDENTITY (1, 1) NOT NULL , [Question] [nvarchar] (50) NOT NULL , [Closes] [datetime]  NULL )
 ALTER TABLE [yaf_Poll] WITH NOCHECK ADD CONSTRAINT [PK_yaf_Poll] PRIMARY KEY  NONCLUSTERED ( [PollID] )

 if exists (select * from sysobjects where id = OBJECT_ID('[yaf_PollVote]') and OBJECTPROPERTY(id, 'IsUserTable') = 1) DROP TABLE [yaf_PollVote] 
 CREATE TABLE [yaf_PollVote] (  [PollVoteID] [int] IDENTITY (1, 1) NOT NULL ,  [PollID] [int] NOT NULL ,  [UserID] [int] NULL , [RemoteIP] [nvarchar] (10) NULL )
 ALTER TABLE [yaf_PollVote] WITH NOCHECK ADD CONSTRAINT [PK_yaf_PollVote] PRIMARY KEY  NONCLUSTERED ( [PollVoteID] )
 CREATE INDEX [IX_yaf_PollVote_PollID] ON [yaf_PollVote] ( PollID ) 
 CREATE INDEX [IX_yaf_PollVote_RemoteIP] ON [yaf_PollVote] ( RemoteIP ) 
 CREATE INDEX [IX_yaf_PollVote_UserID] ON [yaf_PollVote] ( UserID ) 

 if exists (select * from sysobjects where id = OBJECT_ID('[yaf_Rank]') and OBJECTPROPERTY(id, 'IsUserTable') = 1) DROP TABLE [yaf_Rank] 
 CREATE TABLE [yaf_Rank] (  [RankID] [int] IDENTITY (1, 1) NOT NULL ,  [BoardID] [int] NOT NULL , [Name] [nvarchar] (50) NOT NULL ,  [MinPosts] [int] NULL , [RankImage] [nvarchar] (50) NULL ,  [Flags] [int] NOT NULL )
 ALTER TABLE [yaf_Rank] WITH NOCHECK ADD CONSTRAINT [DF_yaf_Rank_Flags] DEFAULT ((0)) FOR [Flags],CONSTRAINT [PK_yaf_Rank] PRIMARY KEY  NONCLUSTERED ( [RankID] )

 SET IDENTITY_INSERT [yaf_Rank] ON

 INSERT [yaf_Rank] ( [RankID] , [BoardID] , [Name] , [RankImage] , [Flags] ) VALUES ( 1 , 1 , '管理员' , 'star5.gif' , 0 )
 INSERT [yaf_Rank] ( [RankID] , [BoardID] , [Name] , [Flags] ) VALUES ( 2 , 1 , '客人' , 0 )
 INSERT [yaf_Rank] ( [RankID] , [BoardID] , [Name] , [MinPosts] , [Flags] ) VALUES ( 3 , 1 , '初级会员' , 0 , 3 )
 INSERT [yaf_Rank] ( [RankID] , [BoardID] , [Name] , [MinPosts] , [RankImage] , [Flags] ) VALUES ( 4 , 1 , '1星级会员' , 10 , 'star1.gif' , 2 )
 INSERT [yaf_Rank] ( [RankID] , [BoardID] , [Name] , [MinPosts] , [RankImage] , [Flags] ) VALUES ( 5 , 1 , '2星级会员' , 30 , 'star2.gif' , 2 )
 INSERT [yaf_Rank] ( [RankID] , [BoardID] , [Name] , [MinPosts] , [RankImage] , [Flags] ) VALUES ( 21 , 1 , '3星级会员' , 80 , 'star3.gif' , 2 )

 SET IDENTITY_INSERT [yaf_Rank] OFF

 if exists (select * from sysobjects where id = OBJECT_ID('[yaf_Registry]') and OBJECTPROPERTY(id, 'IsUserTable') = 1) DROP TABLE [yaf_Registry] 
 CREATE TABLE [yaf_Registry] (  [RegistryID] [int] IDENTITY (1, 1) NOT NULL , [Name] [nvarchar] (50) NOT NULL , [VALUE] [ntext] NULL ,  [BoardID] [int] NULL )
 ALTER TABLE [yaf_Registry] WITH NOCHECK ADD CONSTRAINT [PK_yaf_Registry] PRIMARY KEY  NONCLUSTERED ( [RegistryID] )
 CREATE UNIQUE INDEX [IX_Name] ON [yaf_Registry] ( BoardID, Name ) 

 SET IDENTITY_INSERT [yaf_Registry] ON

 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] ) VALUES ( 1 , 'version' , '22' )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] ) VALUES ( 2 , 'versionname' , '1.9.1 RC1' )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] ) VALUES ( 3 , 'timezone' , '480' )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] ) VALUES ( 4 , 'smtpserver' , 'SMTP SERVER' )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] ) VALUES ( 5 , 'forumemail' , 'entlibforum@hotmail.com' )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] ) VALUES ( 6 , 'allowthemedlogo' , '0' )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] , [BoardID] ) VALUES ( 7 , 'showtopicsdefault' , '0' , 1 )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] , [BoardID] ) VALUES ( 8 , 'language' , 'china.xml' , 1 )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] , [BoardID] ) VALUES ( 9 , 'theme' , 'flatearth.xml' , 1 )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] ) VALUES ( 10 , 'createnntpusers' , '0' )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] ) VALUES ( 11 , 'lockposts' , '0' )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] ) VALUES ( 12 , 'showpagegenerationtime' , '1' )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] ) VALUES ( 13 , 'adpost' , '                <script type="text/javascript"><!--
                    google_ad_client = "pub-7768717352490832";
                    /* 728x90, 创建于 09-9-16 */
                    google_ad_slot = "6676868558";
                    google_ad_width = 728;
                    google_ad_height = 90;
//-->
                </script>

                <script type="text/javascript" src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
                </script>' )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] ) VALUES ( 14 , 'usefiletable' , '0' )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] ) VALUES ( 15 , 'blanklinks' , '0' )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] ) VALUES ( 16 , 'acceptedhtml' , 'br,hr,b,i,u,a,div,ol,ul,li,blockquote,img,span,p,em,strong,font,pre,h1,h2,h3,h4,h5,h6,address,input,script' )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] ) VALUES ( 17 , 'allowusertheme' , '0' )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] ) VALUES ( 18 , 'avatarwidth' , '120' )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] ) VALUES ( 19 , 'smiliescolumns' , '3' )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] ) VALUES ( 20 , 'avatarremote' , '0' )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] ) VALUES ( 21 , 'allowpmemailnotification' , '0' )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] ) VALUES ( 22 , 'topicsperpage' , '15' )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] ) VALUES ( 23 , 'showgroupsprofile' , '0' )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] ) VALUES ( 24 , 'showgroups' , '1' )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] ) VALUES ( 25 , 'emailverification' , '0' )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] ) VALUES ( 26 , 'showmoved' , '1' )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] ) VALUES ( 27 , 'allowprivatemessages' , '1' )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] ) VALUES ( 28 , 'displaypoints' , '1' )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] ) VALUES ( 29 , 'smtpusername' )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] ) VALUES ( 30 , 'showrsslink' , '1' )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] ) VALUES ( 31 , 'allowuserlanguage' , '0' )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] ) VALUES ( 32 , 'allowsignatures' , '1' )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] ) VALUES ( 33 , 'postflooddelay' , '30' )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] ) VALUES ( 34 , 'showforumjump' , '1' )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] ) VALUES ( 35 , 'removenestedquotes' , '0' )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] ) VALUES ( 36 , 'allowemailsending' , '0' )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] ) VALUES ( 37 , 'showadstosignedinusers' , '1' )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] ) VALUES ( 38 , 'disableregistrations' , '0' )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] ) VALUES ( 39 , 'dateformatfromlanguage' , '0' )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] ) VALUES ( 40 , 'showmemberstats' , '1' )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] ) VALUES ( 41 , 'avatarsize' , '50000' )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] ) VALUES ( 42 , 'maxfilesize' , '0' )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] ) VALUES ( 43 , 'pollvotetiedtoip' , '1' )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] ) VALUES ( 44 , 'smiliesperrow' , '6' )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] ) VALUES ( 45 , 'postsperpage' , '20' )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] ) VALUES ( 46 , 'forumeditor' , '2' )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] ) VALUES ( 47 , 'avatarupload' , '1' )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] ) VALUES ( 48 , 'avatarheight' , '120' )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] ) VALUES ( 49 , 'smtpuserpass' )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] , [BoardID] ) VALUES ( 50 , 'maxusers' , '186' , 1 )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] , [BoardID] ) VALUES ( 51 , 'maxuserswhen' , '2008-06-16T11:29:31.513' , 1 )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] ) VALUES ( 52 , 'forumad' , '<table style="width:100%;">
<tr>
<td>
<a href="http://forum.entlib.com/Default.aspx?g=posts&t=682">
<img src="http://forum.entlib.com/useruploadfiles/entlibboy/image/eCommerce_website/entlib_ecommerce_shoppingsite_released2.gif" /></a>
</td>
<td align="right">
<script type="text/javascript"><!--
google_ad_client = "pub-7768717352490832";
/* 125x125, 创建于 09-9-18 */
google_ad_slot = "9467951647";
google_ad_width = 125;
google_ad_height = 125;
//-->
</script>
<script type="text/javascript"
src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
</script>
</td>
</tr>
</table>' )
 INSERT [yaf_Registry] ( [RegistryID] , [Name] , [VALUE] ) VALUES ( 53 , 'firstpostad' , '<br />
<div style="text-align: center;">
<script type="text/javascript"><!--
google_ad_client = "pub-7768717352490832";
/* 728x15, 创建于 09-9-27 */
google_ad_slot = "3301935418";
google_ad_width = 728;
google_ad_height = 15;
//-->
</script>
<script type="text/javascript"
src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
</script>
</div>' )

 SET IDENTITY_INSERT [yaf_Registry] OFF

 if exists (select * from sysobjects where id = OBJECT_ID('[yaf_Replace_Words]') and OBJECTPROPERTY(id, 'IsUserTable') = 1) DROP TABLE [yaf_Replace_Words] 
 CREATE TABLE [yaf_Replace_Words] (  [id] [int] IDENTITY (1, 1) NOT NULL , [badword] [nvarchar] (255) NULL , [goodword] [nvarchar] (255) NULL )
 ALTER TABLE [yaf_Replace_Words] WITH NOCHECK ADD CONSTRAINT [PK_yaf_Replace_Words] PRIMARY KEY  NONCLUSTERED ( [id] )

 if exists (select * from sysobjects where id = OBJECT_ID('[yaf_Smiley]') and OBJECTPROPERTY(id, 'IsUserTable') = 1) DROP TABLE [yaf_Smiley] 
 CREATE TABLE [yaf_Smiley] (  [SmileyID] [int] IDENTITY (1, 1) NOT NULL ,  [BoardID] [int] NOT NULL , [Code] [nvarchar] (10) NOT NULL , [Icon] [nvarchar] (50) NOT NULL , [Emoticon] [nvarchar] (50) NULL )
 ALTER TABLE [yaf_Smiley] WITH NOCHECK ADD CONSTRAINT [PK_yaf_Smiley] PRIMARY KEY  NONCLUSTERED ( [SmileyID] )
 CREATE UNIQUE INDEX [IX_yaf_Smiley] ON [yaf_Smiley] ( BoardID,Code ) 

 SET IDENTITY_INSERT [yaf_Smiley] ON

 INSERT [yaf_Smiley] ( [SmileyID] , [BoardID] , [Code] , [Icon] , [Emoticon] ) VALUES ( 3 , 1 , '=D^' , 'eusa_clap.gif' , 'Applause' )
 INSERT [yaf_Smiley] ( [SmileyID] , [BoardID] , [Code] , [Icon] , [Emoticon] ) VALUES ( 4 , 1 , '#-o' , 'eusa_doh.gif' , 'd''oh!' )
 INSERT [yaf_Smiley] ( [SmileyID] , [BoardID] , [Code] , [Icon] , [Emoticon] ) VALUES ( 5 , 1 , '=P~' , 'eusa_drool.gif' , 'Drool' )
 INSERT [yaf_Smiley] ( [SmileyID] , [BoardID] , [Code] , [Icon] , [Emoticon] ) VALUES ( 6 , 1 , ':^o' , 'eusa_liar.gif' , 'Liar' )
 INSERT [yaf_Smiley] ( [SmileyID] , [BoardID] , [Code] , [Icon] , [Emoticon] ) VALUES ( 7 , 1 , ':---)' , 'eusa_liar.gif' , 'Liar' )
 INSERT [yaf_Smiley] ( [SmileyID] , [BoardID] , [Code] , [Icon] , [Emoticon] ) VALUES ( 8 , 1 , '[-X' , 'eusa_naughty.gif' , 'Shame on you' )
 INSERT [yaf_Smiley] ( [SmileyID] , [BoardID] , [Code] , [Icon] , [Emoticon] ) VALUES ( 9 , 1 , '[-o^' , 'eusa_pray.gif' , 'Pray' )
 INSERT [yaf_Smiley] ( [SmileyID] , [BoardID] , [Code] , [Icon] , [Emoticon] ) VALUES ( 10 , 1 , '8-[' , 'eusa_shifty.gif' , 'Anxious' )
 INSERT [yaf_Smiley] ( [SmileyID] , [BoardID] , [Code] , [Icon] , [Emoticon] ) VALUES ( 11 , 1 , '[-(' , 'eusa_snooty.gif' , 'Not talking' )
 INSERT [yaf_Smiley] ( [SmileyID] , [BoardID] , [Code] , [Icon] , [Emoticon] ) VALUES ( 12 , 1 , ':-k' , 'eusa_think.gif' , 'Think' )
 INSERT [yaf_Smiley] ( [SmileyID] , [BoardID] , [Code] , [Icon] , [Emoticon] ) VALUES ( 13 , 1 , '](*,)' , 'eusa_wall.gif' , 'Brick wall' )
 INSERT [yaf_Smiley] ( [SmileyID] , [BoardID] , [Code] , [Icon] , [Emoticon] ) VALUES ( 14 , 1 , ':-"' , 'eusa_whistle.gif' , 'Whistle' )
 INSERT [yaf_Smiley] ( [SmileyID] , [BoardID] , [Code] , [Icon] , [Emoticon] ) VALUES ( 15 , 1 , 'O:)' , 'eusa_angel.gif' , 'Angel' )
 INSERT [yaf_Smiley] ( [SmileyID] , [BoardID] , [Code] , [Icon] , [Emoticon] ) VALUES ( 16 , 1 , '=;' , 'eusa_hand.gif' , 'Speak to the hand' )
 INSERT [yaf_Smiley] ( [SmileyID] , [BoardID] , [Code] , [Icon] , [Emoticon] ) VALUES ( 17 , 1 , ':-&' , 'eusa_sick.gif' , 'Sick' )
 INSERT [yaf_Smiley] ( [SmileyID] , [BoardID] , [Code] , [Icon] , [Emoticon] ) VALUES ( 18 , 1 , ':-({|=' , 'eusa_boohoo.gif' , 'Boo hoo!' )
 INSERT [yaf_Smiley] ( [SmileyID] , [BoardID] , [Code] , [Icon] , [Emoticon] ) VALUES ( 19 , 1 , ':-$' , 'eusa_shhh.gif' , 'Shhh' )
 INSERT [yaf_Smiley] ( [SmileyID] , [BoardID] , [Code] , [Icon] , [Emoticon] ) VALUES ( 20 , 1 , ':-s' , 'eusa_eh.gif' , 'Eh?' )
 INSERT [yaf_Smiley] ( [SmileyID] , [BoardID] , [Code] , [Icon] , [Emoticon] ) VALUES ( 21 , 1 , '^:D^' , 'eusa_dance.gif' , 'Dancing' )
 INSERT [yaf_Smiley] ( [SmileyID] , [BoardID] , [Code] , [Icon] , [Emoticon] ) VALUES ( 22 , 1 , ':-#' , 'eusa_silenced.gif' , 'Silenced' )

 SET IDENTITY_INSERT [yaf_Smiley] OFF

 if exists (select * from sysobjects where id = OBJECT_ID('[yaf_Topic]') and OBJECTPROPERTY(id, 'IsUserTable') = 1) DROP TABLE [yaf_Topic] 
 CREATE TABLE [yaf_Topic] (  [TopicID] [int] IDENTITY (1, 1) NOT NULL ,  [ForumID] [int] NOT NULL ,  [UserID] [int] NOT NULL , [UserName] [nvarchar] (50) NULL , [Posted] [datetime]  NOT NULL , [Topic] [nvarchar] (128) NOT NULL ,  [Views] [int] NOT NULL , [Priority] [smallint] NOT NULL ,  [PollID] [int] NULL ,  [TopicMovedID] [int] NULL , [LastPosted] [datetime]  NULL ,  [LastMessageID] [int] NULL ,  [LastUserID] [int] NULL , [LastUserName] [nvarchar] (50) NULL ,  [NumPosts] [int] NOT NULL ,  [Flags] [int] NOT NULL ,  [DigestLevel] [int] NULL ,  [ApproveStatus] [int] NULL ,  [HasAttachments] [int] NULL )
 ALTER TABLE [yaf_Topic] WITH NOCHECK ADD CONSTRAINT [DF_yaf_Topic_Flags] DEFAULT ((0)) FOR [Flags],CONSTRAINT [DF_yaf_Topic_DigestLevel] DEFAULT ((0)) FOR [DigestLevel],CONSTRAINT [DF_yaf_Topic_ApproveStatus] DEFAULT ((0)) FOR [ApproveStatus],CONSTRAINT [DF_yaf_Topic_HasAttachments] DEFAULT ((0)) FOR [HasAttachments],CONSTRAINT [PK_yaf_Topic] PRIMARY KEY  NONCLUSTERED ( [TopicID] )

 SET IDENTITY_INSERT [yaf_Topic] ON

 INSERT [yaf_Topic] ( [TopicID] , [ForumID] , [UserID] , [Posted] , [Topic] , [Views] , [Priority] , [NumPosts] , [Flags] , [DigestLevel] , [ApproveStatus] , [HasAttachments] ) VALUES ( 19 , 1 , 2 , '2008-05-09 23:36:07.280' , 'EntLib Web Server Monitor v1.0 正式发布！可供免费下载！ ' , 44 , 0 , 0 , 8 , 1 , 1 , 1 )
 INSERT [yaf_Topic] ( [TopicID] , [ForumID] , [UserID] , [Posted] , [Topic] , [Views] , [Priority] , [LastPosted] , [LastMessageID] , [LastUserID] , [NumPosts] , [Flags] , [DigestLevel] , [HasAttachments] ) VALUES ( 20 , 9 , 2 , '2008-05-10 19:26:18.810' , 'EntLib.com Forum 系统(汉化YAF论坛) 发布版本v2.0' , 18 , 0 , '2009-11-02 16:10:42.517' , 132 , 2 , 3 , 0 , 2 , 1 )
 INSERT [yaf_Topic] ( [TopicID] , [ForumID] , [UserID] , [Posted] , [Topic] , [Views] , [Priority] , [NumPosts] , [Flags] , [DigestLevel] , [HasAttachments] ) VALUES ( 21 , 8 , 2 , '2008-05-16 16:51:37.170' , 'FCKEditor asp.net设置' , 6 , 0 , 0 , 8 , 2 , 0 )
 INSERT [yaf_Topic] ( [TopicID] , [ForumID] , [UserID] , [Posted] , [Topic] , [Views] , [Priority] , [NumPosts] , [Flags] , [DigestLevel] , [HasAttachments] ) VALUES ( 22 , 8 , 2 , '2008-05-16 16:55:32.793' , 'Unity 简单示例代码和向导' , 5 , 0 , 0 , 8 , 2 , 0 )
 INSERT [yaf_Topic] ( [TopicID] , [ForumID] , [UserID] , [Posted] , [Topic] , [Views] , [Priority] , [NumPosts] , [Flags] , [DigestLevel] , [HasAttachments] ) VALUES ( 23 , 8 , 2 , '2008-05-16 16:57:01.060' , 'Unity 简单示例代码和向导/Unity Application Block' , 12 , 0 , 0 , 8 , 2 , 0 )
 INSERT [yaf_Topic] ( [TopicID] , [ForumID] , [UserID] , [Posted] , [Topic] , [Views] , [Priority] , [NumPosts] , [Flags] , [DigestLevel] , [HasAttachments] ) VALUES ( 24 , 8 , 14 , '2008-05-16 17:25:07.187' , 'Unity 简单示例代码和向导--2' , 13 , 0 , 0 , 8 , 2 , 0 )
 INSERT [yaf_Topic] ( [TopicID] , [ForumID] , [UserID] , [Posted] , [Topic] , [Views] , [Priority] , [LastPosted] , [LastMessageID] , [LastUserID] , [NumPosts] , [Flags] , [DigestLevel] , [ApproveStatus] , [HasAttachments] ) VALUES ( 25 , 7 , 14 , '2008-05-16 17:27:38.343' , 'Unity 简单示例代码和向导 -- 3' , 27 , 0 , '2008-09-08 22:53:46.933' , 120 , 2 , 6 , 0 , 2 , 1 , 0 )
 INSERT [yaf_Topic] ( [TopicID] , [ForumID] , [UserID] , [Posted] , [Topic] , [Views] , [Priority] , [NumPosts] , [Flags] , [DigestLevel] , [HasAttachments] ) VALUES ( 26 , 7 , 14 , '2008-05-16 23:43:32.623' , 'Giftcenter.cn' , 9 , 0 , 0 , 8 , 2 , 0 )
 INSERT [yaf_Topic] ( [TopicID] , [ForumID] , [UserID] , [Posted] , [Topic] , [Views] , [Priority] , [NumPosts] , [Flags] , [DigestLevel] , [ApproveStatus] , [HasAttachments] ) VALUES ( 27 , 1 , 14 , '2008-05-16 23:51:02.640' , 'create a new folder' , 21 , 0 , 0 , 8 , 2 , 0 , 1 )
 INSERT [yaf_Topic] ( [TopicID] , [ForumID] , [UserID] , [Posted] , [Topic] , [Views] , [Priority] , [NumPosts] , [Flags] , [DigestLevel] , [HasAttachments] ) VALUES ( 28 , 1 , 14 , '2008-05-17 11:00:16.513' , 'FCKEditor v2.6 ASP.NET下的配置和使用' , 43 , 0 , 0 , 8 , 2 , 1 )
 INSERT [yaf_Topic] ( [TopicID] , [ForumID] , [UserID] , [Posted] , [Topic] , [Views] , [Priority] , [NumPosts] , [Flags] , [DigestLevel] , [HasAttachments] ) VALUES ( 29 , 1 , 14 , '2008-05-17 11:52:06.687' , 'xml/html code' , 65 , 0 , 0 , 8 , 2 , 0 )
 INSERT [yaf_Topic] ( [TopicID] , [ForumID] , [UserID] , [Posted] , [Topic] , [Views] , [Priority] , [LastPosted] , [NumPosts] , [Flags] , [DigestLevel] , [HasAttachments] ) VALUES ( 30 , 1 , 2 , '2008-05-17 18:51:39.280' , '发新话题' , 19 , 0 , '2008-08-12 18:17:41.357' , 0 , 8 , 3 , 0 )
 INSERT [yaf_Topic] ( [TopicID] , [ForumID] , [UserID] , [Posted] , [Topic] , [Views] , [Priority] , [NumPosts] , [Flags] , [DigestLevel] , [ApproveStatus] , [HasAttachments] ) VALUES ( 31 , 1 , 2 , '2008-05-18 03:56:05.623' , '发新话题2' , 56 , 0 , 0 , 8 , 3 , 1 , 0 )
 INSERT [yaf_Topic] ( [TopicID] , [ForumID] , [UserID] , [Posted] , [Topic] , [Views] , [Priority] , [NumPosts] , [Flags] , [DigestLevel] , [HasAttachments] ) VALUES ( 32 , 1 , 2 , '2008-05-20 17:02:21.390' , '最新版FCKEditor在ASP.NET 环境下的配置及演示程序（附Demo程序）' , 36 , 0 , 0 , 8 , 1 , 0 )
 INSERT [yaf_Topic] ( [TopicID] , [ForumID] , [UserID] , [Posted] , [Topic] , [Views] , [Priority] , [LastPosted] , [LastMessageID] , [LastUserID] , [NumPosts] , [Flags] , [DigestLevel] , [HasAttachments] ) VALUES ( 33 , 9 , 2 , '2008-05-21 16:45:15.827' , '最新版FCKEditor在ASP.NET 环境下的配置及演示程序（附Demo程序）' , 6 , 0 , '2008-08-12 18:17:41.357' , 84 , 2 , 1 , 0 , 3 , 0 )
 INSERT [yaf_Topic] ( [TopicID] , [ForumID] , [UserID] , [Posted] , [Topic] , [Views] , [Priority] , [NumPosts] , [Flags] , [DigestLevel] , [HasAttachments] ) VALUES ( 34 , 1 , 2 , '2008-05-21 16:56:30.360' , '发新话题3' , 81 , 0 , 0 , 8 , 2 , 0 )
 INSERT [yaf_Topic] ( [TopicID] , [ForumID] , [UserID] , [Posted] , [Topic] , [Views] , [Priority] , [LastPosted] , [NumPosts] , [Flags] , [DigestLevel] , [HasAttachments] ) VALUES ( 35 , 9 , 2 , '2008-06-22 11:19:33.980' , '发新话题' , 5 , 0 , '2008-08-12 18:17:41.357' , 0 , 8 , 3 , 0 )
 INSERT [yaf_Topic] ( [TopicID] , [ForumID] , [UserID] , [Posted] , [Topic] , [Views] , [Priority] , [LastPosted] , [LastMessageID] , [LastUserID] , [NumPosts] , [Flags] , [DigestLevel] , [ApproveStatus] , [HasAttachments] ) VALUES ( 36 , 1 , 2 , '2008-08-10 11:53:36.390' , '最新版FCKEditor在ASP.NET 环境下的配置及演示程序（附Demo程序）' , 92 , 0 , '2008-08-12 18:17:41.357' , 116 , 2 , 26 , 0 , 2 , 1 , 0 )
 INSERT [yaf_Topic] ( [TopicID] , [ForumID] , [UserID] , [Posted] , [Topic] , [Views] , [Priority] , [NumPosts] , [Flags] , [DigestLevel] , [ApproveStatus] , [HasAttachments] ) VALUES ( 37 , 1 , 2 , '2008-09-08 23:01:28.310' , 'ABC - 软件系统发布 ' , 5 , 0 , 0 , 8 , 0 , 0 , 0 )
 INSERT [yaf_Topic] ( [TopicID] , [ForumID] , [UserID] , [Posted] , [Topic] , [Views] , [Priority] , [NumPosts] , [Flags] , [DigestLevel] , [ApproveStatus] , [HasAttachments] ) VALUES ( 38 , 1 , 2 , '2008-09-17 14:41:49.717' , 'test ' , 3 , 0 , 0 , 8 , 0 , 0 , 0 )
 INSERT [yaf_Topic] ( [TopicID] , [ForumID] , [UserID] , [Posted] , [Topic] , [Views] , [Priority] , [NumPosts] , [Flags] , [DigestLevel] , [ApproveStatus] , [HasAttachments] ) VALUES ( 39 , 1 , 2 , '2008-09-17 14:45:41.670' , 'FCKEditor v2.6.3' , 81 , 0 , 0 , 8 , 0 , 0 , 0 )
 INSERT [yaf_Topic] ( [TopicID] , [ForumID] , [UserID] , [Posted] , [Topic] , [Views] , [Priority] , [NumPosts] , [Flags] , [DigestLevel] , [ApproveStatus] , [HasAttachments] ) VALUES ( 40 , 1 , 2 , '2008-12-14 21:14:43.373' , '发新话题' , 5 , 0 , 0 , 8 , 0 , 0 , 0 )
 INSERT [yaf_Topic] ( [TopicID] , [ForumID] , [UserID] , [Posted] , [Topic] , [Views] , [Priority] , [NumPosts] , [Flags] , [DigestLevel] , [ApproveStatus] , [HasAttachments] ) VALUES ( 41 , 1 , 2 , '2008-12-17 18:21:35.810' , '测试POST 可显示内容' , 16 , 0 , 0 , 8 , 0 , 0 , 0 )
 INSERT [yaf_Topic] ( [TopicID] , [ForumID] , [UserID] , [Posted] , [Topic] , [Views] , [Priority] , [NumPosts] , [Flags] , [DigestLevel] , [ApproveStatus] , [HasAttachments] ) VALUES ( 42 , 1 , 2 , '2009-11-02 16:11:43.897' , '提高网页eCPM的技巧(Google Adsense)' , 12 , 2 , 0 , 8 , 0 , 0 , 1 )
 INSERT [yaf_Topic] ( [TopicID] , [ForumID] , [UserID] , [Posted] , [Topic] , [Views] , [Priority] , [NumPosts] , [Flags] , [DigestLevel] , [ApproveStatus] , [HasAttachments] ) VALUES ( 43 , 1 , 2 , '2009-11-24 15:52:33.967' , 'SQL SERVER 2008 SETUP' , 12 , 1 , 0 , 8 , 0 , 0 , 0 )
 INSERT [yaf_Topic] ( [TopicID] , [ForumID] , [UserID] , [Posted] , [Topic] , [Views] , [Priority] , [LastPosted] , [LastMessageID] , [LastUserID] , [NumPosts] , [Flags] , [DigestLevel] , [ApproveStatus] , [HasAttachments] ) VALUES ( 44 , 9 , 2 , '2009-11-25 16:38:22.990' , '发布EntLib.com Forum – 开源ASP.NET论坛 v4.0（提供源码下载）' , 3 , 2 , '2009-11-25 16:38:22.990' , 136 , 2 , 1 , 0 , 0 , 0 , 0 )
 INSERT [yaf_Topic] ( [TopicID] , [ForumID] , [UserID] , [Posted] , [Topic] , [Views] , [Priority] , [LastPosted] , [LastMessageID] , [LastUserID] , [NumPosts] , [Flags] , [DigestLevel] , [ApproveStatus] , [HasAttachments] ) VALUES ( 45 , 1 , 2 , '2009-11-25 16:39:33.743' , 'EntLib.com 电子商务系统 v2.0 – 前台购物网站/网店发布免费下载！' , 5 , 1 , '2009-11-25 17:05:35.363' , 139 , 2 , 2 , 0 , 0 , 0 , 0 )
 INSERT [yaf_Topic] ( [TopicID] , [ForumID] , [UserID] , [Posted] , [Topic] , [Views] , [Priority] , [LastPosted] , [LastMessageID] , [LastUserID] , [NumPosts] , [Flags] , [DigestLevel] , [ApproveStatus] , [HasAttachments] ) VALUES ( 46 , 8 , 2 , '2009-11-25 16:56:47.650' , '最新版 Enterprise Library 企业库 V4.1 中文学习手册 --- 最新提供PDF 整合文档下载！！！ ' , 1 , 0 , '2009-11-25 16:56:47.650' , 138 , 2 , 1 , 0 , 0 , 0 , 0 )

 SET IDENTITY_INSERT [yaf_Topic] OFF

 if exists (select * from sysobjects where id = OBJECT_ID('[yaf_User]') and OBJECTPROPERTY(id, 'IsUserTable') = 1) DROP TABLE [yaf_User] 
 CREATE TABLE [yaf_User] (  [UserID] [int] IDENTITY (1, 1) NOT NULL ,  [BoardID] [int] NOT NULL , [Name] [nvarchar] (50) NOT NULL , [Password] [nvarchar] (32) NOT NULL , [Email] [nvarchar] (50) NULL , [Joined] [datetime]  NOT NULL , [LastVisit] [datetime]  NOT NULL , [IP] [nvarchar] (15) NULL ,  [NumPosts] [int] NOT NULL , [Location] [nvarchar] (50) NULL , [HomePage] [nvarchar] (50) NULL ,  [TimeZone] [int] NOT NULL , [Avatar] [nvarchar] (255) NULL , [Signature] [ntext] NULL , [AvatarImage] [image] NULL ,  [RankID] [int] NOT NULL , [Suspended] [datetime]  NULL , [LanguageFile] [nvarchar] (50) NULL , [ThemeFile] [nvarchar] (50) NULL , [MSN] [nvarchar] (50) NULL , [YIM] [nvarchar] (30) NULL , [AIM] [nvarchar] (30) NULL ,  [ICQ] [int] NULL , [RealName] [nvarchar] (50) NULL , [Occupation] [nvarchar] (50) NULL , [Interests] [nvarchar] (100) NULL , [Gender] [tinyint] NOT NULL , [Weblog] [nvarchar] (100) NULL , [PMNotification] [bit] NOT NULL ,  [Flags] [int] NOT NULL ,  [Points] [int] NOT NULL )
 ALTER TABLE [yaf_User] WITH NOCHECK ADD CONSTRAINT [DF_yaf_User_PMNotification] DEFAULT ((1)) FOR [PMNotification],CONSTRAINT [DF_yaf_User_Flags] DEFAULT ((0)) FOR [Flags],CONSTRAINT [DF_yaf_User_Points] DEFAULT ((0)) FOR [Points],CONSTRAINT [PK_yaf_User] PRIMARY KEY  NONCLUSTERED ( [UserID] )
 CREATE UNIQUE INDEX [IX_yaf_User] ON [yaf_User] ( BoardID ,Name ) 

 SET IDENTITY_INSERT [yaf_User] ON

 INSERT [yaf_User] ( [UserID] , [BoardID] , [Name] , [Password] , [Email] , [Joined] , [LastVisit] , [IP] , [NumPosts] , [TimeZone] , [RankID] , [Gender] , [PMNotification] , [Flags] , [Points] ) VALUES ( 1 , 1 , 'Guest' , 'entlib.com' , 'entlibforum@hotmail.com' , '2008-04-28 21:04:28.230' , '2009-11-02 16:03:55.890' , '127.0.0.1' , 0 , 480 , 2 , 0 , 1 , 2 , 0 )
 INSERT [yaf_User] ( [UserID] , [BoardID] , [Name] , [Password] , [Email] , [Joined] , [LastVisit] , [IP] , [NumPosts] , [TimeZone] , [Avatar] , [Signature] , [RankID] , [LanguageFile] , [ThemeFile] , [MSN] , [Gender] , [PMNotification] , [Flags] , [Points] ) VALUES ( 2 , 1 , 'admin' , 'entlib.com' , 'entlib@hotmail.com' , '2008-04-28 21:04:28.230' , '2009-11-25 17:05:42.113' , '127.0.0.1' , 30 , 480 , 'http://localhost:1201/images/avatars/EntLibLogo/entlib120.gif' , 'www.entlib.com - 最专业的中文电子商务系统。' , 1 , 'china.xml' , 'ASPNet.xml' , 'rickiechina@hotmail.com' , 0 , 1 , 3 , -44 )
 INSERT [yaf_User] ( [UserID] , [BoardID] , [Name] , [Password] , [Email] , [Joined] , [LastVisit] , [IP] , [NumPosts] , [TimeZone] , [RankID] , [Gender] , [PMNotification] , [Flags] , [Points] ) VALUES ( 14 , 1 , 'helloworld' , 'entlib.com' , 'abc@hotmail.com' , '2008-05-16 17:22:42.670' , '2008-09-06 22:01:20.177' , '127.0.0.1' , 0 , 480 , 4 , 0 , 1 , 2 , -48 )
 INSERT [yaf_User] ( [UserID] , [BoardID] , [Name] , [Password] , [Email] , [Joined] , [LastVisit] , [NumPosts] , [Location] , [HomePage] , [TimeZone] , [RankID] , [Gender] , [PMNotification] , [Flags] , [Points] ) VALUES ( 15 , 1 , 'abc' , 'entlib.com' , 'donews@hotmail.com' , '2008-08-17 19:15:01.730' , '2008-08-17 19:15:01.730' , 0 , 'a' , 'a' , 480 , 3 , 0 , 1 , 2 , 0 )
 INSERT [yaf_User] ( [UserID] , [BoardID] , [Name] , [Password] , [Email] , [Joined] , [LastVisit] , [NumPosts] , [TimeZone] , [RankID] , [Gender] , [PMNotification] , [Flags] , [Points] ) VALUES ( 16 , 1 , 'aabc' , 'entlib.com' , 'a@hotmail.com' , '2008-08-17 19:17:42.997' , '2008-08-17 19:17:42.997' , 0 , 480 , 3 , 0 , 1 , 2 , 0 )
 INSERT [yaf_User] ( [UserID] , [BoardID] , [Name] , [Password] , [Email] , [Joined] , [LastVisit] , [IP] , [NumPosts] , [TimeZone] , [RankID] , [Gender] , [PMNotification] , [Flags] , [Points] ) VALUES ( 17 , 1 , 'jacky' , 'entlib.com' , 'jacky@hotmail.com' , '2008-12-14 20:40:27.280' , '2008-12-14 20:40:47.857' , '127.0.0.1' , 0 , 480 , 3 , 0 , 1 , 2 , 0 )

 SET IDENTITY_INSERT [yaf_User] OFF

 if exists (select * from sysobjects where id = OBJECT_ID('[yaf_UserForum]') and OBJECTPROPERTY(id, 'IsUserTable') = 1) DROP TABLE [yaf_UserForum] 
 CREATE TABLE [yaf_UserForum] (  [UserID] [int] NOT NULL ,  [ForumID] [int] NOT NULL ,  [AccessMaskID] [int] NOT NULL , [Invited] [datetime]  NOT NULL , [Accepted] [bit] NOT NULL )
 ALTER TABLE [yaf_UserForum] WITH NOCHECK ADD CONSTRAINT [PK_yaf_UserForum] PRIMARY KEY CLUSTERED ( [UserID],ForumID ) 

 INSERT [yaf_UserForum] ( [UserID] , [ForumID] , [AccessMaskID] , [Invited] , [Accepted] ) VALUES ( 14 , 1 , 2 , '2008-09-06 07:11:53.920' , 1 )

 if exists (select * from sysobjects where id = OBJECT_ID('[yaf_UserGroup]') and OBJECTPROPERTY(id, 'IsUserTable') = 1) DROP TABLE [yaf_UserGroup] 
 CREATE TABLE [yaf_UserGroup] (  [UserID] [int] NOT NULL ,  [GroupID] [int] NOT NULL )
 ALTER TABLE [yaf_UserGroup] WITH NOCHECK ADD CONSTRAINT [PK_yaf_UserGroup] PRIMARY KEY  CLUSTERED ( [UserID],GroupID ) 

 INSERT [yaf_UserGroup] ( [UserID] , [GroupID] ) VALUES ( 1 , 2 )
 INSERT [yaf_UserGroup] ( [UserID] , [GroupID] ) VALUES ( 2 , 1 )
 INSERT [yaf_UserGroup] ( [UserID] , [GroupID] ) VALUES ( 14 , 3 )
 INSERT [yaf_UserGroup] ( [UserID] , [GroupID] ) VALUES ( 15 , 3 )
 INSERT [yaf_UserGroup] ( [UserID] , [GroupID] ) VALUES ( 16 , 3 )
 INSERT [yaf_UserGroup] ( [UserID] , [GroupID] ) VALUES ( 17 , 3 )

 if exists (select * from sysobjects where id = OBJECT_ID('[yaf_UserPMessage]') and OBJECTPROPERTY(id, 'IsUserTable') = 1) DROP TABLE [yaf_UserPMessage] 
 CREATE TABLE [yaf_UserPMessage] (  [UserPMessageID] [int] IDENTITY (1, 1) NOT NULL ,  [UserID] [int] NOT NULL ,  [PMessageID] [int] NOT NULL , [IsRead] [bit] NOT NULL )
 ALTER TABLE [yaf_UserPMessage] WITH NOCHECK ADD CONSTRAINT [PK_yaf_UserPMessage] PRIMARY KEY  NONCLUSTERED ( [UserPMessageID] )

 if exists (select * from sysobjects where id = OBJECT_ID('[yaf_WatchForum]') and OBJECTPROPERTY(id, 'IsUserTable') = 1) DROP TABLE [yaf_WatchForum] 
 CREATE TABLE [yaf_WatchForum] (  [WatchForumID] [int] IDENTITY (1, 1) NOT NULL ,  [ForumID] [int] NOT NULL ,  [UserID] [int] NOT NULL , [Created] [datetime]  NOT NULL , [LastMail] [datetime]  NULL )
 ALTER TABLE [yaf_WatchForum] WITH NOCHECK ADD CONSTRAINT [PK_yaf_WatchForum] PRIMARY KEY  NONCLUSTERED ( [WatchForumID] )
 CREATE UNIQUE INDEX [IX_yaf_WatchForum] ON [yaf_WatchForum] ( ForumID ,UserID ) 

 if exists (select * from sysobjects where id = OBJECT_ID('[yaf_WatchTopic]') and OBJECTPROPERTY(id, 'IsUserTable') = 1) DROP TABLE [yaf_WatchTopic] 
 CREATE TABLE [yaf_WatchTopic] (  [WatchTopicID] [int] IDENTITY (1, 1) NOT NULL ,  [TopicID] [int] NOT NULL ,  [UserID] [int] NOT NULL , [Created] [datetime]  NOT NULL , [LastMail] [datetime]  NULL )
 ALTER TABLE [yaf_WatchTopic] WITH NOCHECK ADD CONSTRAINT [PK_yaf_WatchTopic] PRIMARY KEY  NONCLUSTERED ( [WatchTopicID] )
 CREATE UNIQUE INDEX [IX_yaf_WatchTopic] ON [yaf_WatchTopic] ( TopicID ,UserID ) 

USE [EntLib_BBS]
GO

/****** Object:  View [dbo].[yaf_vaccess]    Script Date: 11/25/2009 19:04:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[yaf_vaccess]
AS
  SELECT   UserID = a.UserID,
           ForumID = x.ForumID,
           IsAdmin = MAX(CONVERT(INT,b.Flags & 1)),
           IsGuest = MAX(CONVERT(INT,b.Flags & 2)),
           IsForumModerator = MAX(CONVERT(INT,b.Flags & 8)),
           IsModerator = (SELECT COUNT(1)
                          FROM   dbo.yaf_UserGroup v,
                                 dbo.yaf_Group w,
                                 dbo.yaf_ForumAccess x,
                                 dbo.yaf_AccessMask y
                          WHERE  v.UserID = a.UserID
                          AND w.GroupID = v.GroupID
                          AND x.GroupID = w.GroupID
                          AND y.AccessMaskID = x.AccessMaskID
                          AND (y.Flags & 64) <> 0),
           ReadAccess = MAX(x.ReadAccess),
           PostAccess = MAX(x.PostAccess),
           ReplyAccess = MAX(x.ReplyAccess),
           PriorityAccess = MAX(x.PriorityAccess),
           PollAccess = MAX(x.PollAccess),
           VoteAccess = MAX(x.VoteAccess),
           ModeratorAccess = MAX(x.ModeratorAccess),
           EditAccess = MAX(x.EditAccess),
           DeleteAccess = MAX(x.DeleteAccess),
           UploadAccess = MAX(x.UploadAccess)
  FROM     (SELECT b.UserID,
                   b.ForumID,
                   ReadAccess = CONVERT(INT,c.Flags & 1),
                   PostAccess = CONVERT(INT,c.Flags & 2),
                   ReplyAccess = CONVERT(INT,c.Flags & 4),
                   PriorityAccess = CONVERT(INT,c.Flags & 8),
                   PollAccess = CONVERT(INT,c.Flags & 16),
                   VoteAccess = CONVERT(INT,c.Flags & 32),
                   ModeratorAccess = CONVERT(INT,c.Flags & 64),
                   EditAccess = CONVERT(INT,c.Flags & 128),
                   DeleteAccess = CONVERT(INT,c.Flags & 256),
                   UploadAccess = CONVERT(INT,c.Flags & 512)
            FROM   dbo.yaf_UserForum b
                   JOIN dbo.yaf_AccessMask c
                     ON c.AccessMaskID = b.AccessMaskID
            UNION 
            SELECT b.UserID,
                   c.ForumID,
                   ReadAccess = CONVERT(INT,d.Flags & 1),
                   PostAccess = CONVERT(INT,d.Flags & 2),
                   ReplyAccess = CONVERT(INT,d.Flags & 4),
                   PriorityAccess = CONVERT(INT,d.Flags & 8),
                   PollAccess = CONVERT(INT,d.Flags & 16),
                   VoteAccess = CONVERT(INT,d.Flags & 32),
                   ModeratorAccess = CONVERT(INT,d.Flags & 64),
                   EditAccess = CONVERT(INT,d.Flags & 128),
                   DeleteAccess = CONVERT(INT,d.Flags & 256),
                   UploadAccess = CONVERT(INT,d.Flags & 512)
            FROM   dbo.yaf_UserGroup b
                   JOIN dbo.yaf_ForumAccess c
                     ON c.GroupID = b.GroupID
                   JOIN dbo.yaf_AccessMask d
                     ON d.AccessMaskID = c.AccessMaskID
            UNION 
            SELECT a.UserID,
                   ForumID = CONVERT(INT,0),
                   ReadAccess = CONVERT(INT,0),
                   PostAccess = CONVERT(INT,0),
                   ReplyAccess = CONVERT(INT,0),
                   PriorityAccess = CONVERT(INT,0),
                   PollAccess = CONVERT(INT,0),
                   VoteAccess = CONVERT(INT,0),
                   ModeratorAccess = CONVERT(INT,0),
                   EditAccess = CONVERT(INT,0),
                   DeleteAccess = CONVERT(INT,0),
                   UploadAccess = CONVERT(INT,0)
            FROM   dbo.yaf_User a) AS x
           JOIN dbo.yaf_UserGroup a
             ON a.UserID = x.UserID
           JOIN dbo.yaf_Group b
             ON b.GroupID = a.GroupID
  GROUP BY a.UserID,x.ForumID
GO


