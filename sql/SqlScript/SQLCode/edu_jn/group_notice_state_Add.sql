USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[group_notice_state_Add]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







------------------------------------
--用途：增加一条记录 
--名称：group_notice_state
------------------------------------
CREATE PROCEDURE [dbo].[group_notice_state_Add] 
	@id int ,   
	@nid int ,   
	@p_kid int ,   
	@isread int ,   
	@deletefag int   		
	 AS 
INSERT INTO [group_notice_state]
(    [nid],   [p_kid],   [isread],   [deletefag]  )
VALUES
(   @nid,   @p_kid,   @isread,   @deletefag  )	
	RETURN 0







GO
