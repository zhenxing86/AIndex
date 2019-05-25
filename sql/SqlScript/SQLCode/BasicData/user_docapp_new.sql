USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_docapp_new]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[user_docapp_new]
@userid int
as 

if(not exists(select 1 from docapp..thelp_categories where userid=@userid))
begin
INSERT INTO docapp..thelp_categories([parentid],[userid],[title],[description],[status],[documentcount],[createdatetime])
select 0,@userid,u.[title],u.[description],u.displayorder,u.[status],getdate() from user_add_dict u
where [catalog]='thelp_categories' and usertype=1

end




GO
