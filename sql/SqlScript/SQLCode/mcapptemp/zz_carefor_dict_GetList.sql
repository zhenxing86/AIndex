USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[zz_carefor_dict_GetList]    Script Date: 2014/11/24 23:19:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Create PROCEDURE [dbo].[zz_carefor_dict_GetList]
 AS 

begin
	select zzid,describe from mcapp..zz_carefor_dict
end







GO
