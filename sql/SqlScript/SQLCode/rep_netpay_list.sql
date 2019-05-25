USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_netpay_list]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[rep_netpay_list]
@payftime datetime
,@payltime datetime
 AS 

SELECT count(kid) monthkin
,sum([money]) monthmoney
,count(kid) newkin
,sum([money]) newmoney
,count(kid) lastyearkin
,sum([money]) lastyearmoney 
from dbo.payinfo




GO
