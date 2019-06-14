USE [HealthApp]
GO
/****** Object:  StoredProcedure [dbo].[hcm_test_questions_choices_Add]    Script Date: 2014/11/24 23:10:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE Procedure [dbo].[hcm_test_questions_choices_Add]
@questionid int,
@choice varchar(100),
@weight float,
@titile varchar(500),
@content varchar(500),
@result varchar(500)
as
Set nocount on 
DECLARE @orderno int
select @orderno=MAX(orderno)+1 from hc_test_questions_choices where questionid=@questionid
if(@orderno is  null)
begin
set @orderno=1
end

Insert into hc_test_questions_choices(questionid, choice, weight,titile,content,result,orderno)
  Values(@questionid, @choice, @weight,@titile,@content,@result,@orderno)

if Scope_Identity() > 0
  Select 1
else 
  Select 0
  


GO
