USE [EBook]
GO
/****** Object:  StoredProcedure [dbo].[mb_setting]    Script Date: 2014/11/24 23:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[mb_setting] 
@kid int
 AS 	

--declare @kid int
--set @kid=-1
--行政管理章程
declare @ibid int

if(not exists(select * from ib_introbook where kid=@kid and booktype<>1))
begin

insert into ib_introbook(kid,createdatetime,theme,bookname,booktype)
select @kid,getdate(),theme,bookname,booktype from ib_introbook where introbookid=3
SELECT @ibid=@@IDENTITY
INSERT INTO [EBook].[dbo].[ib_chapter]([introbookid],[chaptertitle],[chaptercontent],[textpagecount],[createdate],[tlfcontent])
select @ibid,chaptertitle,chaptercontent,textpagecount,getdate(),tlfcontent from ib_chapter where introbookid=3


--家园工作手册
insert into ib_introbook(kid,createdatetime,theme,bookname,booktype)
select @kid,getdate(),theme,bookname,booktype from ib_introbook where introbookid=8
SELECT @ibid=@@IDENTITY
INSERT INTO [EBook].[dbo].[ib_chapter]([introbookid],[chaptertitle],[chaptercontent],[textpagecount],[createdate],[tlfcontent])
select @ibid,chaptertitle,chaptercontent,textpagecount,getdate(),tlfcontent from ib_chapter where introbookid=8

--教学管理规定
insert into ib_introbook(kid,createdatetime,theme,bookname,booktype)
select @kid,getdate(),theme,bookname,booktype from ib_introbook where introbookid=6
SELECT @ibid=@@IDENTITY
INSERT INTO [EBook].[dbo].[ib_chapter]([introbookid],[chaptertitle],[chaptercontent],[textpagecount],[createdate],[tlfcontent])
select @ibid,chaptertitle,chaptercontent,textpagecount,getdate(),tlfcontent from ib_chapter where introbookid=6

--岗位职责
insert into ib_introbook(kid,createdatetime,theme,bookname,booktype)
select @kid,getdate(),theme,bookname,booktype from ib_introbook where introbookid=4
SELECT @ibid=@@IDENTITY
INSERT INTO [EBook].[dbo].[ib_chapter]([introbookid],[chaptertitle],[chaptercontent],[textpagecount],[createdate],[tlfcontent])
select @ibid,chaptertitle,chaptercontent,textpagecount,getdate(),tlfcontent from ib_chapter where introbookid=4


--卫生保健
insert into ib_introbook(kid,createdatetime,theme,bookname,booktype)
select @kid,getdate(),theme,bookname,booktype from ib_introbook where introbookid=7
SELECT @ibid=@@IDENTITY
INSERT INTO [EBook].[dbo].[ib_chapter]([introbookid],[chaptertitle],[chaptercontent],[textpagecount],[createdate],[tlfcontent])
select @ibid,chaptertitle,chaptercontent,textpagecount,getdate(),tlfcontent from ib_chapter where introbookid=7


--人事管理条例
insert into ib_introbook(kid,createdatetime,theme,bookname,booktype)
select @kid,getdate(),theme,bookname,booktype from ib_introbook where introbookid=5
SELECT @ibid=@@IDENTITY
INSERT INTO [EBook].[dbo].[ib_chapter]([introbookid],[chaptertitle],[chaptercontent],[textpagecount],[createdate],[tlfcontent])
select @ibid,chaptertitle,chaptercontent,textpagecount,getdate(),tlfcontent from ib_chapter where introbookid=5

end
GO
