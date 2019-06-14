USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[beforefollowremark_DeleteTag]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--Deletetag
------------------------------------
CREATE PROCEDURE [dbo].[beforefollowremark_DeleteTag]
@id int
,@uid int
,@remindtype varchar(100)
 AS 
	update  [beforefollowremark] set deletetag=0
	 WHERE ID=@id 

update remindlog set deletetag=0
where rid=@ID and result=@remindtype+'提醒'


insert into remindlog_bak(rid,attention,result,info,intime,uid,deletetag,dotype,dotime)
values(@id,'','待'+@remindtype,'['+@remindtype+'提醒]','',@uid,1,'删除',getdate())





GO
