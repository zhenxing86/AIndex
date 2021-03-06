USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[Attachs_Update]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








------------------------------------
--用途：修改一条记录 
--项目名称：Attachs
------------------------------------
CREATE PROCEDURE [dbo].[Attachs_Update] 
	@ID int ,   
	@pid int ,   
	@title varchar (30),   
	@filepath varchar (200),   
	@filename varchar (200),   
	@filesize varchar (200),   
	@filetype int 
	 AS 
	  
	declare @ID_dec  int   
	declare @pid_dec  int   
	declare @title_dec  varchar (30)  
	declare @filepath_dec  varchar (200)  
	declare @filename_dec  varchar (200)  
	declare @filesize_dec  varchar (200)  
	declare @filetype_dec  int   
	declare @createdatetime_dec  datetime  	
	  
	 select
	  @ID_dec = [ID] 
	 ,   @pid_dec = [pid] 
	 ,   @title_dec = [title] 
	 ,   @filepath_dec = [filepath] 
	 ,   @filename_dec = [filename] 
	 ,   @filesize_dec = [filesize] 
	 ,   @filetype_dec = [filetype] 
	 ,   @createdatetime_dec = [createdatetime] 
	   	
	 from [Attachs]  where    ID = @ID                      	
	     
	  		 if(@ID > 0 or @ID< 0)
			  begin
			  set @ID_dec=@ID 
			  end
			  	      
	  		 if(@pid > 0 or @pid< 0)
			  begin
			  set @pid_dec=@pid 
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
			  	      
	  		
			  	   	   
	   
	 UPDATE [Attachs] SET   
	[pid]=@pid_dec ,   
	[title]=@title_dec ,   
	[filepath]=@filepath_dec ,   
	[filename]=@filename_dec ,   
	[filesize]=@filesize_dec ,   
	[filetype]=@filetype_dec ,   
	[createdatetime]=@createdatetime_dec   	
	where    ID = @ID                      	
	return 0
	









GO
