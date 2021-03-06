USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_photos_ordernoUpdate]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：修改排序
--项目名称：classhomepage
--说明：
--时间：2009-3-21 14:50:00
------------------------------------
CREATE PROCEDURE [dbo].[class_photos_ordernoUpdate]
@photoid int,
@opt int
 AS
	declare @curorderno int
	declare @nextorderno int
	declare @nextphotoid int
	declare @categoriesid int

	if(@opt=-1 or @opt=1)
	begin
		select @curorderno=orderno,@categoriesid=albumid from class_photos where photoid=@photoid
		select @nextorderno=@curorderno+@opt
		select @nextphotoid=photoid from class_photos where albumid=@categoriesid and orderno=@nextorderno
		update class_photos set orderno=@nextorderno where photoid=@photoid
		update class_photos set orderno=@curorderno where photoid=@nextphotoid
	end
	else if (@opt=0)
	begin
		declare @photocount int		
		select @curorderno=orderno,@categoriesid=albumid from class_photos where photoid=@photoid		
		select @photocount=count(photoid) from class_photos where albumid=@categoriesid
		select @nextorderno=@photocount
		select @nextphotoid=photoid from class_photos where albumid=@categoriesid and orderno=@nextorderno		
		update class_photos set orderno=orderno-1 where albumid=@categoriesid and orderno>@curorderno
		update class_photos set orderno=@nextorderno where photoid=@photoid		
	end

	IF @@ERROR <> 0 
	BEGIN
	   RETURN(-1)
	END
	ELSE
	BEGIN		
	   RETURN (1)
	END











GO
