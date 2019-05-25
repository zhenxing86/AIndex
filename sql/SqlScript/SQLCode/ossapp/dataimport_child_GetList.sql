
USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[SMS_Send_Add]    Script Date: 05/14/2013 14:55:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
alter PROCEDURE [dbo].[dataimport_child_GetList]
@kid int,
@usertype int=0,
@intimestr datetime='',
@status int

AS 

--成功的资料
if(@status=1)
begin
select cname,uname,gender,birthday,account,regdatetime,mobile,kinno,'成功' result
 from excel_input_child
where kid=@kid and intime=@intimestr and onepass=1	
end
--失败的资料
else if(@status=0)
begin
  
select e.cname,e.uname,e.gender,e.birthday,e.account,e.regdatetime,e.mobile,e.kinno,  
(case when u.userid >0  then '帐号被'+k.kname+u.name+'占用,' else '' end)  
+(case when c.cid is null then '班级:'+e.cname+'不存在,' else '' end)  
+(case when ([CommonFun].[dbo].[fn_cellphone](e.mobile)=0 And replace(e.mobile,' ','')<>'' ) or (e.mobile is null or e.mobile='')  then '手机错误,' else '' end)  
+(case when ISDATE(e.birthday)=0 then '生日错误,' else '' end)  
+(case when (e.account is null or e.account='') then '账号不能为空,' else '' end)  
+ (case when u.userid is null and ex.id>0  then '导入的列表中帐号重复,' else '' end)  
 result,  
 (case when u.userid is not null then '1,' else '' end)  
+(case when c.cid is null then '2,' else '' end)  
+(case when ([CommonFun].[dbo].[fn_cellphone](e.mobile)=0 And replace(e.mobile,' ','')<>'' ) or (e.mobile is null or e.mobile='')  then '3,' else '' end)  
+(case when ISDATE(e.birthday)=0 then '4,' else '' end)  
+(case when ex.id>0 then '1,' else '' end)  
+(case when (e.account is null or e.account='') then '1,' else '' end)  
+(case when DateDiff(YEAR,isnull(e.birthday,'1900-0-0'),GETDATE())>8  then '4,' else '' end)  
 resultnum,  
 e.id   
 from excel_input_child e  
 left join basicdata..[user] u on  u.account=e.account and u.deletetag=1 
 outer apply 
 (select COUNT(1) id from excel_input_child ex where ex.kid=@kid and ex.intime=@intimestr  and e.account=ex.account)
 ex
 left join basicdata..[class] c on c.cname=e.cname and c.kid=@kid and c.deletetag=1  
  left join basicdata..kindergarten k on k.kid=@kid and k.deletetag=1  
where e.kid=@kid and e.intime=@intimestr and e.onepass=0   
end  
--导入的资料
else if(@status=-1)
begin

select e.cname,e.uname,e.gender,e.birthday,e.account,e.regdatetime,e.mobile,e.kinno,
case when e.nopass=1 then 
(case when u.userid is not null then '帐号重复,' else '' end)
+(case when c.cid is null then '班级不存在,' else '' end)
+(case when ([CommonFun].[dbo].[fn_cellphone](e.mobile)=0 And replace(e.mobile,' ','')<>'' )  then '手机错误,' else '' end)
+(case when ISDATE(e.birthday)=0 then '生日错误,' else '' end)
else '成功' end
 result,e.intime
 from excel_input_child e
 left join basicdata..[user] u on  u.account=e.account and u.deletetag=1
 left join basicdata..[class] c on c.cname=e.cname and c.kid=@kid and c.deletetag=1
where e.kid=@kid and e.intime=@intimestr
  
end
--basicdata所有资料
else if(@status=-2)
begin
select c.cname,u.name,u.gender,convert(varchar(10),u.birthday,120),u.account,u.regdatetime,u.mobile,0,
'系统资料' result
 from basicdata..[user] u 
 inner join basicdata..user_class uc on uc.userid=u.userid
 inner join basicdata..[class] c on c.cid=uc.cid and c.kid=@kid
where u.kid=@kid and u.usertype=0 and u.deletetag=1 and c.deletetag=1
end

GO

--[dataimport_child_GetList] 1940,0,'2013-09-09 10:14:54.953',-1
GO
--[dataimport_child_GetList] 12021,1,'2013-10-12 15:17:25.777',1
--GO
--[dataimport_child_GetList] 12021,1,'2013-10-12 15:17:25.777',0
--GO
--[dataimport_child_GetList] 12021,1,'2013-10-12 15:17:25.777',-1
--GO
--[dataimport_child_GetList] 12021,1,'2013-10-12 15:17:25.777',-2
	--select @onepass=COUNT(1) from excel_input_child e 
	--	inner join basicdata..[user] u 
	--		on e.account=u.account and u.kid=@kid
	--	where e.kid=@kid
	--		and  [CommonFun].[dbo].[fn_cellphone](e.mobile)=1
	--		and ISDATE(e.birthday)=1
	
	
	