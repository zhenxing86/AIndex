USE [GBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[ArchivesApply_AddModel_By_UserId]    Script Date: 2014/11/24 23:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--drop PROCEDURE [dbo].[ArchivesApply_AddTag]
------------------------------------
--用途：根据小朋友userid，处理时间，学期新增整个该小朋友成长档案申请记录，并将设为制作完成状态status=1
--项目名称：com.zgyey.ArchivesApply
--说明：由于本地成长档案制作软件制作完后不会更新状态，这里做处理
--时间：2013-1-15 12:43:20
------------------------------------
CREATE PROCEDURE [dbo].[ArchivesApply_AddModel_By_UserId]
@userId int,
@handleTime datetime,
@term nvarchar(50)
 AS 
 
insert into gbapp..archives_apply(gbid,gid,gname,cid,cname,kid,kname,userid,username,
									applytime,handletime,telephone,modules,term,url,[status],deletetag)
select	gb.gbid,g.gid,g.gname,c.cid,c.cname,k.kid,k.kname,u.userid,u.name,GETDATE(),
				@handletime,u.mobile,m.gbmodule,m.term,CONVERT(nvarchar(50),k.kid)+k.kname+'/'+g.gname+'_'+c.cname+'/'+u.name+'的成长档案.zip',1,1
from BasicData..[user] u 
	inner join BasicData..user_class uc on uc.userid =u.userid
	inner join BasicData..class c on c.cid =uc.cid
	inner join BasicData..kindergarten k on k.kid=c.kid
	inner join GBApp..HomeBook hb on hb.kid =k.kid and hb.classid=c.cid 
	inner join GBApp..GrowthBook gb on gb.hbid = hb.hbid and gb.userid = u.userid 
	inner join BasicData..grade g on g.gid = c.grade
	inner join gbapp..moduleset m on m.kid = k.kid and m.term=gb.term and m.term = @term
where u.userid=@userId



GO
