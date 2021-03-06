USE [CardApp]
GO
/****** Object:  StoredProcedure [dbo].[attendance_everymonth_wriprepeat]    Script Date: 2014/11/24 22:56:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-07-02
-- Description:	attendance_everymonth 表去重复
-- Memo:		
*/
CREATE PROC [dbo].[attendance_everymonth_wriprepeat]
	@kid int,
	@year int
AS
BEGIN
	SET NOCOUNT ON	
	 
	UPDATE attendance_everymonth 
		SET day_1=DBO.AdjustFn_20130409(day_1), 
		day_2=DBO.AdjustFn_20130409(day_2), 
		day_3=DBO.AdjustFn_20130409(day_3), 
		day_4=DBO.AdjustFn_20130409(day_4), 
		day_5=DBO.AdjustFn_20130409(day_5), 
		day_6=DBO.AdjustFn_20130409(day_6), 
		day_7=DBO.AdjustFn_20130409(day_7), 
		day_8=DBO.AdjustFn_20130409(day_8), 
		day_9=DBO.AdjustFn_20130409(day_9), 
		day_10=DBO.AdjustFn_20130409(day_10), 
		day_11=DBO.AdjustFn_20130409(day_11), 
		day_12=DBO.AdjustFn_20130409(day_12), 
		day_13=DBO.AdjustFn_20130409(day_13), 
		day_14=DBO.AdjustFn_20130409(day_14), 
		day_15=DBO.AdjustFn_20130409(day_15), 
		day_16=DBO.AdjustFn_20130409(day_16), 
		day_17=DBO.AdjustFn_20130409(day_17), 
		day_18=DBO.AdjustFn_20130409(day_18), 
		day_19=DBO.AdjustFn_20130409(day_19), 
		day_20=DBO.AdjustFn_20130409(day_20), 
		day_21=DBO.AdjustFn_20130409(day_21), 
		day_22=DBO.AdjustFn_20130409(day_22), 
		day_23=DBO.AdjustFn_20130409(day_23), 
		day_24=DBO.AdjustFn_20130409(day_24), 
		day_25=DBO.AdjustFn_20130409(day_25), 
		day_26=DBO.AdjustFn_20130409(day_26), 
		day_27=DBO.AdjustFn_20130409(day_27), 
		day_28=DBO.AdjustFn_20130409(day_28), 
		day_29=DBO.AdjustFn_20130409(day_29), 
		day_30=DBO.AdjustFn_20130409(day_30), 
		day_31=DBO.AdjustFn_20130409(day_31)
		from attendance_everymonth 
		where kid = @kid 
			and year = @year
			
END

GO
