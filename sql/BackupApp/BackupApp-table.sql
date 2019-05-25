USE [BackupApp]
GO

/****** Object:  Table [dbo].[Backup_Error_log]    Script Date: 2019/5/25 14:12:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Backup_Error_log](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[dbname] [varchar](50) NULL,
	[backuptype] [int] NULL,
	[errordate] [datetime] NULL,
	[errormessage] [varchar](500) NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[BackupDIFF_config]    Script Date: 2019/5/25 14:12:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[BackupDIFF_config](
	[dbname] [varchar](50) NOT NULL,
	[backuphour] [tinyint] NULL,
 CONSTRAINT [pk_test] PRIMARY KEY CLUSTERED 
(
	[dbname] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[BackupFull_config]    Script Date: 2019/5/25 14:12:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[BackupFull_config](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[dbname] [varchar](50) NULL,
	[backup_week] [tinyint] NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[BackupInnerTable]    Script Date: 2019/5/25 14:12:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[BackupInnerTable](
	[DBName] [varchar](125) NOT NULL,
	[TBName] [varchar](125) NOT NULL,
 CONSTRAINT [PK_BackupInnerTable] PRIMARY KEY CLUSTERED 
(
	[DBName] ASC,
	[TBName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[BackupWeb_History]    Script Date: 2019/5/25 14:12:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[BackupWeb_History](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[KID] [int] NULL,
	[Oper] [varchar](50) NULL,
	[OperBgnTime] [datetime] NOT NULL,
	[OperEndTime] [datetime] NULL,
	[Result] [int] NOT NULL,
	[ProcName] [varchar](50) NULL,
	[Msg] [varchar](max) NULL,
	[type] [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[BackupWebInfo]    Script Date: 2019/5/25 14:12:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[BackupWebInfo](
	[kid] [int] NOT NULL,
	[VersionNo] [int] NOT NULL,
	[BackupDate] [datetime] NULL,
 CONSTRAINT [PK_BackupWebInfo] PRIMARY KEY CLUSTERED 
(
	[kid] ASC,
	[VersionNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Basicdata_child]    Script Date: 2019/5/25 14:12:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Basicdata_child](
	[userid] [int] NOT NULL,
	[fathername] [nvarchar](50) NULL,
	[mothername] [nvarchar](50) NULL,
	[favouritething] [nvarchar](500) NULL,
	[fearthing] [nvarchar](500) NULL,
	[favouritefoot] [nvarchar](500) NULL,
	[footdrugallergic] [nvarchar](500) NULL,
	[vipstatus] [int] NULL,
	[VersionNo] [int] NOT NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Basicdata_ChildDetails]    Script Date: 2019/5/25 14:12:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Basicdata_ChildDetails](
	[ID] [int] NOT NULL,
	[uid] [int] NOT NULL,
	[ename] [varchar](50) NULL,
	[cardtype] [varchar](50) NULL,
	[cardno] [varchar](50) NULL,
	[hometown] [nvarchar](500) NULL,
	[householdtype] [varchar](50) NULL,
	[householdaddress] [nvarchar](2000) NULL,
	[isone] [varchar](20) NULL,
	[isstay] [varchar](20) NULL,
	[iscity] [varchar](20) NULL,
	[isdis] [varchar](20) NULL,
	[distype] [varchar](20) NULL,
	[isboarding] [varchar](20) NULL,
	[isonly] [varchar](20) NULL,
	[isdown] [varchar](20) NULL,
	[isaccept] [varchar](20) NULL,
	[parentname1] [nvarchar](50) NULL,
	[parentcardno1] [nvarchar](50) NULL,
	[parentname2] [nvarchar](50) NULL,
	[parentcardno2] [nvarchar](50) NULL,
	[nation] [nvarchar](50) NULL,
	[overseas] [nvarchar](50) NULL,
	[country] [nvarchar](50) NULL,
	[cardtype1] [nvarchar](50) NULL,
	[cardtype2] [nvarchar](50) NULL,
	[address] [nvarchar](350) NULL,
	[VersionNo] [int] NOT NULL,
	[profession] [varchar](max) NULL,
	[education] [varchar](max) NULL,
	[income] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Basicdata_class]    Script Date: 2019/5/25 14:12:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Basicdata_class](
	[cid] [int] NOT NULL,
	[kid] [int] NOT NULL,
	[cname] [nvarchar](20) NOT NULL,
	[grade] [int] NULL,
	[order] [int] NULL,
	[deletetag] [int] NOT NULL,
	[sname] [nvarchar](20) NULL,
	[actiondate] [datetime] NULL,
	[iscurrent] [int] NULL,
	[subno] [int] NULL,
	[VersionNo] [int] NOT NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Basicdata_department]    Script Date: 2019/5/25 14:12:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Basicdata_department](
	[did] [int] NOT NULL,
	[dname] [nvarchar](100) NOT NULL,
	[superior] [int] NULL,
	[order] [int] NULL,
	[deletetag] [int] NULL,
	[kid] [int] NULL,
	[actiondatetime] [datetime] NULL,
	[VersionNo] [int] NOT NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Basicdata_kindergarten]    Script Date: 2019/5/25 14:12:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Basicdata_kindergarten](
	[kid] [int] NOT NULL,
	[kname] [nvarchar](200) NULL,
	[address] [nvarchar](300) NULL,
	[privince] [int] NOT NULL,
	[city] [int] NOT NULL,
	[area] [int] NULL,
	[deletetag] [int] NOT NULL,
	[actiondate] [datetime] NULL,
	[telephone] [nvarchar](100) NULL,
	[qq] [nvarchar](100) NULL,
	[opentype] [int] NULL,
	[citytype] [int] NULL,
	[kintype] [int] NULL,
	[residence] [int] NULL,
	[mastername] [nvarchar](100) NULL,
	[synstatus] [int] NULL,
	[jxsnum] [varchar](20) NULL,
	[VersionNo] [int] NOT NULL,
	[NGB_Descript] [varchar](max) NULL,
	[NGB_Pic] [varchar](max) NULL,
	[BoxStatus] [int] NULL,
	[ShareMod] [numeric](9, 2) NULL,
	[proxyid] [smallint] NULL,
	[video_monitor_desc] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Basicdata_leave_kindergarten]    Script Date: 2019/5/25 14:12:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Basicdata_leave_kindergarten](
	[ID] [bigint] NOT NULL,
	[kid] [int] NOT NULL,
	[userid] [int] NOT NULL,
	[leavereason] [varchar](100) NULL,
	[outtime] [datetime] NOT NULL,
	[VersionNo] [int] NOT NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Basicdata_MainPageList]    Script Date: 2019/5/25 14:12:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Basicdata_MainPageList](
	[ID] [bigint] NOT NULL,
	[kid] [int] NULL,
	[userid] [int] NULL,
	[type] [int] NULL,
	[Tag] [int] NULL,
	[TagValue] [bigint] NULL,
	[CrtDate] [datetime] NULL,
	[Status] [int] NULL,
	[CDate] [date] NULL,
	[VersionNo] [int] NOT NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Basicdata_teacher]    Script Date: 2019/5/25 14:12:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Basicdata_teacher](
	[userid] [int] NOT NULL,
	[did] [int] NULL,
	[title] [nvarchar](20) NULL,
	[post] [nvarchar](20) NULL,
	[education] [nvarchar](20) NULL,
	[employmentform] [nvarchar](20) NULL,
	[politicalface] [nvarchar](20) NULL,
	[kinschooltag] [int] NULL,
	[orderno] [int] NULL,
	[VersionNo] [int] NOT NULL,
	[ieep_rank] [nvarchar](max) NULL,
	[ieep_info] [nvarchar](max) NULL,
	[ieep_reward] [int] NULL,
	[ieep_num] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Basicdata_TeacherDetails]    Script Date: 2019/5/25 14:12:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Basicdata_TeacherDetails](
	[ID] [int] NOT NULL,
	[uid] [int] NULL,
	[ename] [varchar](50) NULL,
	[cardtype] [varchar](50) NULL,
	[cardno] [varchar](50) NULL,
	[hometown] [varchar](500) NULL,
	[country] [varchar](50) NULL,
	[nativeplace] [varchar](50) NULL,
	[overseas] [varchar](50) NULL,
	[householdtype] [varchar](50) NULL,
	[householdaddress] [varchar](2000) NULL,
	[establishment] [varchar](50) NULL,
	[isedu] [varchar](20) NULL,
	[teacherno] [varchar](50) NULL,
	[workdate] [varchar](50) NULL,
	[healthinfo] [varchar](200) NULL,
	[income] [int] NULL,
	[social] [varchar](20) NULL,
	[pension] [varchar](20) NULL,
	[medical] [varchar](20) NULL,
	[nation] [varchar](50) NULL,
	[address] [nvarchar](500) NULL,
	[lastyearinfo] [nvarchar](50) NULL,
	[basemoney] [int] NULL,
	[lastyearmoney] [int] NULL,
	[ishousingreserve] [nvarchar](30) NULL,
	[isteachercert] [nvarchar](30) NULL,
	[issuingauthority] [nvarchar](30) NULL,
	[teachercerttype] [nvarchar](30) NULL,
	[islostinsurance] [nvarchar](30) NULL,
	[isbusinessinsurance] [nvarchar](30) NULL,
	[isbirthinsurance] [nvarchar](30) NULL,
	[otherallowances] [int] NULL,
	[achievements] [nvarchar](30) NULL,
	[VersionNo] [int] NOT NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Basicdata_user]    Script Date: 2019/5/25 14:12:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Basicdata_user](
	[userid] [int] NOT NULL,
	[account] [nvarchar](50) NOT NULL,
	[password] [nvarchar](50) NOT NULL,
	[usertype] [int] NULL,
	[deletetag] [int] NULL,
	[regdatetime] [datetime] NULL,
	[lastlogindatetime] [datetime] NULL,
	[network] [int] NULL,
	[kid] [int] NULL,
	[VersionNo] [int] NOT NULL,
	[name] [nvarchar](max) NULL,
	[nickname] [nvarchar](max) NULL,
	[birthday] [datetime] NULL,
	[gender] [int] NULL,
	[nation] [int] NULL,
	[mobile] [nvarchar](max) NULL,
	[email] [nvarchar](max) NULL,
	[address] [nvarchar](max) NULL,
	[enrollmentdate] [datetime] NULL,
	[exigencetelphone] [nvarchar](max) NULL,
	[headpicupdate] [datetime] NULL,
	[headpic] [nvarchar](max) NULL,
	[privince] [int] NULL,
	[city] [int] NULL,
	[istip] [bit] NULL,
	[residence] [int] NULL,
	[tiprule] [nvarchar](max) NULL,
	[gbstatus] [int] NULL,
	[enrollmentreason] [varchar](max) NULL,
	[smsport] [int] NULL,
	[updatetime] [datetime] NULL,
	[NGB_gbVersionTag] [int] NULL,
	[deletedatetime] [datetime] NULL,
	[tts] [varchar](max) NULL,
	[RoleType] [int] NULL,
	[NJType] [int] NULL,
	[ReadRight] [int] NULL,
	[IsNeedTransferPassword] [bit] NULL,
	[LqRight] [int] NULL,
	[mc_photo_udate] [datetime] NULL,
	[addtype] [smallint] NULL,
	[sname] [nvarchar](max) NULL,
	[jzxxgrade] [int] NULL,
	[proxyid] [smallint] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Basicdata_user_baseinfo]    Script Date: 2019/5/25 14:12:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Basicdata_user_baseinfo](
	[userid] [int] NOT NULL,
	[name] [nvarchar](50) NULL,
	[nickname] [nvarchar](50) NULL,
	[birthday] [datetime] NULL,
	[gender] [int] NULL,
	[nation] [int] NULL,
	[mobile] [nvarchar](50) NULL,
	[email] [nvarchar](100) NULL,
	[address] [nvarchar](200) NULL,
	[enrollmentdate] [datetime] NULL,
	[exigencetelphone] [nvarchar](50) NULL,
	[headpicupdate] [datetime] NULL,
	[headpic] [nvarchar](200) NULL,
	[privince] [int] NULL,
	[city] [int] NULL,
	[istip] [bit] NULL,
	[residence] [int] NULL,
	[tiprule] [nvarchar](50) NULL,
	[network] [int] NULL,
	[gbstatus] [int] NULL,
	[enrollmentreason] [varchar](50) NULL,
	[smsport] [int] NULL,
	[updatetime] [datetime] NULL,
	[VersionNo] [int] NOT NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Basicdata_user_bloguser]    Script Date: 2019/5/25 14:12:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Basicdata_user_bloguser](
	[userid] [int] NOT NULL,
	[bloguserid] [int] NOT NULL,
	[VersionNo] [int] NOT NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Basicdata_user_class]    Script Date: 2019/5/25 14:12:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Basicdata_user_class](
	[cid] [int] NOT NULL,
	[userid] [int] NOT NULL,
	[VersionNo] [int] NOT NULL,
	[ucid] [bigint] NULL,
	[order] [int] NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[BlogApp_album_categories]    Script Date: 2019/5/25 14:12:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[BlogApp_album_categories](
	[categoriesid] [int] NOT NULL,
	[userid] [int] NULL,
	[title] [nvarchar](50) NULL,
	[description] [nvarchar](100) NULL,
	[displayorder] [int] NULL,
	[albumdispstatus] [int] NULL,
	[photocount] [int] NULL,
	[createdatetime] [datetime] NULL,
	[isclassdisplay] [int] NULL,
	[classid] [int] NULL,
	[orderno] [int] NULL,
	[viewpermission] [nvarchar](20) NULL,
	[coverphoto] [nvarchar](700) NULL,
	[coverphotodatetime] [datetime] NULL,
	[deletetag] [int] NULL,
	[net] [int] NULL,
	[VersionNo] [int] NOT NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[BlogApp_album_photos]    Script Date: 2019/5/25 14:12:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[BlogApp_album_photos](
	[photoid] [int] NOT NULL,
	[categoriesid] [int] NOT NULL,
	[title] [nvarchar](100) NULL,
	[filename] [nvarchar](200) NULL,
	[filepath] [nvarchar](500) NULL,
	[filesize] [int] NULL,
	[viewcount] [int] NULL,
	[commentcount] [int] NULL,
	[uploaddatetime] [datetime] NULL,
	[iscover] [int] NULL,
	[isflashshow] [int] NULL,
	[orderno] [int] NULL,
	[deletetag] [int] NULL,
	[net] [int] NULL,
	[VersionNo] [int] NOT NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[BlogApp_blog_baseconfig]    Script Date: 2019/5/25 14:12:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[BlogApp_blog_baseconfig](
	[userid] [int] NOT NULL,
	[blogtitle] [nvarchar](100) NULL,
	[description] [nvarchar](200) NULL,
	[defaultdispmode] [int] NULL,
	[postdispcount] [int] NULL,
	[themes] [int] NULL,
	[messagepref] [int] NULL,
	[postscount] [int] NULL,
	[albumcount] [int] NULL,
	[photocount] [int] NULL,
	[visitscount] [int] NULL,
	[createdatetime] [datetime] NULL,
	[updatedatetime] [datetime] NULL,
	[lastposttitle] [nvarchar](100) NULL,
	[lastpostid] [int] NULL,
	[blogtype] [int] NULL,
	[blogurl] [nvarchar](50) NULL,
	[integral] [bigint] NULL,
	[iskmpuser] [int] NULL,
	[kininfohide] [int] NULL,
	[isstart] [int] NULL,
	[posttoclassdefault] [int] NULL,
	[commentpermission] [int] NULL,
	[openblogquestion] [nvarchar](30) NULL,
	[openbloganswer] [nvarchar](30) NULL,
	[messagepermission] [int] NULL,
	[postviewpermission] [int] NULL,
	[albumviewpermission] [int] NULL,
	[photowatermark] [nvarchar](50) NULL,
	[VersionNo] [int] NOT NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[BlogApp_blog_collection]    Script Date: 2019/5/25 14:12:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[BlogApp_blog_collection](
	[collectionid] [int] NOT NULL,
	[userid] [int] NULL,
	[postid] [int] NULL,
	[createdatetime] [datetime] NULL,
	[VersionNo] [int] NOT NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[BlogApp_blog_friendapply]    Script Date: 2019/5/25 14:12:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[BlogApp_blog_friendapply](
	[friendapplyid] [int] NOT NULL,
	[sourceuserid] [int] NULL,
	[targetuserid] [int] NULL,
	[applystatus] [int] NULL,
	[remark] [nvarchar](100) NULL,
	[invitetime] [datetime] NULL,
	[VersionNo] [int] NOT NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[BlogApp_blog_friendlist]    Script Date: 2019/5/25 14:12:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[BlogApp_blog_friendlist](
	[userid] [int] NOT NULL,
	[frienduserid] [int] NOT NULL,
	[updatetime] [datetime] NULL,
	[VersionNo] [int] NOT NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[BlogApp_blog_hotposts]    Script Date: 2019/5/25 14:12:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[BlogApp_blog_hotposts](
	[hotpostid] [int] NOT NULL,
	[maintitle] [nvarchar](100) NULL,
	[subtitle] [nvarchar](100) NULL,
	[mainurl] [nvarchar](200) NULL,
	[suburl] [nvarchar](200) NULL,
	[orderno] [int] NULL,
	[posttype] [int] NULL,
	[createdate] [datetime] NULL,
	[postid] [int] NULL,
	[istop] [int] NULL,
	[hottype] [int] NULL,
	[VersionNo] [int] NOT NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[BlogApp_blog_messageboard]    Script Date: 2019/5/25 14:12:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[BlogApp_blog_messageboard](
	[messageboardid] [int] NOT NULL,
	[userid] [int] NULL,
	[fromuserid] [int] NULL,
	[author] [nvarchar](50) NULL,
	[content] [ntext] NULL,
	[msgstatus] [int] NULL,
	[msgdatetime] [datetime] NULL,
	[parentid] [int] NULL,
	[VersionNo] [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[BlogApp_blog_messagebox]    Script Date: 2019/5/25 14:12:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[BlogApp_blog_messagebox](
	[messageboxid] [int] NOT NULL,
	[touserid] [int] NULL,
	[fromuserid] [int] NULL,
	[msgtitle] [nvarchar](30) NULL,
	[msgcontent] [ntext] NULL,
	[sendtime] [datetime] NULL,
	[viewstatus] [int] NULL,
	[VersionNo] [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[BlogApp_blog_posts]    Script Date: 2019/5/25 14:12:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[BlogApp_blog_posts](
	[postid] [int] NOT NULL,
	[author] [nvarchar](20) NULL,
	[userid] [int] NULL,
	[postdatetime] [datetime] NULL,
	[title] [nvarchar](30) NULL,
	[content] [ntext] NULL,
	[poststatus] [int] NULL,
	[categoriesid] [int] NULL,
	[commentstatus] [int] NULL,
	[IsTop] [bit] NULL,
	[IsSoul] [bit] NULL,
	[postupdatetime] [datetime] NULL,
	[commentcount] [int] NULL,
	[viewcounts] [int] NULL,
	[smile] [nvarchar](30) NULL,
	[IsHot] [int] NULL,
	[viewpermission] [int] NULL,
	[deletetag] [int] NULL,
	[isfristpage] [bit] NULL,
	[VersionNo] [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[BlogApp_blog_postscategories]    Script Date: 2019/5/25 14:12:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[BlogApp_blog_postscategories](
	[categoresid] [int] NOT NULL,
	[userid] [int] NULL,
	[title] [nvarchar](30) NULL,
	[description] [nvarchar](100) NULL,
	[displayorder] [int] NULL,
	[postcount] [int] NULL,
	[createdatetime] [datetime] NULL,
	[VersionNo] [int] NOT NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[BlogApp_blog_postscomments]    Script Date: 2019/5/25 14:12:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[BlogApp_blog_postscomments](
	[commentsid] [int] NOT NULL,
	[postsid] [int] NULL,
	[fromuserid] [int] NULL,
	[author] [nvarchar](50) NULL,
	[commentdatetime] [datetime] NULL,
	[content] [nvarchar](500) NULL,
	[parentid] [int] NULL,
	[approve] [int] NULL,
	[private] [int] NULL,
	[VersionNo] [int] NOT NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[ClassApp_class_album]    Script Date: 2019/5/25 14:12:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ClassApp_class_album](
	[albumid] [int] NOT NULL,
	[title] [nvarchar](50) NULL,
	[description] [char](100) NULL,
	[photocount] [int] NULL,
	[classid] [int] NULL,
	[kid] [int] NULL,
	[userid] [int] NULL,
	[author] [nvarchar](50) NULL,
	[createdatetime] [datetime] NULL,
	[status] [int] NULL,
	[coverphoto] [nvarchar](700) NULL,
	[coverphotodatetime] [datetime] NULL,
	[net] [int] NULL,
	[lastuploadtime] [datetime] NULL,
	[VersionNo] [int] NOT NULL,
	[yp] [int] NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[ClassApp_class_article]    Script Date: 2019/5/25 14:12:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ClassApp_class_article](
	[articleid] [int] NOT NULL,
	[diycategoryid] [int] NULL,
	[title] [nvarchar](100) NULL,
	[userid] [int] NULL,
	[author] [nvarchar](50) NULL,
	[classid] [int] NULL,
	[kid] [int] NULL,
	[content] [ntext] NULL,
	[publishdisplay] [int] NULL,
	[createdatetime] [datetime] NULL,
	[viewcount] [int] NULL,
	[commentcount] [int] NULL,
	[level] [int] NULL,
	[istop] [int] NULL,
	[deletetag] [int] NULL,
	[VersionNo] [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[ClassApp_class_articleattachs]    Script Date: 2019/5/25 14:12:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ClassApp_class_articleattachs](
	[attachid] [int] NOT NULL,
	[articleid] [int] NULL,
	[title] [nvarchar](50) NULL,
	[filename] [nvarchar](200) NULL,
	[filepath] [nvarchar](500) NULL,
	[createdatetime] [datetime] NULL,
	[status] [int] NULL,
	[VersionNo] [int] NOT NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[ClassApp_class_articlecomments]    Script Date: 2019/5/25 14:12:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ClassApp_class_articlecomments](
	[articlecommentid] [int] NOT NULL,
	[articleid] [int] NULL,
	[userid] [int] NULL,
	[author] [nvarchar](50) NULL,
	[content] [ntext] NULL,
	[commentdatetime] [datetime] NULL,
	[parentid] [int] NULL,
	[status] [int] NULL,
	[VersionNo] [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[ClassApp_class_backgroundmusic]    Script Date: 2019/5/25 14:12:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ClassApp_class_backgroundmusic](
	[id] [int] NOT NULL,
	[kid] [int] NULL,
	[classid] [int] NULL,
	[backgroundmusicpath] [nvarchar](500) NULL,
	[backgroundmusictitle] [nvarchar](200) NULL,
	[isdefault] [bit] NULL,
	[datatype] [nvarchar](200) NULL,
	[uploaddatetime] [datetime] NULL,
	[status] [int] NULL,
	[net] [int] NULL,
	[VersionNo] [int] NOT NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[ClassApp_class_forum]    Script Date: 2019/5/25 14:12:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ClassApp_class_forum](
	[classforumid] [int] NOT NULL,
	[title] [nvarchar](200) NULL,
	[contents] [ntext] NULL,
	[userid] [int] NULL,
	[author] [nvarchar](50) NULL,
	[kid] [int] NULL,
	[classid] [int] NULL,
	[createdatetime] [datetime] NULL,
	[istop] [int] NULL,
	[parentid] [int] NULL,
	[approve] [int] NULL,
	[status] [int] NULL,
	[lastreplaytime] [datetime] NULL,
	[replaycount] [int] NULL,
	[VersionNo] [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[ClassApp_class_forum_teacher]    Script Date: 2019/5/25 14:12:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ClassApp_class_forum_teacher](
	[classforumid] [int] NOT NULL,
	[title] [nvarchar](200) NULL,
	[contents] [ntext] NULL,
	[userid] [int] NULL,
	[author] [nvarchar](50) NULL,
	[kid] [int] NULL,
	[createdatetime] [datetime] NULL,
	[istop] [int] NULL,
	[parentid] [int] NULL,
	[approve] [int] NULL,
	[status] [int] NULL,
	[VersionNo] [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[ClassApp_class_notice]    Script Date: 2019/5/25 14:12:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ClassApp_class_notice](
	[noticeid] [int] NOT NULL,
	[title] [nvarchar](100) NULL,
	[userid] [int] NULL,
	[author] [nvarchar](50) NULL,
	[kid] [int] NULL,
	[classid] [int] NULL,
	[content] [ntext] NULL,
	[createdatetime] [datetime] NULL,
	[status] [int] NULL,
	[VersionNo] [int] NOT NULL,
	[contentid] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[ClassApp_class_notice_class]    Script Date: 2019/5/25 14:12:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ClassApp_class_notice_class](
	[id] [int] NOT NULL,
	[classid] [int] NOT NULL,
	[noticeid] [int] NOT NULL,
	[VersionNo] [int] NOT NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[ClassApp_class_photocomments]    Script Date: 2019/5/25 14:12:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ClassApp_class_photocomments](
	[photocommentid] [int] NOT NULL,
	[photoid] [int] NULL,
	[userid] [int] NULL,
	[author] [nvarchar](100) NULL,
	[content] [ntext] NULL,
	[commentdatetime] [datetime] NULL,
	[parentid] [int] NULL,
	[status] [int] NULL,
	[VersionNo] [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[ClassApp_class_photos]    Script Date: 2019/5/25 14:12:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ClassApp_class_photos](
	[photoid] [int] NOT NULL,
	[albumid] [int] NOT NULL,
	[title] [nvarchar](100) NULL,
	[filename] [nvarchar](200) NULL,
	[filepath] [nvarchar](500) NULL,
	[filesize] [int] NULL,
	[viewcount] [int] NULL,
	[commentcount] [int] NULL,
	[uploaddatetime] [datetime] NULL,
	[iscover] [int] NULL,
	[isfalshshow] [int] NULL,
	[orderno] [int] NULL,
	[status] [int] NULL,
	[net] [int] NULL,
	[VersionNo] [int] NOT NULL,
	[kid] [int] NULL,
	[cid] [int] NULL,
	[url] [varchar](max) NULL,
	[yp] [int] NULL,
	[userid] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[ClassApp_class_schedule]    Script Date: 2019/5/25 14:12:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ClassApp_class_schedule](
	[scheduleid] [int] NOT NULL,
	[title] [nvarchar](100) NULL,
	[userid] [int] NULL,
	[author] [nvarchar](50) NULL,
	[classid] [int] NULL,
	[kid] [int] NULL,
	[content] [ntext] NULL,
	[createdatetime] [datetime] NULL,
	[viewcount] [int] NULL,
	[commentcount] [int] NULL,
	[status] [int] NULL,
	[VersionNo] [int] NOT NULL,
	[ShareType] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[ClassApp_class_video]    Script Date: 2019/5/25 14:12:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ClassApp_class_video](
	[videoid] [int] NOT NULL,
	[userid] [int] NULL,
	[classid] [int] NULL,
	[kid] [int] NULL,
	[title] [nvarchar](100) NULL,
	[description] [nvarchar](200) NULL,
	[filename] [nvarchar](200) NULL,
	[filepath] [nvarchar](500) NULL,
	[filesize] [int] NULL,
	[viewcount] [int] NULL,
	[commentcount] [int] NULL,
	[uploaddatetime] [datetime] NULL,
	[author] [nvarchar](50) NULL,
	[coverphoto] [nvarchar](200) NULL,
	[status] [int] NULL,
	[weburl] [nvarchar](500) NULL,
	[videotype] [int] NULL,
	[net] [int] NULL,
	[VersionNo] [int] NOT NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[ClassApp_class_videocomments]    Script Date: 2019/5/25 14:12:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ClassApp_class_videocomments](
	[videocommentid] [int] NOT NULL,
	[videoid] [int] NULL,
	[userid] [int] NULL,
	[author] [nvarchar](50) NULL,
	[content] [ntext] NULL,
	[commentdatetime] [datetime] NULL,
	[parentid] [int] NULL,
	[status] [int] NULL,
	[VersionNo] [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[EBook_TNB_Chapter]    Script Date: 2019/5/25 14:12:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[EBook_TNB_Chapter](
	[chapterid] [int] NOT NULL,
	[teachingnotebookid] [int] NULL,
	[chaptertitle] [nvarchar](50) NULL,
	[contentsplit] [nvarchar](200) NULL,
	[subject] [nvarchar](20) NULL,
	[grade] [nvarchar](20) NULL,
	[createdate] [nvarchar](10) NULL,
	[chaptercontent] [ntext] NULL,
	[ordernum] [int] NULL,
	[textpagecount] [int] NULL,
	[tlfcontent] [ntext] NULL,
	[exquisite] [int] NULL,
	[deletetag] [int] NOT NULL,
	[VersionNo] [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[EBook_tnb_teachingnotebook]    Script Date: 2019/5/25 14:12:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[EBook_tnb_teachingnotebook](
	[teachingnotebookid] [int] NOT NULL,
	[booktitle] [nvarchar](30) NULL,
	[createdate] [nvarchar](10) NULL,
	[userid] [int] NULL,
	[username] [nvarchar](50) NULL,
	[bookthemeswf] [nvarchar](100) NULL,
	[coverswf] [nvarchar](100) NULL,
	[backcoverswf] [nvarchar](100) NULL,
	[kid] [int] NULL,
	[term] [nvarchar](20) NULL,
	[kindergartenname] [nvarchar](50) NULL,
	[theme] [int] NULL,
	[booktype] [int] NULL,
	[VersionNo] [int] NOT NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[KWebCMS_cms_album]    Script Date: 2019/5/25 14:12:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[KWebCMS_cms_album](
	[albumid] [int] NOT NULL,
	[categoryid] [int] NULL,
	[title] [nvarchar](50) NULL,
	[searchkey] [nvarchar](50) NULL,
	[searchdescription] [nvarchar](100) NULL,
	[photocount] [int] NULL,
	[cover] [nvarchar](200) NULL,
	[orderno] [int] NULL,
	[createdatetime] [datetime] NULL,
	[siteid] [int] NULL,
	[net] [int] NULL,
	[VersionNo] [int] NOT NULL,
	[deletetag] [int] NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[KWebCMS_cms_category]    Script Date: 2019/5/25 14:12:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[KWebCMS_cms_category](
	[categoryid] [int] NOT NULL,
	[title] [nvarchar](30) NULL,
	[description] [nvarchar](50) NULL,
	[parentid] [int] NULL,
	[categorytype] [int] NULL,
	[orderno] [int] NULL,
	[categorycode] [nvarchar](20) NULL,
	[siteid] [int] NULL,
	[createdatetime] [datetime] NULL,
	[iconid] [int] NULL,
	[islist] [bit] NULL,
	[VersionNo] [int] NOT NULL,
	[remarks] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[KWebCMS_cms_content]    Script Date: 2019/5/25 14:12:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[KWebCMS_cms_content](
	[contentid] [int] NOT NULL,
	[categoryid] [int] NULL,
	[content] [ntext] NULL,
	[title] [nvarchar](150) NULL,
	[titlecolor] [nvarchar](10) NULL,
	[author] [nvarchar](30) NULL,
	[createdatetime] [datetime] NULL,
	[searchkey] [nvarchar](150) NULL,
	[searchdescription] [nvarchar](150) NULL,
	[browsertitle] [nvarchar](150) NULL,
	[viewcount] [int] NULL,
	[commentcount] [int] NULL,
	[orderno] [int] NULL,
	[commentstatus] [bit] NULL,
	[ispageing] [bit] NULL,
	[status] [bit] NULL,
	[siteid] [int] NULL,
	[draftstatus] [int] NULL,
	[istop] [bit] NOT NULL,
	[VersionNo] [int] NOT NULL,
	[deletetag] [int] NULL,
	[appcontent] [ntext] NULL,
	[sgs_send] [bit] NULL,
	[new_recipe] [int] NULL,
	[sendsms] [int] NULL,
	[ipaddress] [nvarchar](max) NULL,
	[groupoperation] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[KWebCMS_cms_contentattachs]    Script Date: 2019/5/25 14:12:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[KWebCMS_cms_contentattachs](
	[contentattachsid] [int] NOT NULL,
	[categoryid] [int] NULL,
	[contentid] [int] NULL,
	[title] [nvarchar](100) NULL,
	[filepath] [nvarchar](200) NULL,
	[filename] [nvarchar](100) NULL,
	[filesize] [int] NULL,
	[viewcount] [int] NULL,
	[createdatetime] [datetime] NULL,
	[attachurl] [nvarchar](200) NULL,
	[isdefault] [bit] NULL,
	[siteid] [int] NULL,
	[orderno] [int] NULL,
	[net] [int] NULL,
	[istop] [bit] NOT NULL,
	[VersionNo] [int] NOT NULL,
	[deletetag] [int] NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[KWebCMS_cms_photo]    Script Date: 2019/5/25 14:12:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[KWebCMS_cms_photo](
	[photoid] [int] NOT NULL,
	[categoryid] [int] NULL,
	[albumid] [int] NULL,
	[title] [nvarchar](200) NULL,
	[filename] [nvarchar](200) NULL,
	[filepath] [nvarchar](200) NULL,
	[filesize] [int] NULL,
	[orderno] [int] NULL,
	[commentcount] [int] NULL,
	[indexshow] [bit] NULL,
	[flashshow] [bit] NULL,
	[createdatetime] [datetime] NULL,
	[siteid] [int] NULL,
	[iscover] [bit] NULL,
	[net] [int] NULL,
	[VersionNo] [int] NOT NULL,
	[deletetag] [int] NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[KWebCMS_site]    Script Date: 2019/5/25 14:12:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[KWebCMS_site](
	[siteid] [int] NOT NULL,
	[name] [nvarchar](50) NULL,
	[description] [nvarchar](300) NULL,
	[address] [nvarchar](500) NULL,
	[sitedns] [nvarchar](100) NULL,
	[provice] [int] NULL,
	[city] [int] NULL,
	[regdatetime] [datetime] NULL,
	[contractname] [nvarchar](30) NULL,
	[QQ] [nvarchar](20) NULL,
	[phone] [nvarchar](300) NULL,
	[accesscount] [int] NULL,
	[status] [bit] NULL,
	[Email] [nvarchar](100) NULL,
	[synchro] [int] NULL,
	[dict] [nvarchar](64) NULL,
	[ktype] [nvarchar](10) NULL,
	[klevel] [nvarchar](10) NULL,
	[org_id] [int] NULL,
	[copyright] [varchar](400) NULL,
	[photowatermark] [varchar](50) NULL,
	[keyword] [nvarchar](100) NULL,
	[VersionNo] [int] NOT NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[NGBApp_cellset]    Script Date: 2019/5/25 14:12:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[NGBApp_cellset](
	[kid] [int] NOT NULL,
	[celltype] [int] NOT NULL,
	[cellset] [varchar](100) NOT NULL,
	[VersionNo] [int] NOT NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[NGBApp_celltarget]    Script Date: 2019/5/25 14:12:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[NGBApp_celltarget](
	[hbid] [int] NOT NULL,
	[title] [nvarchar](20) NOT NULL,
	[target] [nvarchar](1000) NULL,
	[CrtDate] [datetime] NOT NULL,
	[VersionNo] [int] NOT NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[NGBApp_diary]    Script Date: 2019/5/25 14:12:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[NGBApp_diary](
	[diaryid] [bigint] NOT NULL,
	[gbid] [int] NULL,
	[pagetplid] [int] NULL,
	[CrtDate] [datetime] NOT NULL,
	[deletetag] [int] NOT NULL,
	[Author] [varchar](50) NULL,
	[Share] [int] NULL,
	[Src] [int] NULL,
	[VersionNo] [int] NOT NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[NGBApp_growthbook]    Script Date: 2019/5/25 14:12:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[NGBApp_growthbook](
	[gbid] [int] NOT NULL,
	[kid] [int] NOT NULL,
	[grade] [int] NULL,
	[userid] [int] NOT NULL,
	[term] [varchar](6) NOT NULL,
	[TeaWord] [nvarchar](1000) NULL,
	[Height] [varchar](20) NULL,
	[Weight] [varchar](20) NULL,
	[Eye] [varchar](20) NULL,
	[Blood] [varchar](20) NULL,
	[Tooth] [varchar](20) NULL,
	[DocWord] [nvarchar](500) NULL,
	[MyWord] [nvarchar](500) NULL,
	[ParWord] [nvarchar](1000) NULL,
	[FamilyPic] [varchar](100) NULL,
	[DadName] [varchar](20) NULL,
	[DadJob] [varchar](30) NULL,
	[MomName] [varchar](20) NULL,
	[MomJob] [varchar](30) NULL,
	[ParWish] [nvarchar](1000) NULL,
	[DevEvlPoint] [varchar](100) NULL,
	[CrtDate] [datetime] NULL,
	[cname] [nvarchar](20) NULL,
	[VersionNo] [int] NOT NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[NGBApp_HomeBook]    Script Date: 2019/5/25 14:12:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[NGBApp_HomeBook](
	[hbid] [int] NOT NULL,
	[kid] [int] NOT NULL,
	[grade] [int] NOT NULL,
	[cid] [int] NOT NULL,
	[term] [varchar](6) NOT NULL,
	[CrtDate] [datetime] NOT NULL,
	[Teacher] [varchar](200) NULL,
	[Foreword] [varchar](4000) NULL,
	[ForewordPic] [varchar](100) NULL,
	[ClassNotice] [varchar](2000) NULL,
	[ClassPic] [varchar](200) NULL,
	[VersionNo] [int] NOT NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[NGBApp_ModuleSet]    Script Date: 2019/5/25 14:12:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[NGBApp_ModuleSet](
	[kid] [int] NOT NULL,
	[term] [varchar](6) NOT NULL,
	[hbModList] [varchar](200) NOT NULL,
	[gbModList] [varchar](200) NOT NULL,
	[Monadvset] [varchar](50) NOT NULL,
	[celltype] [int] NOT NULL,
	[VersionNo] [int] NOT NULL,
	[cellset] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[NGBApp_page_cell]    Script Date: 2019/5/25 14:12:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[NGBApp_page_cell](
	[diaryid] [bigint] NOT NULL,
	[title] [tinyint] NOT NULL,
	[TeaPoint] [varchar](50) NULL,
	[TeaWord] [varchar](8000) NULL,
	[ParPoint] [varchar](50) NULL,
	[ParWord] [varchar](8000) NULL,
	[VersionNo] [int] NOT NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[NGBApp_page_month_evl]    Script Date: 2019/5/25 14:12:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[NGBApp_page_month_evl](
	[diaryid] [bigint] NOT NULL,
	[months] [tinyint] NOT NULL,
	[TeaPoint] [varchar](50) NULL,
	[ParPoint] [varchar](50) NULL,
	[VersionNo] [int] NOT NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[NGBApp_page_month_sec]    Script Date: 2019/5/25 14:12:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[NGBApp_page_month_sec](
	[diaryid] [bigint] NOT NULL,
	[title] [tinyint] NOT NULL,
	[MyPic] [varchar](200) NULL,
	[TeaWord] [nvarchar](1000) NULL,
	[ParWord] [nvarchar](1000) NULL,
	[MyWord] [nvarchar](1000) NULL,
	[VersionNo] [int] NOT NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[NGBApp_page_public]    Script Date: 2019/5/25 14:12:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[NGBApp_page_public](
	[diaryid] [bigint] NOT NULL,
	[ckey] [varchar](20) NOT NULL,
	[cvalue] [varchar](1000) NOT NULL,
	[ctype] [int] NOT NULL,
	[VersionNo] [int] NOT NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[NGBApp_tea_UpPhoto]    Script Date: 2019/5/25 14:12:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[NGBApp_tea_UpPhoto](
	[photoid] [bigint] NOT NULL,
	[gbid] [int] NOT NULL,
	[photo_desc] [nvarchar](100) NULL,
	[m_path] [nvarchar](200) NOT NULL,
	[net] [int] NULL,
	[updatetime] [datetime] NOT NULL,
	[deletetag] [int] NOT NULL,
	[pictype] [int] NOT NULL,
	[VersionNo] [int] NOT NULL,
	[userid] [int] NULL,
	[sender] [int] NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[RestoreWeb_History]    Script Date: 2019/5/25 14:12:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RestoreWeb_History](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[KID] [int] NULL,
	[Oper] [varchar](50) NULL,
	[OperBgnTime] [datetime] NOT NULL,
	[OperEndTime] [datetime] NULL,
	[Result] [int] NOT NULL,
	[ProcName] [varchar](50) NULL,
	[Msg] [varchar](max) NULL,
	[type] [int] NOT NULL,
 CONSTRAINT [PK_RestoreWeb_History] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[TableInfo]    Script Date: 2019/5/25 14:12:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TableInfo](
	[DBName] [varchar](125) NOT NULL,
	[TBName] [varchar](125) NOT NULL,
	[Keystr] [varchar](200) NOT NULL,
	[FilStr] [varchar](2000) NOT NULL,
	[VersionCtrl] [varchar](2000) NOT NULL,
	[IsCanDel] [bit] NOT NULL,
 CONSTRAINT [pk_TableInfo] PRIMARY KEY CLUSTERED 
(
	[DBName] ASC,
	[TBName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[test]    Script Date: 2019/5/25 14:12:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[test](
	[D] [datetime] NULL,
	[MEMO] [varchar](10) NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Backup_Error_log] ADD  DEFAULT (getdate()) FOR [errordate]
GO

ALTER TABLE [dbo].[BackupWeb_History] ADD  DEFAULT (getdate()) FOR [OperBgnTime]
GO

ALTER TABLE [dbo].[BackupWeb_History] ADD  DEFAULT ((0)) FOR [Result]
GO

ALTER TABLE [dbo].[BackupWeb_History] ADD  DEFAULT ((0)) FOR [type]
GO

ALTER TABLE [dbo].[BackupWebInfo] ADD  DEFAULT (getdate()) FOR [BackupDate]
GO

ALTER TABLE [dbo].[RestoreWeb_History] ADD  CONSTRAINT [DF_RestoreWeb_History_OperBgnTime]  DEFAULT (getdate()) FOR [OperBgnTime]
GO

ALTER TABLE [dbo].[RestoreWeb_History] ADD  CONSTRAINT [DF_RestoreWeb_History_Result]  DEFAULT ((0)) FOR [Result]
GO

ALTER TABLE [dbo].[RestoreWeb_History] ADD  DEFAULT ((0)) FOR [type]
GO

ALTER TABLE [dbo].[TableInfo] ADD  DEFAULT ('') FOR [VersionCtrl]
GO

ALTER TABLE [dbo].[TableInfo] ADD  DEFAULT ((0)) FOR [IsCanDel]
GO

ALTER TABLE [dbo].[test] ADD  DEFAULT (getdate()) FOR [D]
GO


