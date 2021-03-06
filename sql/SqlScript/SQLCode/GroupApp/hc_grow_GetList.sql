USE [HealthApp]
GO
/****** Object:  StoredProcedure [dbo].[hc_grow_GetList]    Script Date: 2014/11/24 23:10:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================  
-- Author:  <Author,,Name>  
-- Create date: <Create Date,,>  
-- Description: <Description,,>  
-- hc_grow_GetList 801154
-- =============================================  
CREATE PROCEDURE [dbo].[hc_grow_GetList] 
@userid int  
AS  
  
SET NOCOUNT ON;  

With Data as (
Select indate, height, weight, ROW_NUMBER() Over(Partition by Convert(Varchar(7), indate, 120) Order by byTeacher Desc, indate Desc) Row
  From hc_grow Where userid = @userid
)
Select * Into #Data From Data Where Row = 1

if Not Exists (Select * From #Data)
  Insert Into #Data(indate, height, weight, Row) Values(Getdate(), 0.0, 0.0, 1)

;With Data1 as (
Select min(indate) mi, max(indate) ma From #Data
), Data2 as (
Select Convert(Varchar(7), Dateadd(mm, -1 * a.n, Getdate()), 120) DD
  From (Select n - 1 n From [CommonFun].[dbo].[Nums100]) a
  Where Exists (Select * From Data1 b Where Datediff(mm, b.mi, Getdate()) >= a.n and Datediff(mm, b.ma, Getdate()) <= a.n)
)
Select a.DD indate, Isnull(b.height, 0.0) height, Isnull(b.weight, 0.0) weight
  From Data2 a Left Join #Data b On a.DD = Convert(Varchar(7), b.indate, 120) 
  order by indate

declare @birthday Date, @gender Int
Select @birthday = Isnull(birthday, Dateadd(yy, -2, regdatetime)), @gender = gender From BasicData.dbo.[user] Where userid = @userid

Select dateadd(mm, months, @birthday) indate, minHeight, maxHeight, minWeight, maxWeight, months    
  From hc_standard_grow 
  Where deletetag = 1 and months >= Case When Datediff(mm, @birthday, GETDATE()) < 21 Then Case When @gender = 3 Then 24 Else 21 End Else Datediff(mm, @birthday, GETDATE()) - 3 End
    and months < Case When Datediff(mm, @birthday, GETDATE()) < 21 Then Case When @gender = 3 Then 25 Else 22 End Else Datediff(mm, @birthday, GETDATE()) + 3 End and gender = @gender

--历史  
Select indate, height, weight From hc_grow Where userid = @userid order by indate desc



GO
