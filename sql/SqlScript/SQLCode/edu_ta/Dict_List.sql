USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[Dict_List]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[Dict_List]
@ty varchar(50)
as 
select * from BasicData..Dict where [Catalog] like @ty







GO
