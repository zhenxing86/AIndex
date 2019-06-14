USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_kinbaseinfo_list]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[rep_kinbaseinfo_list]
@privince int
,@city int
,@area int
,@regftime datetime
,@regltime datetime
,@kname varchar(100)
,@kid int
,@infofrom varchar(50)
 AS 

SELECT k.kid,kname,developer,privince+city+area area,netaddress,k.regdatetime,l.[name],l.mobilephone,status from kinbaseinfo k
left join kinlinks l on k.kid=l.kid and post='园长'



GO
