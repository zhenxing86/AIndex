USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[saleinfo_Add]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*                  
-- Author:      xie              
-- Create date: 2014-05-17                 
-- Description:                   
-- Memo:                          
exec [saleinfo_Add] 12511,1,10,'',-3,'2013-1-2','2014-3-2'                  
*/                  
CREATE PROCEDURE [dbo].[saleinfo_Add]              
@userid int           
,@reuserid int           
,@kid int           
,@kname nvarchar(200)           
,@ytj_cnt int           
,@gun_cnt int           
,@pb_cnt int           
,@card_cnt int           
,@js_date datetime           
,@js_style int           
,@js_cnt int           
,@card_equ_cnt int  
,@js_cnt_kk int  
,@js_status int   
,@js_status_kk int  
,@price float  
,@totlemoney float  
,@term nvarchar(10)  
,@salefrom int  
,@remark nvarchar(500)                         
 AS                   
begin                 
   
 insert into saleinfo(userid,reuserid,kid,kname,ytj_cnt,gun_cnt,pb_cnt,  
 card_cnt,js_date,js_style,js_cnt,udate,card_equ_cnt,js_cnt_kk,js_status,  
 js_status_kk,price,totlemoney,term,salefrom,remark)          
  values(@userid,@reuserid,@kid,@kname,@ytj_cnt,@gun_cnt,@pb_cnt,  
  @card_cnt,@js_date,@js_style,@js_cnt,GETDATE(),@card_equ_cnt,@js_cnt_kk,  
  @js_status,@js_status_kk,@price,@totlemoney,@term,@salefrom,@remark)          
               
end 
GO
