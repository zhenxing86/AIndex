USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[dict_Area_model]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create PROCEDURE [dbo].[dict_Area_model]
 @id int
 
 AS 

select 0,ID,Title,Code,Superior,[Level],1,areanum from basicdata..area
where id=@id



GO
