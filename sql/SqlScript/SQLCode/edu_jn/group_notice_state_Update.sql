USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[group_notice_state_Update]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







------------------------------------
--用途：修改一条记录 
--项目名称：group_notice_state
------------------------------------
CREATE PROCEDURE [dbo].[group_notice_state_Update] 
	@id int ,   
	@nid int ,   
	@p_kid int ,   
	@isread int ,   
	@deletefag int   	
	 AS 
	  
	declare @rcount int
	set @rcount = 0
	
	select @rcount = count(id) from group_notice_state where nid = @nid and p_kid = @p_kid
	
if(@rcount>1 or @rcount=0)
	begin
		if(@rcount>1)
			delete group_notice_state  where nid = @nid and p_kid = @p_kid
			
		INSERT INTO [group_notice_state]
		(    [nid],   [p_kid],   [isread],   [deletefag]  )
		VALUES
		(   @nid,   @p_kid,   @isread,   @deletefag  )	

		return 0
	end
else
	begin
	
		  
	declare @id_dec  int   
	declare @nid_dec  int   
	declare @p_kid_dec  int   
	declare @isread_dec  int   
	declare @deletefag_dec  int  	
	  
	 select
	  @id_dec = [id] 
	 ,   @nid_dec = [nid] 
	 ,   @p_kid_dec = [p_kid] 
	 ,   @isread_dec = [isread] 
	 ,   @deletefag_dec = [deletefag] 
	   	
	 from [group_notice_state]  where    id = @id             	
	     
	  		 if(@id > 0 or @id< 0)
			  begin
			  set @id_dec=@id 
			  end
			  	      
	  		 if(@nid > 0 or @nid< 0)
			  begin
			  set @nid_dec=@nid 
			  end
			  	      
	  		 if(@p_kid > 0 or @p_kid< 0)
			  begin
			  set @p_kid_dec=@p_kid 
			  end
			  	      
	  	
			  set @isread_dec=@isread 
	
	
			  set @deletefag_dec=@deletefag 
		  
	   
			 UPDATE [group_notice_state] SET   
			[nid]=@nid_dec ,   
			[p_kid]=@p_kid_dec ,   
			[isread]=@isread_dec ,   
			[deletefag]=@deletefag_dec   	
			 where nid = @nid and p_kid = @p_kid	
			return 0
	
	end 
	






GO
