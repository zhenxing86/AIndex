USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[basicdata_user_datahealth]    Script Date: 04/16/2014 09:32:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	yz
-- Create date:2014-04-14
-- Description:	数据健康查询
-- [dbo].[basicdata_user_datahealth] '于','',''
-- =============================================
ALTER PROCEDURE [dbo].[basicdata_user_datahealth]
@name nvarchar(50),
@mobile nvarchar(50),
@account nvarchar(50)
AS
BEGIN

SET NOCOUNT ON;

declare @fromstring NVARCHAR(2000)

set @fromstring = 'select u.userid,
                          u.name 姓名,
                          u.mobile 手机,
                          u.account 账号,
                          case when u.usertype = 0 then ''学生'' 
                               when u.usertype = 1 then ''老师''
                               when u.usertype = 97 then ''园长''
                               when u.usertype = 98 then ''管理员''end 用户类型,
                          case when u.deletetag = 0 then ''彻底删除''
                               when u.deletetag = 1 and u.kid = 0 then ''离园''
                               when u.deletetag = 1 and u.kid <> 0 then ''正在使用''end 状态,
           
                          case when u.kid = 0 then lk.kid else u.kid end kid,
                          (select kname 幼儿园 from BasicData..kindergarten where kid = (case when u.kid = 0 then lk.kid else u.kid end))幼儿园
                         
                          
                          
                     from basicdata..[user] u
                     left join basicdata..leave_kindergarten lk
                       on u.userid = lk.userid
                    where 1=1'
    IF @name <> '' SET @fromstring = @fromstring + ' AND u.name  like ''%''+ @name + ''%'''
    IF @mobile <> '' SET @fromstring = @fromstring + ' AND u.mobile = @mobile '   
	  IF @account <> '' SET @fromstring = @fromstring + ' AND u.account = @account'
	  IF @name = ''and @mobile = '' and @account = '' SET @fromstring = @fromstring + ' AND 1=2'
	  
	  
    EXEC SP_EXECUTESQL @fromstring, 
         N' @name nvarchar(50) = NULL,@mobile nvarchar(50)= NULL,@account nvarchar(50) = null', 
         @name = @name,@mobile = @mobile,@account = @account
        

END

