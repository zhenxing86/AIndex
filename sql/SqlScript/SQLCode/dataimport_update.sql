USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[dataimport_Set]    Script Date: 03/03/2014 16:56:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[dataimport_update]
@id int,
@cname varchar(100), 
@birthday varchar(100), 
@account varchar(100), 
@mobile varchar(100) 
 AS 