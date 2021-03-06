USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[album_categories_ordernoUpdate]    Script Date: 2014/11/25 11:50:42 ******/
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
CREATE PROCEDURE [dbo].[album_categories_ordernoUpdate]
@categoriesid int,
@opt int
 AS
	declare @curorderno int
	declare @nextorderno int
	declare @nextcategoriesid int
	declare @userid int

	if(@opt=-1 or @opt=1)
	begin
		select @curorderno=orderno,@userid=userid from album_categories where categoriesid=@categoriesid and deletetag=1
		select @nextorderno=@curorderno+@opt
		select @nextcategoriesid=categoriesid from album_categories where userid=@userid and orderno=@nextorderno and deletetag=1
		update album_categories set orderno=@nextorderno where categoriesid=@categoriesid
		update album_categories set orderno=@curorderno where categoriesid=@nextcategoriesid
	end
	else if (@opt=0)
	begin	
		DECLARE @categoriescount int		
		select @curorderno=orderno,@userid=userid from album_categories where categoriesid=@categoriesid and deletetag=1
		SELECT @categoriescount=count(categoriesid) FROM album_categories WHERE userid=@userid and deletetag=1
		SELECT @nextorderno=@categoriescount
		SELECT @nextcategoriesid=categoriesid FROM album_categories WHERE userid=@userid and orderno=@nextorderno and deletetag=1
		update album_categories set orderno=orderno-1 where userid=@userid and orderno>@curorderno and deletetag=1
		update album_categories set orderno=@nextorderno where categoriesid=@categoriesid		
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
