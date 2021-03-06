USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[init_remindlog]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--Add
--select * from dbo.remindlog
--rid=@ID,url='/beforefollowremark/Index?uc=2&kfid=@bf_Id','跟踪提醒',@remark,@remindtime,@uid,1
------------------------------------
create PROCEDURE [dbo].[init_remindlog]

 
 AS 

insert into remindlog(rid,attention,result,info,intime,uid,deletetag)
select 
k.ID
,'/beforefollowremark/Index_Main?uc=10&kid='++convert(varchar,b.kid)
,'待跟踪'
,'[跟踪提醒]'+k.remark
,remindtime
,k.uid
,1 from beforefollowremark k
inner join beforefollow b on b.ID=k.bf_Id
where remindtime<'2800-1-1' and b.kid>0 and k.ID not in (select rid from dbo.remindlog where result='待跟踪')


insert into remindlog(rid,attention,result,info,intime,uid,deletetag)
select 
k.ID
,'/beforefollowremark/Index?uc=2&kfid='+convert(varchar,k.bf_Id)
,'待跟踪'
,'[跟踪提醒]'+k.remark
,remindtime
,k.uid
,1 from beforefollowremark k
inner join beforefollow b on b.ID=k.bf_Id
where remindtime<'2800-1-1' and b.kid=0  and k.ID not in (select rid from dbo.remindlog where result='待跟踪')



GO
