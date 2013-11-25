using System;
using System.Data;
using System.Text;
using System.Text.RegularExpressions;
using System.Collections;
using System.Web;
using System.Web.UI;
using System.IO;


namespace yaf
{
	/// <summary>
	/// Summary description for Util.
	/// </summary>
    public class UtilityValidation
	{
		public UtilityValidation()
		{
		}

		// Function to test for Positive Integers.  
		public static bool IsNaturalNumber(String strNumber)
		{
			Regex objNotNaturalPattern=new Regex("[^0-9]");
			Regex objNaturalPattern=new Regex("0*[1-9][0-9]*");
			return  !objNotNaturalPattern.IsMatch(strNumber) &&
				objNaturalPattern.IsMatch(strNumber);
		}  

		// Function to test for Positive Integers with zero inclusive  

		public static bool IsWholeNumber(String strNumber)
		{
			Regex objNotWholePattern=new Regex("[^0-9]");
			return !objNotWholePattern.IsMatch(strNumber);
		}  

		// Function to Test for Integers both Positive & Negative  

		public static bool IsInteger(String strNumber)
		{
			Regex objNotIntPattern=new Regex("[^0-9-]");
			Regex objIntPattern=new Regex("^-[0-9]+$|^[0-9]+$");
			return  !objNotIntPattern.IsMatch(strNumber) &&  objIntPattern.IsMatch(strNumber);
		} 

		// Function to Test for Positive Number both Integer & Real 

		public static bool IsPositiveNumber(String strNumber)
		{
			Regex objNotPositivePattern=new Regex("[^0-9.]");
			Regex objPositivePattern=new Regex("^[.][0-9]+$|[0-9]*[.]*[0-9]+$");
			Regex objTwoDotPattern=new Regex("[0-9]*[.][0-9]*[.][0-9]*");
			return !objNotPositivePattern.IsMatch(strNumber) &&
				objPositivePattern.IsMatch(strNumber)  &&
				!objTwoDotPattern.IsMatch(strNumber);
		}  

		// Function to test whether the string is valid number or not
		public static bool IsNumber(String strNumber)
		{
			Regex objNotNumberPattern=new Regex("[^0-9.-]");
			Regex objTwoDotPattern=new Regex("[0-9]*[.][0-9]*[.][0-9]*");
			Regex objTwoMinusPattern=new Regex("[0-9]*[-][0-9]*[-][0-9]*");
			String strValidRealPattern="^([-]|[.]|[-.]|[0-9])[0-9]*[.]*[0-9]+$";
			String strValidIntegerPattern="^([-]|[0-9])[0-9]*$";
			Regex objNumberPattern =new Regex("(" + strValidRealPattern +")|(" + strValidIntegerPattern + ")");
			return !objNotNumberPattern.IsMatch(strNumber) &&
				!objTwoDotPattern.IsMatch(strNumber) &&
				!objTwoMinusPattern.IsMatch(strNumber) &&
				objNumberPattern.IsMatch(strNumber);
		}  

		// Function To test for Alphabets. 
		public static bool IsAlpha(String strToCheck)
		{
			Regex objAlphaPattern=new Regex("[^a-zA-Z]");
			return !objAlphaPattern.IsMatch(strToCheck);
		}
		// Function to Check for AlphaNumeric.
		public static bool IsAlphaNumeric(String strToCheck)
		{
			Regex objAlphaNumericPattern=new Regex("[^a-zA-Z0-9]");
			return !objAlphaNumericPattern.IsMatch(strToCheck);    
		}
		public static bool IsEmailAddress(string strEmailAddress)
		{
			Regex objNotEmailAddress = new Regex(@"\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*");
			return objNotEmailAddress.IsMatch(strEmailAddress);
		}
		// Function Format Money 
		public static decimal ToMoney(string moneyStr)
		{
			return decimal.Round(decimal.Parse(moneyStr),2);
		}
		public static decimal ToMoney(decimal moneyValue)
		{
			return decimal.Round(moneyValue,2);
		}
		/// <summary>
		/// 舍去金额的分,直接舍去,非四舍五入
		/// </summary>
		/// <param name="moneyValue"></param>
		/// <returns></returns>
		public static decimal TruncMoney(decimal moneyValue)
		{
			int tempAmt = Convert.ToInt32(moneyValue*100)%10;
			moneyValue = (decimal)((moneyValue*100 - tempAmt)/100m);
			return moneyValue;
		}
		/// <summary>
		/// 判断是否手机号码
		/// </summary>
		/// <param name="cell"></param>
		/// <returns></returns>
		public static bool IsCellNumber(string cell)
		{
			//验证长度
			if ( cell.Length != 11)
			{
				return false;
			}

			
			try
			{
				//验证为数字，防止全角字符
				Convert.ToInt64(cell);

				//验证特征码
				string cellSpec1 = cell.Substring(0,1);
				// string cellSpec2 = cell.Substring(0,3);
				if ( cellSpec1 != "1")
					return false;

                //if (number < 13000000000)
                //    return false;
                //else if (number >= 14000000000)
                //    return false;
			}
			catch
			{
				return false;
			}
			return true;
		}


		/// <summary>
		/// 判断是否为合法的数字
		/// </summary>
		/// <param name="value"></param>
		/// <returns></returns>
		public static bool IsValidNumber(string value)
		{			
			return Regex.IsMatch(value, @"^\d*$");
		}


		public static string RemoveHtmlTag(string str)
		{
            // Version 1.0
			//Regex regex  = new Regex(@"<([\s-\S][^>]*)?>");
			//Regex regex2 = new Regex(@"(\w(\.|,|\/))");

			//return regex2.Replace(regex.Replace(str,""),"");

            // Added by Rickie, Sept. 26, 2007
            str = str.Replace("'", "&rsquo;").Replace("\"","&quot;");
            // =====  End ====================

            // Version 2.0
            Regex reg = new Regex(@"<\/*[^<>]*>");
            return reg.Replace(str, "");
        }
	}
}
