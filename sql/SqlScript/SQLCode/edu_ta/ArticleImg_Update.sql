USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[ArticleImg_Update]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







------------------------------------
--用途：修改一条记录 
--项目名称：ArticleImg
------------------------------------
CREATE PROCEDURE [dbo].[ArticleImg_Update] 
   
	@aid int ,   
	@title varchar (30),   
	@filepath varchar (200),   
	@filename varchar (200),   
	@filesize varchar (200),   
	@filetype int 
	
	 AS 
	
	declare @count int
	select @count = Count(id) from [ArticleImg] where aid = @aid

	if(@count<1)
	begin
		INSERT INTO [jnyjdj].[dbo].[ArticleImg]
           ([aid]
           ,[title]
           ,[filepath]
           ,[filename]
           ,[filesize]
           ,[filetype]
           ,[createdatetime])
     VALUES
           (@aid
           ,@title
           ,@filepath
           ,@filename
           ,'0'
           ,@filetype
           ,GETDATE())
	end
	  
	declare @ID_dec  int   
	declare @aid_dec  int   
	declare @title_dec  varchar (30)  
	declare @filepath_dec  varchar (200)  
	declare @filename_dec  varchar (200)  
	declare @filesize_dec  varchar (200)  
	declare @filetype_dec  int   
	declare @createdatetime_dec  datetime  	
	  
	 select
	  @ID_dec = [ID] 
	 ,   @aid_dec = [aid] 
	 ,   @title_dec = [title] 
	 ,   @filepath_dec = [filepath] 
	 ,   @filename_dec = [filename] 
	 ,   @filesize_dec = [filesize] 
	 ,   @filetype_dec = [filetype] 
	 ,   @createdatetime_dec = [createdatetime] 
	   	
	 from [ArticleImg]  where    aid = @aid                      	
	
			  	      
	  		 if(@aid > 0 or @aid< 0)
			  begin
			  set @aid_dec=@aid 
			  end
			  	      
	  		if(@title  is not null and @title !='')
			  begin
			  set @title_dec=@title 
			  end
			  		 	      
	  		if(@filepath  is not null and @filepath !='')
			  begin
			  set @filepath_dec=@filepath 
			  end
			  		 	      
	  		if(@filename  is not null and @filename !='')
			  begin
			  set @filename_dec=@filename 
			  end
			  		 	      
	  		if(@filesize  is not null and @filesize !='')
			  begin
			  set @filesize_dec=@filesize 
			  end
			  		 	      
	  		 if(@filetype > 0 or @filetype< 0)
			  begin
			  set @filetype_dec=@filetype 
			  end
			  	      
	  		
			  	   	   
	   
	 UPDATE [ArticleImg] SET   
	[aid]=@aid_dec ,   
	[title]=@title_dec ,   
	[filepath]=@filepath_dec ,   
	[filename]=@filename_dec ,   
	[filesize]=@filesize_dec ,   
	[filetype]=@filetype_dec ,   
	[createdatetime]=@createdatetime_dec   	
	where    aid = @aid                      	
	return 0
	






GO
