USE [KinInfoApp]
GO
/****** Object:  StoredProcedure [dbo].[group_notice_state_Add]    Script Date: 08/10/2013 10:26:17 ******/
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
