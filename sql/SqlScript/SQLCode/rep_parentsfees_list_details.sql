USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_parentsfees_list_details]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[rep_parentsfees_list_details]
@feeftime datetime
,@feeltime datetime
,@package varchar(100)
 AS 

select '' uid,'' typename,'' msg,'' soundread,'' hometown,'' grouparchives


GO
