USE [CommonFun]
GO
/****** Object:  StoredProcedure [dbo].[Calkidterm]    Script Date: 2014/11/24 22:58:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-05-21
-- Description:
-- Paradef: 
-- Memo:
	declare 	@bgn datetime,	@end datetime 
	exec Calkidterm 1, '2013-0', @bgn output,	@end output 	
	select @bgn, @end	
*/ 
CREATE PROCEDURE [dbo].[Calkidterm]
	@kid int,
	@term varchar(10),
	@bgn datetime output,
	@end datetime output
AS
BEGIN
	SET NOCOUNT ON
	select @bgn = kt.bgndate, @end = kt.enddate 
		from  BasicData.dbo.kid_term kt 
		where kt.kid = @kid 
			and kt.term = @term
	if @@ROWCOUNT = 0
	BEGIN
		IF RIGHT(@term,1) = '1'
		SELECT	@bgn = LEFT(@term,4)+'-09-01', 
						@end = sdate
			from BasicData.dbo.Springday 
			where CONVERT(varchar(4),sdate,120)  = LEFT(@term,4) + 1
		ELSE 
		SELECT	@bgn = sdate, 
						@end = LEFT(@term,4)+'-09-01'
			from BasicData.dbo.Springday 
			where CONVERT(varchar(4),sdate,120)  = LEFT(@term,4)
	
	END

END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'根据kid获取某学期的开始结束时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Calkidterm'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Calkidterm', @level2type=N'PARAMETER',@level2name=N'@kid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'学期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Calkidterm', @level2type=N'PARAMETER',@level2name=N'@term'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'开始时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Calkidterm', @level2type=N'PARAMETER',@level2name=N'@bgn'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'结束时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Calkidterm', @level2type=N'PARAMETER',@level2name=N'@end'
GO
