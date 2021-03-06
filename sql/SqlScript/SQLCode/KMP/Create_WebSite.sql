USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[Create_WebSite]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--exec [Create_WebSite] '0002', '', '0000', '1','1','02088888888','along','天河','http://ys2.zgyey.com'
--exec [Get_WebSiteInfos] 24
-- =============================================
-- Author:		<along>
-- Create date: <2007-04-11>
-- Description:	<自助建站第一步>
-- =============================================
CREATE PROCEDURE [dbo].[Create_WebSite]	
	@Account varchar(50),
	@Password varchar(50),
	@KName varchar(150),
	@Privince varchar(50),
	@City varchar(50),
	@Phone varchar(100) = '',
	@Contact varchar(100) = '',
	@Address varchar(200) = '',
	@Url varchar(100),
	@QQ varchar(50),
	@Email varchar(100),
	@KinPhone varchar(50),
	@Memo varchar(500),
	@Area varchar(50),
	@dict varchar(64)
AS

Declare @UserID int				--新增用户ID
Declare @Kid int				--新增幼儿园ID
Declare @KinManageRoleID int	--管理员角色ID
Declare @PermissionID int		--权限ID
Declare @DepartmentID int		--部门ID
declare @copyright varchar(800)
declare @Id as varchar(3)
set @copyright='<a href="http://www.zgyey.com" target="_blank" ><b>中国幼儿园门户</b></a> &nbsp;<script src="http://s33.cnzz.com/stat.php?id=246325&web_id=246325&show=pic" language="JavaScript" charset="gb2312"></script><a href="http://www.miibeian.gov.cn/" target="_blank">粤ICP备08124264号</a>　　技术支持电话：020-32215083 QQ：<a target="blank" href="tencent://message/?uin=1050523712&Site=www.zgyey.com&Menu=yes"><img border="0" SRC="http://wpa.qq.com/pa?p=1:1050523712:1" alt="联系客服" align="absmiddle"></a>&nbsp;<a href="http://pt.zgyey.com" target="_blank">网站管理</a>'
BEGIN
--BEGIN TRANSACTION
if(@KName is null)
	begin
		--ROLLBACK TRANSACTION
	return 0
	end
else
	begin

   --  新增幼儿园
	
INSERT INTO [kmp].[dbo].[T_Kindergarten]
           ([Name],[ShotName],[Code],[Address],[Privince],[City],[Area],[Url],[Phone],[Status],[ActionDate],[Memo],[smsNum],[IsPublish],[Theme],[linkman],[contractphone],[QQ],[email],[copyright],[ptshotname],[dict],[ktype],[klevel])
		VALUES
		(@KName,@KName,'',@Address,@Privince,@City,@Area,@Url,@KinPhone, 1, getdate(), '联系人:'+@Contact+';联系人电话：'+ @Phone + ';地址:'+@Address + ';QQ:'+@QQ + ';Email:' + @Email + ';其它备注：'+@Memo, 10, 0,'Default',@Contact,@Phone,@QQ,@Email,@copyright,@KName,@dict,'其他','其他')

   --获取新增幼儿园ID
	SELECT @Kid = @@IDENTITY 

	--加入郴州幼儿园数据同步中间表
	IF((SELECT [dbo].[IsSyncKindergarten](@Kid))=1)
	BEGIN
		INSERT INTO [T_SyncKindergarten]([siteid],[action],[actiondatetime],[issync])
		VALUES (@Kid,0,getdate(),0)
	END


INSERT INTO [kmp].[dbo].[T_Class]([KindergartenID],[Code],[Name],[ClassGrade],[Order],[Status],[Memo],[Years],[Theme],[ShotName])
SELECT @Kid,Code,[Name],ClassGrade,[Order],Status,Memo,Years,Theme,ShotName FROM Templates_Class

--加入郴州幼儿园数据同步中间表
IF((SELECT [dbo].[IsSyncKindergarten](@Kid))=1)
BEGIN
	INSERT INTO [kmp]..[T_SyncClass]([classid],[action],[actiondatetime],[issync])
	SELECT ID,0,getdate(),0 FROM T_Class WHERE KindergartenID=@Kid
