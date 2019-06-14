USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_mcdata_para_xg]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[rep_mcdata_para_xg]

--exec [mcapp].[dbo].[rep_mcdata_para_xg]

AS

update mcapp..tcf_setting 
set 
tx0A='3.45',tx0B='0.11',
t5A='3.45',t5B='0.11',
t10A='3.45',t10B='0.11',
t15A='3.45',t15B='0.11',
t20A='3.45',t20B='0.11',
t25A='5.7',t25B='0.2',
t30A='5.7',t30B='0.2',
t35A='5.7',t35B='0.2',
t40A='5.7',t40B='0.2',
t25x1='0.9',t25x2='0.6',
t25y1='34.5',t25y2='35.5'

where kid=19449

select * from mcapp..tcf_setting 
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'参数修改' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'rep_mcdata_para_xg'
GO
