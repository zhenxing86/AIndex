USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[zz_dict_GetList]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[zz_dict_GetList]

as

select ID,title from zz_dict





GO
