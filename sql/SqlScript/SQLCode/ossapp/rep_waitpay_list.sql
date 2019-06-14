USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_waitpay_list]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[rep_waitpay_list]
@arrearsday int
,@parentsfees varchar(100)
,@kid int
,@kname varchar(100)
 AS 

select  p.Kid,p.kname,[money],paytime,parentpay,datediff(dd,lasttime,getdate()) urgesday
from payinfo p
left join dbo.kinbaseinfo k on k.kid=p.kid 



GO
