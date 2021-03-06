USE [HealthApp]
GO
/****** Object:  StoredProcedure [dbo].[user_health_GetListTag]    Script Date: 2014/11/24 23:10:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--healthapp..user_health_GetListTag @cid  = 38436, @bgndate  = '2014-01-01', @enddate ='2014-08-01'
CREATE Procedure [dbo].[user_health_GetListTag]
@cid Int,
@bgndate date,
@enddate date,
@type int
as
Set Nocount On

Select b.growid, a.userid, a.name, a.sex, b.height, b.weight, b.sight, b.indate, a.cname, 
       Sum(Case When Isnull(b.growid, 0) <> 0 Then 1 Else 0 End) Over(Partition by a.userid) CountNo, 
       Row_number() Over(Partition by a.userid Order by b.indate Desc) OrderNo
  Into #Detail
  From Basicdata.dbo.user_child a Left Join HealthApp.[dbo].[hc_grow] b On a.userid = b.userid and b.byTeacher = @type and b.indate >= @bgndate and b.indate <= @enddate
  Where a.cid = @cid

Select * From #Detail Where OrderNo = 1

Select * From #Detail Where growid Is not NUll and OrderNo > 1

GO
