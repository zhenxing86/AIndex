USE [EBook]
GO
/****** Object:  StoredProcedure [dbo].[ib_setting]    Script Date: 2014/11/24 23:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[ib_setting]
@kid int
 AS 	

--declare @kid int
--set @kid=-1
--行政管理章程
declare @ibid int

if(not exists(select * from ib_introbook where kid=@kid and booktype=1))
begin


insert into ib_introbook(kid,createdatetime,theme,bookname,booktype)
select @kid,getdate(),theme,bookname,booktype from ib_introbook where introbookid=1
SELECT @ibid=@@IDENTITY
INSERT INTO [EBook].[dbo].[ib_chapter]([introbookid],[chaptertitle],[chaptercontent],[textpagecount],[createdate],[tlfcontent])
select @ibid,chaptertitle,chaptercontent,textpagecount,getdate(),tlfcontent 
from ib_chapter where introbookid=1


end



GO
