USE [mcapp]
GO
/****** Object:  UserDefinedFunction [dbo].[CheckResult_Fun]    Script Date: 05/14/2013 14:54:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION  [dbo].[CheckResult_Fun]
(
	@uid int,
	@ctime datetime
)
RETURNS nvarchar(300)
AS
BEGIN
	--喉咙发炎，流鼻涕，咳嗽，腹泻，红眼病，手足口病，皮疹，剪指甲
	DECLARE @str nvarchar(300)
	set @str=''
	select @str=(case when lbt=1 then '、流鼻涕' else '' end) 
	+(case when hlfy=1 then '、喉咙发炎' else '' end) 
	+(case when ks=1 then '、咳嗽' else '' end) 
	+(case when fs=1 then '、发烧' else '' end) 
	+(case when hy=1 then '、红眼病' else '' end) 
	+(case when szk=1 then '、手足口病' else '' end) 
	+(case when fx=1 then '、腹泻' else '' end) 
	+(case when qc=1 then '、龋齿' else '' end) 
	from stu_mc_day  where stuid=@uid and cdate=@ctime
	if(LEN(@str)=0)
	begin
	set @str='正常'
	end
	else
	begin
	set @str=SUBSTRING(@str,2,len(@str))
	end

	RETURN @str

END
GO
