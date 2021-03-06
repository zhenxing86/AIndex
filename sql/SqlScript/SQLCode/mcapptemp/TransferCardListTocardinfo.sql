USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[TransferCardListTocardinfo]    Script Date: 2014/11/24 23:19:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-11-08
-- Description:	
-- Memo:		
*/
CREATE PROC [dbo].[TransferCardListTocardinfo]
	@kid int
as
BEGIN
	SET NOCOUNT ON
	insert into mcapp..cardinfo(kid,card,usest,CardType,userid,EnrolNum)
		select cc.kid,cc.cardno,cc.Status,2,uc.userid,EnrolNum 
			from CardApp..CardList cc 
				left join CardApp..UserCard uc 
				on cc.CardNo = uc.CardNo
				and cc.KID = uc.kid
		where cc.KID = @kid 
			AND not exists(select * from mcapp..cardinfo where cardno = cc.CardNo and kid = cc.KID)
END

GO
