USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[enlistonlineInfo_time_Setting]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		mh
-- Create date: 2009-06-06
-- Description:	Add
-- =============================================
CREATE PROCEDURE [dbo].[enlistonlineInfo_time_Setting]
@siteid int,
@bgntime datetime,
@endtime datetime
AS
BEGIN

	if(@bgntime>@endtime or @endtime<'1900-1-1' or @endtime is null)
	begin
		set @endtime=@bgntime
	end

	if(@bgntime>'1900-1-1')
	begin
	
		update dbo.site_config
			set bgntime=@bgntime,
				endtime=@endtime
			where siteid=@siteid
		
    end
    
    if(@bgntime='' or @endtime='')
    begin
    update dbo.site_config
			set bgntime=@bgntime,
				endtime=@endtime
			where siteid=@siteid
    end
    
    select 1
END


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'enlistonlineInfo_time_Setting', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
