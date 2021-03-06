USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[ArticleType_Update]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






------------------------------------
--用途：修改一条记录 
--项目名称：ArticleType
------------------------------------
CREATE PROCEDURE [dbo].[ArticleType_Update] 
	@ID int ,   
	@orderby int ,   
	@deletefag int ,   
	@parentid int ,   
	@articleTypeName varchar (50),   
	@describe varchar (2000),   
	@level int ,   
	@contentype int ,   
	@createuserid int ,     
	@webDictID int

	 AS 
	  
	declare @ID_dec  int   
	declare @orderby_dec  int   
	declare @deletefag_dec  int   
	declare @parentid_dec  int   
	declare @articleTypeName_dec  varchar (50)  
	declare @describe_dec  varchar (2000)  
	declare @level_dec  int   
	declare @contentype_dec  int   
	declare @createuserid_dec  int   
	declare @createtime_dec  datetime   
	declare @webDictID_dec  int  	
	  
	 select
	  @ID_dec = [ID] 
	 ,   @orderby_dec = [orderby] 
	 ,   @deletefag_dec = [deletefag] 
	 ,   @parentid_dec = [parentid] 
	 ,   @articleTypeName_dec = [articleTypeName] 
	 ,   @describe_dec = [describe] 
	 ,   @level_dec = [level] 
	 ,   @contentype_dec = [contentype] 
	 ,   @createuserid_dec = [createuserid] 
	 ,   @webDictID_dec = [webDictID] 
	   	
	 from [ArticleType]  where    ID = @ID                               	
	     
	  		 if(@ID > 0 or @ID< 0)
			  begin
			  set @ID_dec=@ID 
			  end
			  	      
	  		 if(@orderby > 0 or @orderby< 0)
			  begin
			  set @orderby_dec=@orderby 
			  end
			  	      
	  		 if(@deletefag > 0 or @deletefag< 0)
			  begin
			  set @deletefag_dec=@deletefag 
			  end
			  	      
	  		 if(@parentid > 0 or @parentid< 0)
			  begin
			  set @parentid_dec=@parentid 
			  end
			  	      
	  		if(@articleTypeName  is not null and @articleTypeName !='')
			  begin
			  set @articleTypeName_dec=@articleTypeName 
			  end
			  		 	      
	  		if(@describe  is not null and @describe !='')
			  begin
			  set @describe_dec=@describe 
			  end
			  		 	      
	  		 if(@level > 0 or @level< 0)
			  begin
			  set @level_dec=@level 
			  end
			  	      
	  		 if(@contentype > 0 or @contentype< 0)
			  begin
			  set @contentype_dec=@contentype 
			  end
			  	      
	  		 if(@createuserid > 0 or @createuserid< 0)
			  begin
			  set @createuserid_dec=@createuserid 
			  end
			
			  	      
	  		 if(@webDictID > 0 or @webDictID< 0)
			  begin
			  set @webDictID_dec=@webDictID 
			  end
			  	
	  
	   
	 UPDATE [ArticleType] SET   
  
	[orderby]=@orderby_dec ,   
	[deletefag]=@deletefag_dec ,   
	[parentid]=@parentid_dec ,   
	[articleTypeName]=@articleTypeName_dec ,   
	[describe]=@describe_dec ,   
	[level]=@level_dec ,   
	[contentype]=@contentype_dec ,   
	[createuserid]=@createuserid_dec ,    
	[webDictID]=@webDictID_dec   	
	where    ID = @ID                               	
	return 0
	






GO