END
DECLARE @smallClassID INT
SELECT @smallClassID=ID FROM T_Class WHERE KindergartenID=@Kid AND Name='小一班' 

   --新增部门
	INSERT INTO [kmp].[dbo].[T_Department]([Name],[Code],[Superior],[Principal],[Order],[Status],[Memo],[KindergartenID])
     VALUES(@KName,'',0,0,0,1,'自动生成',@Kid) 
	SELECT @DepartmentID = @@IDENTITY 
   --新增角色
	INSERT INTO [kmp].[dbo].[T_Role]([Name],[Kindergarten])VALUES('管理员',@Kid)
	--获取管理员角色ID
	SELECT @KinManageRoleID = @@IDENTITY  
	INSERT INTO [kmp].[dbo].[T_Role]([Name],[Kindergarten])VALUES('园长',@Kid)
	declare @KinMasterRoleID int
	select @KinMasterRoleID = @@IDENTITY
	INSERT INTO [kmp].[dbo].[T_Role]([Name],[Kindergarten])VALUES('老师',@Kid)
	declare @TeacherRoleID int
    select @TeacherRoleID = @@IDENTITY	
	
	INSERT INTO [kmp].[dbo].[T_Role]([Name],[Kindergarten])VALUES('家长',@Kid)

   --新增管理员用户
	INSERT INTO [kmp].[dbo].[T_Users]([LoginName],[Password],[Style],[UserType],[Activity],[NickName])
     VALUES(@Account,@Password,1,98,1,'幼儿园管理员') 
	--获取新增管理员用户ID
	Select @UserID = @@IDENTITY
	INSERT INTO [kmp].[dbo].[T_Staffer]([UserID],[WorkNo],[Name],[EnglishName],[Birthday],[Gender],[Nation],[NativePlace],[PolityVisage],[Degree],[IdentityNo],[Address],[Phone],[Mobile],[Email],[Photo],[DepartmentID],[HeadShip],[OfficialRank],[EnrollmentDate],[ActionTime],[Status],[Memo],[KindergartenID])
     VALUES(@UserID,'0'+convert(nvarchar, @Kid)+'0001','幼儿园管理员','WebSiteManage',GetDate(),2,6,22,12,15,'自动生成','自动生成地址',@Phone,@Phone,@Email,'',@DepartmentID,'网站管理员','管理员',GetDate(),GetDate(),1,'自动生成管理员用户',@Kid)

	insert into [kmp].[dbo].[t_stafferclass](classid,userid)values(@smallclassid,@userid)
	--加入郴州幼儿园数据同步中间表
	IF((SELECT [dbo].[IsSyncKindergarten](@Kid))=1)
	BEGIN
		INSERT INTO [T_SyncStaffer]([userid],[action],[actiondatetime],[issync])
		VALUES (@UserID,0,getdate(),0)
	END

if not exists(select * from blog..blog_user where account=@Account and activity=1)
BEGIN
	DECLARE @bloguserid int
	exec blog..[blog_AutoRegister] @Account, @Password, '幼儿园管理员', 1, @bloguserid output
	exec blog..[bloguserkmpUser_ADD] @bloguserid,@UserID,@smallClassID,'小一班',@Kid,@KName,@Url,1
END

    --新增管理员用户角色
	INSERT INTO [kmp].[dbo].[T_UserRoles]([UserID],[RoleID])
     VALUES(@UserID,@KinManageRoleID)

			declare @SMSContent nvarchar(200)
			declare @SendTime datetime
			set @SendTime = getdate()
			set @SMSContent = @KName + '电话:' +@KinPhone +  '联系人:' +@Contact+ 'Q:' +@QQ
			exec SMS_AddSmsMessageXW '13682238844', @SMSContent,18, 88,0,0,@SendTime
			exec SMS_AddSmsMessageXW '13808828988', @SMSContent,18, 88,0,0,@SendTime			
			exec SMS_AddSmsMessageXW '13729805110', @SMSContent,18, 88,0,0,@SendTime				
	insert into kindergarten_fee_detail(kid,fee_type_id,price,end_date,actiondate,comments) values(@KID,1,300,getdate()+15,getdate(),'网络空间费')
	insert into kindergarten_fee_detail(kid,fee_type_id,price,end_date,actiondate,comments) values(@KID,2,125,getdate()+15,getdate(),'服务费')
--COMMIT TRANSACTION	  
return @kid
	end
END


GO
