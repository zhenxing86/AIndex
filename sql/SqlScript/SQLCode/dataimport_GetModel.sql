USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[SMS_Send_Add]    Script Date: 05/14/2013 14:55:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
alter PROCEDURE [dbo].[dataimport_GetModel]
@kid int,
@usertype int,
@intimestr datetime
 AS 
 declare @syscount int,@onepass int,@nopass int,@twopass int,@allcount int
 
 
if(@usertype=0)
begin


	 select @syscount=COUNT(1)  
		from basicdata..[user] u 
		 inner join basicdata..user_class uc on uc.userid=u.userid
		 inner join basicdata..[class] c on c.cid=uc.cid and c.kid=@kid
			where u.kid=@kid 
			and u.usertype=@usertype 
			and u.deletetag=1 and c.deletetag=1

	
	select @allcount=COUNT(1)
	 from excel_input_child
	where kid=@kid and intime=@intimestr
	
	select @onepass=COUNT(1) from excel_input_child e 
		where e.kid=@kid and e.onepass=1 and intime=@intimestr
			
	select @nopass=COUNT(1) from excel_input_child e 
		where e.kid=@kid and e.onepass=0 and intime=@intimestr
		
	set @twopass=0
	
end 
else if(@usertype=1)
begin

select @syscount=COUNT(1)  
		from basicdata..[user] u 
		 inner join basicdata..teacher t on t.userid=u.userid
			where u.kid=@kid 
			and u.usertype in( 1,97)
			and u.deletetag=1 
			

	
	select @allcount=COUNT(1)
	 from excel_input_teacher
	where kid=@kid and intime=@intimestr
	
	select @onepass=COUNT(1) from excel_input_teacher e 
		where e.kid=@kid and e.onepass=1 and intime=@intimestr
			
	select @nopass=COUNT(1) from excel_input_teacher e 
		where e.kid=@kid and e.onepass=0 and intime=@intimestr
		
	set @twopass=0

end
select @syscount ,@onepass ,@nopass ,@twopass ,@allcount
 
 
 
GO

--[dataimport_GetModel] 12511,0,'2013-08-22 15:53:05.747'
--[dataimport_GetModel] 1940,0,'2013-09-09 18:09:38.823'

[dataimport_GetModel] 8812,1,null

	--select @onepass=COUNT(1) from excel_input_child e 
	--	inner join basicdata..[user] u 
	--		on e.account=u.account and u.kid=@kid
	--	where e.kid=@kid
	--		and  [CommonFun].[dbo].[fn_cellphone](e.mobile)=1
	--		and ISDATE(e.birthday)=1