--sqlserver 调用C# dll库的方法

------------------------语法--------------------------------------
-- Create assembly 
CREATE ASSEMBLY CLRUtilities
FROM 'C:\CLRUtilities\CLRUtilities\bin\Debug\CLRUtilities.dll'
WITH PERMISSION_SET = SAFE;
-- If no Debug folder, use instead:
-- FROM 'C:\CLRUtilities\CLRUtilities\bin\CLRUtilities.dll'
GO

---------------------------------------------------------------------
-- Scalar Function: fn_RegExMatch
---------------------------------------------------------------------

-- Create fn_RegExMatch function
CREATE FUNCTION dbo.fn_RegExMatch
  (@inpstr AS NVARCHAR(MAX), @regexstr AS NVARCHAR(MAX)) 
RETURNS BIT
EXTERNAL NAME CLRUtilities.CLRUtilities.fn_RegExMatch;
GO

sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO
sp_configure 'clr enabled', 1;
GO
RECONFIGURE;
GO
----------------------------------------------------------------------------------

--实例:   D:\Program Files x86\mcpcapp2\com.zgyey.cardapp\com.zgyey.sqlcommon\bin\Debug\com.zgyey.sqlcommon.dll


-- Create assembly 
CREATE ASSEMBLY zgyey
FROM 'D:\Program Files x86\mcpcapp2\com.zgyey.cardapp\com.zgyey.sqlcommon\bin\Debug\com.zgyey.sqlcommon.dll'
WITH PERMISSION_SET = SAFE;
-- If no Debug folder, use instead:
-- FROM 'C:\CLRUtilities\CLRUtilities\bin\CLRUtilities.dll'
GO

---------------------------------------------------------------------
-- Scalar Function: fn_RegExMatch
---------------------------------------------------------------------

-- Create fn_RegExMatch function
CREATE FUNCTION dbo.fundd
  (@from AS NVARCHAR(100), @to AS NVARCHAR(100)) 
RETURNS NVARCHAR(100)
EXTERNAL NAME zgyey.[com.zgyey.sqlcommon.app1].funxx;
GO

sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO
sp_configure 'clr enabled', 1;
GO
RECONFIGURE;
GO


select dbo.fundd ('1,3,2,','发烧,感冒,喉咙发炎,sd,33')



--C#代码  (该代码没有异常处理，这是很不好的，会导致sqlserver异常崩溃)
--namespace com.zgyey.sqlcommon
--{
--    public class app1
--    {
--        /// <summary>
--        /// fun("1,3,2,","发烧,感冒,喉咙发炎")
--        /// </summary>
--        /// <param name="zz"></param>
--        /// <param name="str"></param>
--        /// <returns></returns>
--        public static string funxx(string zz, string incn)
--        {
--            string str = "";
--            string[] sp1 = zz.Split(new string[] { "," }, StringSplitOptions.None);
--            string[] sp2 = incn.Split(new string[] { "," }, StringSplitOptions.None);
--            foreach (string s in sp1)
--            {
--                if (s != "")
--                {
--                    str += "、" + sp2[int.Parse(s)-1];
--                }
--            }
--            str = str.Length == 0 ? "" : str.Substring(1);
--            return str;
--        }
--    }
--}