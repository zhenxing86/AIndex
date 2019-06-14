USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[beforefollow_GetModel]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--GetModel
------------------------------------
CREATE PROCEDURE [dbo].[beforefollow_GetModel]
@id int
 AS 
	SELECT 
	1      ,g.[ID]    ,[kid]    ,[kname]    ,[nature]    ,[classcount]   
 ,[provice]    ,[city]    ,[area]    ,[linebus]    ,[address]    ,[linkname]  
  ,[title]    ,[tel]    ,g.[qq]    ,[email]    ,[netaddress]    ,g.[remark]  
  ,[uid]    ,g.[bid]    ,g.[mobile]    ,g.[ismaterkin]    ,g.[parentbfid]   ,[childnum]    ,[childnumre],[intime]    ,g.[deletetag],u.[name] ,
s.[name]
	 FROM [beforefollow] g
left join users u on u.ID =g.uid
left join users s on s.ID =u.seruid

	 WHERE g.ID=@id 




GO
