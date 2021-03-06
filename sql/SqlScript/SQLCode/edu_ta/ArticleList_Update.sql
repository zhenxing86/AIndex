USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[ArticleList_Update]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







------------------------------------
--用途：修改一条记录 
--项目名称：ArticleList
------------------------------------
CREATE PROCEDURE [dbo].[ArticleList_Update] 
	@ID int ,   
	@typeid int ,   
	@title varchar (200),   
	@body varchar(MAX),   
	@describe varchar (500),   
	@autor varchar (50),   
	@level int ,   
	@isMaster int ,   
	@orderID int ,   
	@reMark varchar (300),   
	@uid int ,    
	@deletetag int = 1  	
	 AS 
	  
	declare @ID_dec  int   
	declare @typeid_dec  int   
	declare @title_dec  varchar (200)  
	declare @body_dec  varchar(MAX)  
	declare @describe_dec  varchar (500)  
	declare @autor_dec  varchar (50)  
	declare @level_dec  int   
	declare @isMaster_dec  int   
	declare @orderID_dec  int   
	declare @reMark_dec  varchar (300)  
	declare @uid_dec  int   
	declare @createtime_dec  datetime   
	declare @deletetag_dec  int  	
	  
	 select
	  @ID_dec = [ID] 
	 ,   @typeid_dec = [typeid] 
	 ,   @title_dec = [title] 
	 ,   @body_dec = [body] 
	 ,   @describe_dec = [describe] 
	 ,   @autor_dec = [autor] 
	 ,   @level_dec = [level] 
	 ,   @isMaster_dec = [isMaster] 
	 ,   @orderID_dec = [orderID] 
	 ,   @reMark_dec = [reMark] 
	 ,   @uid_dec = [uid] 
	 ,   @createtime_dec = [createtime] 
	 ,   @deletetag_dec = [deletetag] 
	   	
	 from [ArticleList]  where    ID = @ID                                     	
	     
	  		 if(@ID > 0 or @ID< 0)
			  begin
			  set @ID_dec=@ID 
			  end
			  	      
	  		 if(@typeid > 0 or @typeid< 0)
			  begin
			  set @typeid_dec=@typeid 
			  end
			  	      
	  		if(@title  is not null and @title !='')
			  begin
			  set @title_dec=@title 
			  end
			  		 	      
	  		if(@body  is not null and @body !='')
			  begin
			  set @body_dec=@body 
			  end
			  		 	      
	  		if(@describe  is not null and @describe !='')
			  begin
			  set @describe_dec=@describe 
			  end
			  		 	      
	  		if(@autor  is not null and @autor !='')
			  begin
			  set @autor_dec=@autor 
			  end
			  		 	      
	  		 if(@level > 0 or @level< 0)
			  begin
			  set @level_dec=@level 
			  end
			  	      
	  		 if(@isMaster > 0 or @isMaster< 0)
			  begin
			  set @isMaster_dec=@isMaster 
			  end
			  	      
	  		 if(@orderID > 0 or @orderID< 0)
			  begin
			  set @orderID_dec=@orderID 
			  end
			  	      
	  		if(@reMark  is not null and @reMark !='')
			  begin
			  set @reMark_dec=@reMark 
			  end
			  		 	      
	  		 if(@uid > 0 or @uid< 0)
			  begin
			  set @uid_dec=@uid 
			  end
			  	      
	  		
			  	      
	  
	set @deletetag_dec=@deletetag 
	
			  	   	   
	   
	 UPDATE [ArticleList] SET   
	[typeid]=@typeid_dec ,   
	[title]=@title_dec ,   
	[body]=@body_dec ,   
	[describe]=@describe_dec ,   
	[autor]=@autor_dec ,   
	[level]=@level_dec ,   
	[isMaster]=@isMaster_dec ,   
	[orderID]=@orderID_dec ,   
	[reMark]=@reMark_dec ,   
	[uid]=@uid_dec ,   
	[createtime]=@createtime_dec ,   
	[deletetag]=@deletetag_dec   	
	where    ID = @ID                                     	
	return 0






GO
