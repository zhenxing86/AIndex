--通过 Select 查询  过滤trc文件，
--显示a.CPU,a.Reads,a.Writes,a.Duration,a.TextData等文件内容，代码如下：

--博客、基础数据\班级主页，数据量较大，访问量较大
SELECT top 100 a.CPU,a.Reads,a.Writes,a.Duration,a.TextData,* 
from  fn_trace_gettable('d:\test\20120504.trc', default) a
where TextData is not NULL--order by a.Reads desc
--order by a.CPU desc
--order by a.Writes desc
order by a.Duration desc ('d:\test\20120504.trc':跟踪文件的全路径)
--查询结果如下：



SELECT top 100 a.CPU,a.Reads,a.Writes,a.Duration,a.TextData,* 
from  fn_trace_gettable('E:\zgyey20130415.trc', default) a
where TextData is not NULL
--order by a.Reads desc
--order by a.CPU desc
--order by a.Writes desc
order by a.Duration desc 