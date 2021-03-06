USE [BasicData]
GO
/****** Object:  UserDefinedFunction [dbo].[ISOweek]    Script Date: 05/14/2013 14:36:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*函数用于计算时间对应的ISO周  
  ISO周：国际标准周编号，是不会因跨年度而中断的周数，  
  规定 年份Y的第一周是Y年1月4号所在的周（从星期一到星期天）,调用前需要将 DATEFIRST 设为 1    
  ex：  
DECLARE @DF AS INT;  
SET @DF = @@DATEFIRST;  
SET DATEFIRST 1;  
select dbo.ISOweek(getdate())       
select dbo.ISOweek('20120101')       
select dbo.ISOweek('20121231')    
SET DATEFIRST @DF;    
                      
 *谭磊 2012年5月29日创建                                        
 */     
  
create FUNCTION [dbo].[ISOweek] (@DATE DATETIME)  
RETURNS int  
WITH EXECUTE AS CALLER  
AS  
BEGIN  
     DECLARE @ISOweek int,@year varchar(4)  
     SET @ISOweek= DATEPART(wk,@DATE)+1  
          -DATEPART(wk,CAST(DATEPART(yy,@DATE) as CHAR(4))+'0104')  
    set  @year = year(@DATE)  
--特殊情况: 1月1日-3日可能属于上一年度  
     IF (@ISOweek=0)   
       begin  
          SET @ISOweek=DATEPART(wk,CAST(DATEPART(yy,@DATE)-1   
               AS CHAR(4))+'12'+ CAST(24+DATEPART(DAY,@DATE) AS CHAR(2)))+1  
          -DATEPART(wk,CAST(DATEPART(yy,CAST(DATEPART(yy,@DATE)-1   
               AS CHAR(4))+'12'+ CAST(24+DATEPART(DAY,@DATE) AS CHAR(2))) as CHAR(4))+'0104')+1  
          set @year = year(@DATE)- 1  
       end  
--特殊情况: 12月29日-31日可能属于下一年度  
     IF ((DATEPART(mm,@DATE)=12) AND   
          ((DATEPART(dd,@DATE)-DATEPART(dw,@DATE))>= 28))  
       begin  
          SET @ISOweek=1  
          set @year = year(@DATE)+ 1  
       end  
    select @ISOweek = @year + case len(@ISOweek) when 1 then '0'+str(@ISOweek,1) when 2 then str(@ISOweek,2) end   
    RETURN(@ISOweek)  
END;
GO
