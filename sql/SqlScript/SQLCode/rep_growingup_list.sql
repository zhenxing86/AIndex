USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_growingup_list]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[rep_growingup_list]
@upstime datetime
,@upltime datetime
,@kname datetime
,@status varchar(100)
 AS 

select '' kname,'' cname,'' mobilephone,'' account,'' inittime,'' applytime,'' status


GO
