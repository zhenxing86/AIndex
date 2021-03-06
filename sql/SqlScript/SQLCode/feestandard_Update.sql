USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[feestandard_Update]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--[feestandard_Update] 6,12511,'','','80.0',1,15,0,1,'2014/2/13 9:30:41',1203,0,0,0,804,805,0,0,'',1,0,809,0,0,0
------------------------------------
CREATE PROCEDURE [dbo].[feestandard_Update]
 @ID int,
 @kid int,
 @sname varchar(200),
 @describe varchar(3000),
 @price float,
 @isproxy int,
 @proxyprice int,
 @isinvoice int,
 @uid int,
 @intime datetime,
 @a1 int,
 @a2 int,
 @a3 int,
 @a4 int,
 @a5 int,
 @a6 int,
 @a7 int,
 @a8 int,
 @remark varchar(500),
 @deletetag int,
 @a9 int=0,
 @a10 int=0,
 @a11 int=0,
 @a12 int=0,
 @a13 int=0
 AS 
 
 
	UPDATE [feestandard] SET 
  [kid] = @kid,
 [sname] = @sname,
 [describe] = @describe,
 [price] = @price,
 [isproxy] = @isproxy,
 [proxyprice] = @proxyprice,
 [isinvoice] = @isinvoice,
 [uid] = @uid,
 [intime] = @intime,
 [a1] = @a1,
 [a2] = @a2,
 [a3] = @a3,
 [a4] = @a4,
 [a5] = @a5,
 [a6] = @a6,
 [a7] = @a7,
 [a8] = @a8,
 [remark] = @remark,
 [deletetag] = @deletetag,
 [a9] = @a9,a10=@a10,a11=@a11,a12=@a12,a13=@a13
 	 WHERE ID=@ID
 	
 	
 	
--修正乐奇开通
if(@a5>0)
begin
update u set lqRight=CommonFun.dbo.fn_RoleAdd(lqRight,[dbo].[GetCurTermType_Fun](u.userid)) 
		from basicdata..[user] u 
		inner join addservice a on a.[uid]=u.userid
		where a.deletetag=1  
		and a.kid=@kid
		and a.a5=0 
		and a.describe='开通' 
		and u.deletetag=1 
end
else if (isnull(@a5,0)=0)
begin

	  update u set lqRight=CommonFun.dbo.fn_RoleDel(lqRight,[dbo].[GetCurTermType_Fun](u.userid)) 
		from basicdata..[user] u 
		inner join addservice a on a.[uid]=u.userid
		where a.deletetag=1  and a.kid=@kid
		and a.a5=804 and DATEDIFF(dd,a.ftime,GETDATE())<15 and a.describe='开通'

end


--修正阅读计划
if (isnull(@a10,0)=0)
begin

   --作废本学期的订单payapp..order_record status=-1  
   update o set [status]=-1   
    from payapp..order_record o   
	inner join addservice a on a.[uid]=o.userid
    where a.deletetag=1  
	  and a.kid=@kid
	  and a.a10>0
	  and a.describe='开通'
	  
      and o.[status] = 1   
      and healthapp.dbo.[getTerm_New](@kid,o.actiondatetime)=healthapp.dbo.[getTerm_New](@kid,GETDATE())  
    
  
			--幼儿资料加入取消权限
			UPDATE u SET u.ReadRight = CommonFun.dbo.fn_RoleDel(ReadRight,[dbo].[GetCurTermType_Fun](u.userid)) 
					from BasicData..[User] u 
					inner join addservice a on 
					a.[uid]=u.userid 
					where a.deletetag=1  
					and a.kid=@kid
					and a.a10>0
					and a.describe='开通' 
					and u.deletetag=1 
					
			--删除本学期阅读权限	
			delete s from sbapp..EnterRead s
			inner join addservice a on 
					a.[uid]=s.userid 
					where a.deletetag=1  
					and a.kid=@kid
					and a.a10>0
					and a.describe='开通' 
					and  healthapp.dbo.[getTerm_New](@kid,s.CrtDate)=healthapp.dbo.[getTerm_New](@kid,GETDATE())
end 	
else if(@a10>0)
begin
			
			--默认他们已经缴费(本学期不能重复创建)
			INSERT INTO sbapp..EnterRead(UserID, Kid, Name)
				select distinct u.UserID, u.Kid, u.Name 
					FROM BasicData..[user] u
					inner join addservice a on  a.[uid]=u.userid 
					left join sbapp..EnterRead s on s.UserID=u.userid 
						and  healthapp.dbo.[getTerm_New](@kid,s.CrtDate)=healthapp.dbo.[getTerm_New](@kid,GETDATE())
					where a.deletetag=1  
					and a.kid=@kid
					and a.a10=0
					and a.describe='开通' 
					and u.deletetag=1 
					and s.userid is null
			
			
			--更新状态幼儿资料加入权限
			UPDATE u 
					SET u.ReadRight =  CommonFun.dbo.fn_RoleAdd(ReadRight,[dbo].[GetCurTermType_Fun](u.userid))
					from BasicData..[User] u 
						inner join addservice a on  a.[uid]=u.userid 
						where a.deletetag=1  
							and a.kid=@kid
							and a.a10=0
							and a.describe='开通' 
end
 	
 	
 	
 	
 	
--更新VIP状态 
update a 
set a.a2=f.a2,a.a3=f.a3,a.a4=f.a4,a.a5=f.a5,a.a6=f.a6,a.a7=f.a7,a.a8=f.a8,a.a9=f.a9,a.a10=f.a10,a.a11=f.a11,a.a12=f.a12,a.a13=f.a13
 from addservice a
inner join dbo.feestandard f on a.kid=f.kid and a.a1=f.a1 and f.deletetag=1
where a.deletetag=1  and a.kid=@kid
and (
a.a2<>f.a2 
or a.a3<>f.a3 
or a.a4<>f.a4 
or a.a5<>f.a5 
or a.a6<>f.a6 
or a.a7<>f.a7 
or a.a8<>f.a8 
or a.a9<>f.a9
or a.a10<>isnull(f.a10,0)
or a.a11<>isnull(f.a11,0)
or a.a12<>isnull(f.a12,0)
or a.a13<>isnull(f.a13,0) 
)






 	 

GO
