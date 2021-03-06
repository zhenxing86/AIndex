USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[cardinfo_BatchSet]    Script Date: 2014/11/24 23:19:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-07-20
-- Description:	
-- Memo:	
	cardinfo_BatchSet 12511, '1303001616,1303001617',0
	
	SELECT * FROM cardinfo WHERE CARD IN ('1303001616','1303001617')
	SELECT * FROM stuinfo WHERE CARD1 IN ('1303001616','1303001617')
	SELECT * FROM stuinfo WHERE CARD2 IN ('1303001616','1303001617')
	SELECT * FROM stuinfo WHERE CARD3 IN ('1303001616','1303001617')
	SELECT * FROM stuinfo WHERE CARD4 IN ('1303001616','1303001617')
*/
CREATE PROCEDURE [dbo].[cardinfo_BatchSet]
	@kid int,
	@str varchar(8000),
	@flag int ,
	@userid int = 0,
	@DoReason nvarchar(200)=NULL
	-- -1批量注销卡 将已使用的卡（usest=1） 变成 -1,同时将stuinfo中已开卡信息清除 。
	--  0批量还原卡 将已挂失的卡（usest=-1） 变成 0。
  -- -2批量作废卡 将未使用的卡（usest=0） 变成 -2。
  -- 3批量删除卡 将新开卡而且没分配给人的卡删除。
as  
BEGIN 
	SET NOCOUNT ON
	DECLARE @D1 INT,@D2 INT,@D3 INT,@D4 INT
  CREATE TABLE #CardID(col nvarchar(40))
		INSERT INTO #CardID
  		select distinct col 	--将输入字符串转换为列表
				from BasicData.dbo.f_split(@str,',')
	EXEC commonfun.dbo.SetDoInfo @DoUserID = @userid, @DoProc = 'cardinfo_BatchSet&0' --设置上下文标志
	if(@flag = 3)
	begin
		delete from c 
			FROM cardinfo c 
			inner join #CardID ci 
				on c.cardno = ci.col
				and c.kid = @kid 
				and c.usest = 0 and c.userid is null
		IF @@ROWCOUNT = 0
		RETURN -1 
	end
	else if @flag in(0,-2)
	begin		
		UPDATE c 
			SET usest = @flag,memo='',
					userid = null
			FROM cardinfo c 
			inner join #CardID ci 
				on c.cardno = ci.col
				and c.kid = @kid 
				and c.usest = case when @flag = -2 then 0 else -1 end
		IF @@ROWCOUNT = 0
		RETURN -1 
	end
	else if @flag = -1
	begin		
		UPDATE c SET usest = -1,memo=@DoReason, 
					userid = null
			FROM cardinfo c 
			inner join #CardID ci 
				on c.cardno = ci.col
				and c.kid = @kid  
				and c.usest = 1
		IF @@ROWCOUNT = 0
		RETURN -1 	
	end
	EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志    
		RETURN 1 

END

GO
