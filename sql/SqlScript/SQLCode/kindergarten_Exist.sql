
use ossapp
go

/* 
author :xie
addtime: 2014-05-17
def:根据幼儿园名称判断是否存在
demo：

*/
CREATE PROCEDURE [dbo].kindergarten_Exist    
 @kname nvarchar(200)
 AS     
    
  if exists (
   SELECT 1 from basicdata..kindergarten 
    where kname=@kname and deletetag=1
    )
    return 1
  else return -1