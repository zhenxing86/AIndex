USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_mcdata_gundetail]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  于璋  
-- Create date: 2014-04-4  
-- Description: 根据序列号查询晨检枪归属  
--[mcapp]..[rep_mcdata_gundetail] '','12511'
-- =============================================  
CREATE PROCEDURE [dbo].[rep_mcdata_gundetail]  
@serialno varchar(20),
@kid int
  
AS  
BEGIN  
 SET NOCOUNT ON;  
 declare @fromstring NVARCHAR(2000)    
     
set @fromstring = 'select t.serialno as 序列号,  
                         t.kid as KID,  
                         k.kname as 幼儿园,  
                         t.gunnum as 枪编号  
                    from mcapp..tcf_setting t  
                    inner join basicdata..kindergarten k  
                      on t.kid = k.kid  
                    where 1=1'  
   IF @serialno <> '' SET @fromstring = @fromstring + 'and t.serialno = @serialno'    
   IF @kid <> '' SET @fromstring = @fromstring + 'and t.kid = @kid'   
   SET @fromstring = @fromstring + ' order by t.serialno desc,kid'                 
                     
EXEC SP_EXECUTESQL @fromstring,     
      N' @serialno varchar(20) = NULL,@kid int = NULL',     
      @serialno = @serialno,@kid = @kid
   
END  
  
GO
