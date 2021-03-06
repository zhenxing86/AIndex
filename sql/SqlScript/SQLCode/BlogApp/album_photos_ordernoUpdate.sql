USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[album_photos_ordernoUpdate]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


------------------------------------
--用途：修改排序
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-10-06 14:50:00
--exec album_photos_ordernoUpdate 363,0
--select photoid,orderno From album_photos where categoriesid=136
------------------------------------
CREATE PROCEDURE [dbo].[album_photos_ordernoUpdate]
@photoid int,
@opt int
 AS
	declare @curorderno int
	declare @nextorderno int
	declare @nextphotoid int
	declare @categoriesid int
	if(@opt=-1 or @opt=1)
	begin
		select @curorderno=orderno,@categoriesid=categoriesid from album_photos where photoid=@photoid
		select @nextorderno=@curorderno+@opt
		select @nextphotoid=photoid from album_photos where categoriesid=@categoriesid and orderno=@nextorderno and deletetag=1
		--print @nextorderno
		--print @curorderno	
		update album_photos set orderno=@nextorderno where photoid=@photoid
		update album_photos set orderno=@curorderno where photoid=@nextphotoid
	end
	else if (@opt=0)
	begin
		declare @photocount int		
		select @curorderno=orderno,@categoriesid=categoriesid from album_photos where photoid=@photoid		
		select @photocount=count(photoid) from album_photos where categoriesid=@categoriesid and deletetag=1
		select @nextorderno=@photocount
		select @nextphotoid=photoid from album_photos where categoriesid=@categoriesid and orderno=@nextorderno	 and deletetag=1	
		update album_photos set orderno=orderno-1 where categoriesid=@categoriesid and orderno>@curorderno and deletetag=1
		--print @nextorderno
		--print @curorderno
		update album_photos set orderno=@nextorderno where photoid=@photoid		
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
