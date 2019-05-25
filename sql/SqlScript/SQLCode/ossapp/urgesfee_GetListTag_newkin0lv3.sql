USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[urgesfee_GetListTag_newkin0lv3]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[urgesfee_GetListTag_newkin0lv3]
@cuid int
,@bid int
 AS 

--新老客户所有欠费的
--代理商客服部：可以看到所有代理商的客户
SET ROWCOUNT 100

SELECT 	0 ,ID    ,kid    ,[expiretime]    ,0    ,[kname],''    ,deletetag,infofrom  ,@bid	 
FROM [kinbaseinfo]  where deletetag=1 and [expiretime]<getdate() and status='欠费'
and abid=@bid and infofrom='代理'
order by [expiretime] desc


GO
