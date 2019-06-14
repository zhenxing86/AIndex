USE [DrawApp]
GO
/****** Object:  StoredProcedure [dbo].[updatePay]    Script Date: 2014/11/24 23:01:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	更新购买类型
-- =============================================
CREATE PROCEDURE [dbo].[updatePay]
@uid int,@buytype int
AS
   declare @n int
   
   select @n= sum(buytype) from DrawApp..Buy where [uid] = @uid
   
   if(@n <>3 and @n<>@buytype or @n is null)
   begin
      insert into DrawApp..Buy values(@uid,@buytype,GETDATE());
   end


GO
