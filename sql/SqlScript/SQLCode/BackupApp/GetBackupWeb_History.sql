USE [BackupApp]
GO
/****** Object:  StoredProcedure [dbo].[GetBackupWeb_History]    Script Date: 2014/11/24 21:16:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      蔡杰
-- Create date: 2014-04-22  
-- Description: 获取备份记录
-- Memo:        GetBackupWeb_History 10, 1
*/   
Create Procedure [dbo].[GetBackupWeb_History]
@page int,
@size int
as

exec sp_MutiGridViewByPager      
@fromstring = ' BackupWeb_History ',      --数据集      
@selectstring =       
' KID, Oper, OperBgnTime, Case Result When 1 Then ''成功'' When -1 Then ''失败'' Else ''未执行'' End Result ',      --查询字段      
@returnstring =       
'KID, Oper, OperBgnTime, Result',      --返回字段      
@pageSize = @Size,                 --每页记录数      
@pageNo = @page,                     --当前页      
@orderString = ' ID Desc ',          --排序条件      
@IsRecordTotal = 1,             --是否输出总记录条数      
@IsRowNo = 0           --是否输出行号      




GO
