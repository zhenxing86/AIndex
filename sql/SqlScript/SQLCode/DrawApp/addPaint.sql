USE [DrawApp]
GO
/****** Object:  StoredProcedure [dbo].[addPaint]    Script Date: 2014/11/24 23:01:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[addPaint] 
@uid int,
@title varchar(500),
@filepath varchar(500),
@filename varchar(500),
@filesize varchar(500),
@createdatetime datetime,
@operatype int,
@smallpath varchar(500),
@weburl varchar(500),
@kid int,
@share int
as

INSERT INTO Gallery(userId,title,filepath,filename,filesize,createdatetime,operatype,uname,cname,smallpath,weburl,kid,share)
select
@uid,@title,@filepath,@filename,@filesize,@createdatetime,@operatype,b.[name],c.cname,@smallpath,@weburl,@kid,@share
from
basicdata..user_class uc
inner join basicdata..class c on uc.cid=c.cid and c.kid=@kid
inner join basicdata..[user] b on b.userid=uc.userid 
where b.userid = @uid

GO
