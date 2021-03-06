USE [KWebCMS]
GO
/****** Object:  Trigger [dbo].[Trg_cms_content]    Script Date: 05/04/2014 15:03:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-12-20 
-- Description:	
-- Memo: 		
*/
ALTER TRIGGER [dbo].[Trg_cms_content]  
   ON  [dbo].[cms_content] 
   AFTER INSERT
AS 
BEGIN
	if @@RowCount <= 0 Return                
	set nocount on	 
		INSERT INTO BasicData..MainPageList(kid, userid, type, Tag, TagValue, Status)
			select Distinct uc.kid, uc.userid, 1, 1, i.contentid, 1
				FROM inserted i 
					inner join cms_category cc 
						on i.categoryid = cc.categoryid
						and cc.categorycode in('xw','gg')
					inner join BasicData..User_Child uc on i.siteid = uc.kid
				where exists(select 1 from AndroidApp..and_userinfo au where uc.userid = au.userid)
          and not exists (Select * From BasicData..MainPageList a 
                            Where a.userid = uc.userid and a.TagValue = i.contentid and a.Tag = 1 and a.Status = 1)

END
