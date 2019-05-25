USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[Cards_GetModel]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[Cards_GetModel]
@id int
as
select cardid,ShowDay,FestivalCard,s.ShowMonth,  s.gtype 
 from Cards c left join CardSet s on c.cgid=s.cgid where cardid=@id
GO
