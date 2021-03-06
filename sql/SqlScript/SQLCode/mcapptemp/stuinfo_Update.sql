USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[stuinfo_Update]    Script Date: 2014/11/24 23:19:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-07-22
-- Description:	学生开卡
-- Memo:	
exec stuinfo_Update 
	@stuid = 295767,
	@tts = '',
	@card1 = '1303001716',
	@card2 = '1303001717',
	@card3 = '1303001720',
	@card4 = '1303001722',	
	@userid = 123	,
	@DoWhere  = 1
*/
CREATE PROCEDURE [dbo].[stuinfo_Update] 
	@stuid int,
	@tts varchar(50),
	@card1 varchar(40),
	@card2 varchar(40),
	@card3 varchar(40),
	@card4 varchar(40),
	@userid int = 0,
	@DoWhere int = null, --0后台操作,1用户操作
	@DoReason varchar(200) = null 
AS 
BEGIN
	SET NOCOUNT ON
	DECLARE @kid int
	SELECT @kid = kid from BasicData..[user] where userid = @stuid
	IF NULLIF(@card1,'') = NULLIF(@card2,'')
	or NULLIF(@card1,'') = NULLIF(@card3,'')
	or NULLIF(@card1,'') = NULLIF(@card4,'')
	or NULLIF(@card2,'') = NULLIF(@card3,'')
	or NULLIF(@card2,'') = NULLIF(@card4,'')
	or NULLIF(@card3,'') = NULLIF(@card4,'')
	RETURN -1
	DECLARE @DoProc varchar(100)
	set @DoProc = 'stuinfo_Update&'+ISNULL(cast(@DoWhere as varchar(10)),'')
	EXEC commonfun.dbo.SetDoInfo @DoUserID = @userid, @DoProc = @DoProc --设置上下文标志
		 
	update BasicData..[user] 
		set tts = @tts 
		where userid = @stuid 
			and ISNULL(@tts,'') <> ''
			
	UPDATE cardinfo 
		SET userid = @stuid,memo='',
				usest = 1 
		WHERE cardno IN(@card1,@card2,@card3,@card4)
			and kid = @kid
	
	UPDATE cardinfo 
		SET userid = NULL, memo=@DoReason,
				usest = -1
		WHERE userid = @stuid 
			AND cardno NOT IN(@card1,@card2,@card3,@card4)
	EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志      
END

GO
