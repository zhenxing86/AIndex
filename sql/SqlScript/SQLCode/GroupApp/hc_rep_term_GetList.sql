USE [HealthApp]
GO
/****** Object:  StoredProcedure [dbo].[hc_rep_term_GetList]    Script Date: 2014/11/24 23:10:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================  
-- Author:  <Author,,Name>  
-- Create date: <Create Date,,>  
-- Description: <Description,,>  
-- =============================================  
CREATE PROCEDURE [dbo].[hc_rep_term_GetList]  
 @userid int,  
 @term varchar(100)  
AS  
BEGIN  
   
 SET NOCOUNT ON;  
 select '刘少楠','男','2岁8个月','小一班','上学期','82.3','孩子学期的身体情况综合报告，每个宝宝都是独一无二的，健康测评根据测评结果，提供一系列的养育建议和亲子游戏，关键是这些都是个性化的，并且易于操作。'  
 ,'2岁-3岁身高：88.1—93.3厘米','2岁-3岁体重：10.6—19.2公斤'  
   
 select DATEADD(MM,n,CONVERT(datetime,'2014-3-1'))  
 , CAST(RAND()*N+121 as float(1))   
 ,125+n/3,100+n/3  
 from  CommonFun.dbo.Nums1Q where n<7   
   
 select DATEADD(MM,n,CONVERT(datetime,'2014-3-1'))  
   
 , CAST(RAND()*N+33 as float(1)),35+n/3 ,30+n/3  
 from  CommonFun.dbo.Nums1Q where n<7   
   
 select '生活信息','日常水果','适时调整儿童水果种类','建议：当地当季的水果最好。建议少吃热带水果，有的人比较容易过敏。例如芒果，菠萝，李子。','生活信息测评结果：整体把握儿童的日常饮食情况、生活习惯，以便帮助儿童纠正不良生活习惯、饮食习惯，促进健康。'  
 union all  
 select '健康信息','听发育指标','异常','建议：尽快带孩子到医院做进一步检查；','健康信息测评结果：这个阶段家长要锻炼宝宝的观察能力，培养宝宝的听分辨能力，特别注意宝宝的眼睛的保养，注意宝宝是否有斜视。'  
END  
  

GO
