USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[hb_image_save]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create Procedure [dbo].[hb_image_save]
@hbid int,
@ColName Varchar(100),
@EditUrl NVarchar(300)
as

--学期寄语
if(@ColName='forewordpic')
begin

update HomeBook set ForewordPic=@EditUrl where hbid=@hbid

end
--班级宣言
else if(@ColName='classpic')
begin

update HomeBook set ClassPic=@EditUrl where hbid=@hbid

end

GO
