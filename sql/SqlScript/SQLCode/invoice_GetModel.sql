USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[invoice_GetModel]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--GetModel
------------------------------------
CREATE PROCEDURE [dbo].[invoice_GetModel]
@id int
 AS 
	SELECT 
	 1      ,g.[ID]    ,g.[kid]    ,g.[kname]    ,[pid]    ,d.info [title]   
 ,[money]    ,[nominal]    ,[taxnumber]    ,[pernum]    ,g.[address] 
   ,k.[mobile]    ,[bank]    ,[banknum]    ,g.[remark]    ,[state]    ,g.[uid]  
  ,[uname]    ,[intime]    ,[doid]    ,[dotime]    ,g.[deletetag],invoicetitle   	 FROM 
[invoice] g
inner join dict d on d.ID=[title]
inner join dbo.kinbaseinfo k on g.kid=k.kid
	 WHERE g.ID=@id 


GO
