USE [HealthApp]
GO
/****** Object:  StoredProcedure [dbo].[user_health_Add]    Script Date: 2014/11/24 23:10:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE Procedure [dbo].[user_health_Add]
@userid Int,
@indate Date,
@height Numeric(9, 2),
@weight Numeric(9, 2),
@sight Numeric(9, 2),
@oper Varchar(50)
as

;With Data as (
Select @userid userid, @indate Indate, @height height, @weight weight, @sight sight
)
Merge HealthApp.[dbo].[hc_grow] a
Using Data b On a.userid = b.userid and a.Indate = b.Indate
When Matched Then
Update Set height = b.height, weight = b.weight, sight = b.sight, byTeacher = 1
When not Matched Then
Insert (userid, indate, height, weight, sight, byTeacher) Values(b.userid, b.indate, b.height, b.weight, b.sight, 1);



GO
