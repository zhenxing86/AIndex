USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[AppCard_Add]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*  
-- Author:    
-- Create date: 2014-05-12
-- Description: 手机成长档案新增卡片
-- Memo:        
*/   
create Procedure [dbo].[AppCard_Add]
@grade Varchar(100),--托班、小班、中班、大班
@month Int,
@url Varchar(100)
as
begin
Declare @gtype int, @cgid Int,@flag int,@reurl varchar(50)
Select @gtype = Case @grade When '托班' Then 4 When '小班' Then 1
                          When '中班' Then 2 When '大班' Then 3 End 
                          
Select @reurl =  Case @grade When '托班' Then '2-3' When '小班' Then '3-4' 
                          When '中班' Then '4-5' When '大班' Then '5-6' End + '/' + CAST(@month as Varchar) + '/'
select @url='http://czkp.zgyey.com/appcard/'+@reurl+@url
insert into AppCard(gtype,ShowMonth,url) values(@gtype,@month,@url)

IF(@@ERROR<>0)
    RETURN 0
  ELSE
   RETURN 1
end
GO
