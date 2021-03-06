USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[excelupgrade_user_add]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      
-- Create date: 2014-08-27
-- Description:   分班到资料的时候添加新生
-- Memo:  
*/    
CREATE PROCEDURE [dbo].[excelupgrade_user_add]  
	@kid int,  
	@cids varchar(100),  
	@account nvarchar(50),  
	@password nvarchar(500),  
	@name nvarchar(20),  
	@birthday datetime,  
	@gender int,  
	@mobile nvarchar(11),  
	@enrollmentdate datetime,  
	@address nvarchar(200),  
	@title nvarchar(20),  
	@post nvarchar(20),  
	@education nvarchar(20),  
	@employmentform nvarchar(20),  
	@politicalface nvarchar(20),
	@enrollmentreason varchar(50) ,
	@excel_id int,
	@DoUserID int = 0     
AS
 
begin tran 
begin try 
  if commonfun.dbo.fn_RegExMatch(@account, N'^\d{1,8}$') = 1--过滤掉8位以内的纯数字帐号留给时光树使用, 网页端不允许使用
  begin
    Raiserror('帐号重复', 16, -1)
    Return
  end

	declare @usertype int  
	set @usertype=0  
	if(@enrollmentdate='1900-01-01')  
	begin  
		set @enrollmentdate=null  
	end  

	if(@birthday='1900-01-01')  
	begin  
		set @birthday=null  
	end 
	--1.user_ADD(1)  
	--新增数据信息到  
	insert into [user](account,password,usertype,deletetag,regdatetime,kid,name,nickname,birthday,gender,nation,
							mobile,email,address,enrollmentdate,headpic,enrollmentreason)  
		values(@account,@password,@usertype,1,getdate(),@kid,@name,@name,@birthday,@gender,0,@mobile,'',@address,
					 @enrollmentdate,'AttachsFiles/default/headpic/default.jpg',@enrollmentreason)  
			
	DECLARE @userid int,@bloguserid int  
	SET @userid = ident_current('user')  

	--合并3.获取uid将数据新增到   
	insert into user_baseinfo  
			(userid,name,nickname,birthday,gender,nation,
			mobile,email,address,enrollmentdate,headpic,enrollmentreason)  
		VALUES(@userid,@name,@name,@birthday,@gender,0,@mobile,'',@address,
			@enrollmentdate,'AttachsFiles/default/headpic/default.jpg',@enrollmentreason)  

	--判断@usertype  
	--大于0新增-  
	if(@usertype>0)  
	begin  
		insert into teacher(userid,did,title,post,education,employmentform,politicalface)  
			VALUES(@userid,null,@title,@post,@education,@employmentform,@politicalface)  
	end  
	else   
	begin  
	--小于0新增-  
		insert into child(userid,fathername,mothername,favouritething,
				fearthing,favouritefoot,footdrugallergic)  
			VALUES(@userid,'','','','','','')  
	end  

	--新增user_bloguser values(@userid)  
	INSERT INTO user_bloguser values(@userid)  
	SET @bloguserid = ident_current('user_bloguser')  

	--2.user_kindergarten_ADD(1)  
	INSERT INTO user_kindergarten(userid,kid)
		VALUES(@userid,@kid)  
			
	--4.user_class_ADD(1)  
	INSERT INTO user_class(cid, userid)  
	select col, @userid 
		from dbo.f_split(@cids,',')  
--5添加到user_class_all表
insert into user_class_all(cid,userid,deletetag,actiondate,term)
select col, @userid,1,GETDATE(),CommonFun.dbo.fn_getCurrentTerm(@kid,GETDATE(),1) 
		from dbo.f_split(@cids,',')  
--6.更新excel内容
update ossapp..excel_upgrade_child set nopass=0,onepass=1 where id=@excel_id and deletag=1  

if exists (SELECT  1 FROM blogapp..permissionsetting WHERE kid=@kid and ptype=12)  
begin  
exec cardapp..SynInterface_UserInfo_Add @userid,@usertype,0  
end  

--5.添加到临时表  
insert into dbo.user_add_temp(userid,usertype,gender,nickname,infofrom,bloguserid)  
values(@userid,@usertype,@gender,@name,'blog',@bloguserid)  

commit tran
end try
begin catch
 rollback tran 
 SELECT ERROR_NUMBER() as ErrorNumber,
        ERROR_MESSAGE() as ErrorMessage;
end catch
GO
