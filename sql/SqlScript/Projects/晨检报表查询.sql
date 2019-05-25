use mcapp
go

--ID 34640 星期一到星期三的晨检率，上传完之后显示是80%多，但是现在查看又变成70%多

--get_mc_content

 Select *
    from record_mc_kid_day rm  
    where rm.kid = 34640  
      and rm.cdate >= '2016-12-26'
      
--实际出勤395，缺勤99人，出勤率80.0%。
--实际晨检393人，未晨检101人，晨检率79.6%。