USE [HealthApp]
GO
/****** Object:  StoredProcedure [dbo].[hcm_test_questions_Add]    Script Date: 2014/11/24 23:10:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE Procedure [dbo].[hcm_test_questions_Add]
@testid int,
@moduleid int,
@orderno int, 
@title varchar(100),
@frequency varchar(500),
@instruction varchar(max), 
@regulation varchar(max),
@choosetype varchar(10),
@weight float
as
Set nocount on 

select @orderno=MAX(orderno)+1 from hc_test_questions where testid=@testid
if(@orderno is null)
begin
	set @orderno=1
end
Insert Into hc_test_questions (testid, moduleid, orderno, title, frequency, instruction, regulation, choosetype, weight)
  Values(@testid, @moduleid, @orderno, @title, @frequency, @instruction, @regulation, @choosetype, @weight)

if Scope_Identity() > 0
  select @@IDENTITY
else 
  select 0


GO
