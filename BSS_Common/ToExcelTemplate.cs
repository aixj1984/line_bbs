using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
using System.Text;
/// <summary>
///ExportExcel 的摘要说明
/*      DataSet dsBook = db.GetCheckingInDataSet(searchvalue,searchtype,year1,year2,searchState);//get date set
        ExportExcel to_excel = new ExportExcel();
        to_excel.AddColumnInfo("考勤日期", 80);
        to_excel.AddColumnInfo("部门名称", 160);
        to_excel.AddColumnInfo("姓名", 80);
        to_excel.AddColumnInfo("工号", 80);
        to_excel.AddColumnInfo("上班时间", 160);
        to_excel.AddColumnInfo("下班时间", 160);
        to_excel.AddColumnInfo("考勤状态", 80);
        to_excel.Table_name = "考勤统计";
        to_excel.Table_title = "武汉市市民之家考勤记录表";

        string ExcelFileName = System.AppDomain.CurrentDomain.BaseDirectory + "\\ExcelFile\\" + FileName + ".xls";

        if (to_excel.ToExcelTemplate(ExcelFileName, dsBook) != 0)
        {
            return;
        }
*/ 
/// </summary>
namespace Trilink.Common
{
    public class ExportExcel
    {

        public ExportExcel()
        {
            table_name = "temp";
            table_title = "统计";
            column_title_list = new List<string>();
            column_width_list = new List<float>();
            col_num = 0;
            row_num = 0;

        }

        #region ToExcelTemplate
        public int ToExcelTemplate(string ExcelFileName, DataSet ds_result)
        {

            if (ds_result == null || ds_result.Tables[0].Rows.Count < 1)
            {
                //error date result is null or no record
                return -1;
            }

            if (ds_result.Tables[0].Columns.Count != column_title_list.Count || column_title_list.Count != column_width_list.Count)
            {
                //the size of columns tile list is not equal the size of columns width list
                return -2;
            }

            row_num = ds_result.Tables[0].Rows.Count + 2;
            col_num = ds_result.Tables[0].Columns.Count;

            //将要生成的Excel文件 

            StreamWriter writer = OpenFile(ExcelFileName);

            if (writer == null)
            {
                //open file error
                return -3;
            }

            if (WriteExcelHead(writer) != 0)
            {
                //write head error
                return -4;
            }
            if (WriteExcelBody(writer, ds_result) != 0)
            {
                //write body error
                return -5;
            }

            if (WriteExcelTail(writer) != 0)
            {
                //write Tail error
                return -6;
            }

            writer.Close();


            return 0;

        }
        #endregion




        #region add_param
        // colunm name and colunm width  列的标题名称，列的宽度，这里一般两个中文汉字的宽度为50，10个中文字符为50
        public void AddColumnInfo(string colunm_title, float colunm_width)
        {
            column_title_list.Add(colunm_title);
            column_width_list.Add(colunm_width);
        }
        #endregion

        #region OpenFile
        private StreamWriter OpenFile(string ExcelFileName)
        {
            if (File.Exists(ExcelFileName))
            {
                try
                {
                    File.Delete(ExcelFileName);
                }
                catch (Exception)
                {
                    //delete file failed
                    return null;
                }
            }
            StreamWriter writer = new StreamWriter(ExcelFileName, false);

            return writer;
        }
        #endregion

        #region WriteExcelHead
        private int WriteExcelHead(StreamWriter writer)
        {
            if (writer == null)
            {
                //write hander is null.
                return -1;
            }
            writer.WriteLine(@"<?xml version=""1.0""?>");
            writer.WriteLine(@"<?mso-application progid=""Excel.Sheet""?>");
            writer.WriteLine(@"<Workbook xmlns=""urn:schemas-microsoft-com:office:spreadsheet""");
            writer.WriteLine(@" xmlns:o=""urn:schemas-microsoft-com:office:office""");
            writer.WriteLine(@" xmlns:x=""urn:schemas-microsoft-com:office:excel""");
            writer.WriteLine(@" xmlns:ss=""urn:schemas-microsoft-com:office:spreadsheet""");
            writer.WriteLine(@" xmlns:html=""http://www.w3.org/TR/REC-html40""");
            writer.WriteLine(@" xmlns:u1=""http://www.w3.org/TR/REC-html40/"">");
            writer.WriteLine(@" <DocumentProperties xmlns=""urn:schemas-microsoft-com:office:office"">");
            writer.WriteLine(@"  <Author>Automated Report Generator Example</Author>");
            writer.WriteLine(@"  <LastAuthor>微软用户</LastAuthor>");
            writer.WriteLine(string.Format("  <Created>{0}T{1}Z</Created>", DateTime.Now.ToString("yyyy-mm-dd"), DateTime.Now.ToString("HH:MM:SS")));
            //writer.WriteLine(@"  <Created>2012-10-13T01:32:27Z</Created>");   //default time
            writer.WriteLine(@"  <LastSaved>2012-10-11T07:01:01Z</LastSaved>");
            writer.WriteLine(@"  <Company>minyou</Company>");
            writer.WriteLine(@"  <Version>12.00</Version>");
            writer.WriteLine(@" </DocumentProperties>");
            writer.WriteLine(@" <ExcelWorkbook xmlns=""urn:schemas-microsoft-com:office:excel"">");
            writer.WriteLine(@"  <WindowHeight>8955</WindowHeight>");
            writer.WriteLine(@"  <WindowWidth>11355</WindowWidth>");
            writer.WriteLine(@"  <WindowTopX>480</WindowTopX>");
            writer.WriteLine(@"  <WindowTopY>15</WindowTopY>");
            writer.WriteLine(@"  <ProtectStructure>False</ProtectStructure>");
            writer.WriteLine(@"  <ProtectWindows>False</ProtectWindows>");
            writer.WriteLine(@" </ExcelWorkbook>");
            writer.WriteLine(@" <Styles>");
            writer.WriteLine(@"  <Style ss:ID=""Default"" ss:Name=""Normal"">");
            writer.WriteLine(@"   <Alignment ss:Vertical=""Bottom""/>");
            writer.WriteLine(@"   <Borders/>");
            writer.WriteLine(@"   <Font ss:FontName=""Arial"" x:Family=""Swiss""/>");
            writer.WriteLine(@"   <Interior/>");
            writer.WriteLine(@"   <Protection/>");
            writer.WriteLine(@"  </Style>");
            writer.WriteLine(@"  <Style ss:ID=""s62"">");
            writer.WriteLine(@"   <Alignment ss:Horizontal=""Left"" ss:Vertical=""Bottom""/>");
            writer.WriteLine(@"  </Style>");
            writer.WriteLine(@"  <Style ss:ID=""s65"">");
            writer.WriteLine(@"   <Alignment ss:Horizontal=""Center"" ss:Vertical=""Center""/>");
            writer.WriteLine(@"   <Borders>");
            writer.WriteLine(@"    <Border ss:Position=""Bottom"" ss:LineStyle=""Continuous"" ss:Weight=""1""/>");
            writer.WriteLine(@"    <Border ss:Position=""Left"" ss:LineStyle=""Continuous"" ss:Weight=""1""/>");
            writer.WriteLine(@"    <Border ss:Position=""Top"" ss:LineStyle=""Continuous"" ss:Weight=""1""/>");
            writer.WriteLine(@"   </Borders>");
            writer.WriteLine(@"   <Font ss:FontName=""宋体"" x:CharSet=""134"" ss:Size=""18""/>");
            writer.WriteLine(@"   <Interior ss:Color=""#8DB4E3"" ss:Pattern=""Solid""/>");
            writer.WriteLine(@"   <NumberFormat ss:Format=""@""/>");
            writer.WriteLine(@"  </Style>");
            writer.WriteLine(@"  <Style ss:ID=""s69"">");
            writer.WriteLine(@"   <Alignment ss:Horizontal=""Left"" ss:Vertical=""Center"" ss:WrapText=""1""/>");
            writer.WriteLine(@"   <Borders>");
            writer.WriteLine(@"    <Border ss:Position=""Bottom"" ss:LineStyle=""Continuous"" ss:Weight=""1""/>");
            writer.WriteLine(@"    <Border ss:Position=""Left"" ss:LineStyle=""Continuous"" ss:Weight=""1""/>");
            writer.WriteLine(@"    <Border ss:Position=""Right"" ss:LineStyle=""Continuous"" ss:Weight=""1""/>");
            writer.WriteLine(@"   </Borders>");
            writer.WriteLine(@"   <Font ss:FontName=""宋体"" x:CharSet=""134"" ss:Size=""14""/>");
            writer.WriteLine(@"   <Interior ss:Color=""#FAC090"" ss:Pattern=""Solid""/>");
            writer.WriteLine(@"   <NumberFormat ss:Format=""@""/>");
            writer.WriteLine(@"  </Style>");
            writer.WriteLine(@"  <Style ss:ID=""s70"">");
            writer.WriteLine(@"   <Alignment ss:Horizontal=""Left"" ss:Vertical=""Center"" ss:WrapText=""1""/>");
            writer.WriteLine(@"   <Borders>");
            writer.WriteLine(@"    <Border ss:Position=""Bottom"" ss:LineStyle=""Continuous"" ss:Weight=""1""/>");
            writer.WriteLine(@"    <Border ss:Position=""Left"" ss:LineStyle=""Continuous"" ss:Weight=""1""/>");
            writer.WriteLine(@"    <Border ss:Position=""Right"" ss:LineStyle=""Continuous"" ss:Weight=""1""/>");
            writer.WriteLine(@"    <Border ss:Position=""Top"" ss:LineStyle=""Continuous"" ss:Weight=""1""/>");
            writer.WriteLine(@"   </Borders>");
            writer.WriteLine(@"   <Font ss:FontName=""Arial"" x:Family=""Swiss"" ss:Size=""14""/>");
            writer.WriteLine(@"   <NumberFormat ss:Format=""@""/>");
            writer.WriteLine(@"  </Style>");
            writer.WriteLine(@" </Styles>");
            writer.WriteLine(@" <Worksheet ss:Name=""" + table_name + @""">");
            writer.WriteLine(@"  <Names>");
            writer.WriteLine(@"   <NamedRange ss:Name=""_FilterDatabase"" ss:RefersTo=""=" + table_name + @"!R2C1:R12C" + col_num + @"""");
            writer.WriteLine(@"    ss:Hidden=""1""/>");
            writer.WriteLine(@"  </Names>");

            return 0;
        }
        #endregion


        #region WriteExcelBody
        private int WriteExcelBody(StreamWriter writer, DataSet ds_result)
        {
            if (writer == null)
            {
                //write hander is null.
                return -1;
            }

            writer.WriteLine(string.Format(@"  <Table ss:ExpandedColumnCount=""{0}"" ss:ExpandedRowCount=""{1}"" x:FullColumns=""1"" ", col_num, row_num));
            //writer.WriteLine(@"  <Table ss:ExpandedColumnCount=""6"" ss:ExpandedRowCount=""3"" x:FullColumns=""1""");//test data
            writer.WriteLine(@"   x:FullRows=""1"">");
            foreach (float one_column_width in column_width_list)
            {
                writer.WriteLine(@"   <Column ss:StyleID=""s62"" ss:AutoFitWidth=""0"" ss:Width=""" + one_column_width + @"""/>");
            }
            writer.WriteLine(@"   <Row ss:AutoFitHeight=""0"" ss:Height=""30"">");
            writer.WriteLine(@"    <Cell ss:MergeAcross=""" + (col_num - 1) + @""" ss:StyleID=""s65""><Data ss:Type=""String"">" + table_title + @"</Data></Cell>");
            writer.WriteLine(@"   </Row>");
            writer.WriteLine(@"   <Row ss:AutoFitHeight=""0"" ss:Height=""18.75"">");
            foreach (string column_tile in column_title_list)
            {
                writer.WriteLine(@"    <Cell ss:StyleID=""s69""><Data ss:Type=""String"">" + column_tile + @"</Data><NamedCell");
                writer.WriteLine(@"      ss:Name=""_FilterDatabase""/></Cell>");
            }
            writer.WriteLine(@"   </Row>");

            foreach (DataRow eachRow in ds_result.Tables[0].Rows)
            {
                writer.WriteLine(@"   <Row ss:AutoFitHeight=""0"" ss:Height=""18"">");
                for (int currentRow = 0; currentRow < col_num; currentRow++)
                {
                    writer.WriteLine(@"<Cell ss:StyleID=""s70""><Data ss:Type=""String"">" + eachRow[currentRow].ToString() + @"</Data></Cell>");
                }
                writer.WriteLine(@"</Row>");
            }
            writer.WriteLine(@"  </Table>");
            return 0;
        }
        #endregion


        #region WriteExcelTail
        private int WriteExcelTail(StreamWriter writer)
        {
            if (writer == null)
            {
                //write hander is null.
                return -1;
            }
            writer.WriteLine(@"  <WorksheetOptions xmlns=""urn:schemas-microsoft-com:office:excel"">");
            writer.WriteLine(@"   <Print>");
            writer.WriteLine(@"    <ValidPrinterInfo/>");
            writer.WriteLine(@"    <VerticalResolution>0</VerticalResolution>");
            writer.WriteLine(@"    <NumberofCopies>0</NumberofCopies>");
            writer.WriteLine(@"   </Print>");
            writer.WriteLine(@"   <Selected/>");
            writer.WriteLine(@"   <ProtectObjects>False</ProtectObjects>");
            writer.WriteLine(@"   <ProtectScenarios>False</ProtectScenarios>");
            writer.WriteLine(@"  </WorksheetOptions>");
            writer.WriteLine(@"  <AutoFilter x:Range=""R2C1:R12C" + col_num + @"""");
            writer.WriteLine(@"   xmlns=""urn:schemas-microsoft-com:office:excel"">");
            writer.WriteLine(@"  </AutoFilter>");
            writer.WriteLine(@" </Worksheet>");
            writer.WriteLine(@"</Workbook>");
            return 0;
        }
        #endregion



        #region Attributes
        private string table_name;
        private string table_title;
        private List<string> column_title_list;
        private List<float> column_width_list;
        private int col_num;
        private int row_num;
        #endregion

        #region get_Attributes

        public string Table_name
        {
            get { return table_name; }
            set { table_name = value; }
        }
        public string Table_title
        {
            get { return table_title; }
            set { table_title = value; }
        }
        public List<string> Column_title_list
        {
            get { return column_title_list; }
            set { column_title_list = value; }
        }
        public List<float> Column_width_list
        {
            get { return column_width_list; }
            set { column_width_list = value; }
        }
        public int Col_num
        {
            get { return col_num; }
            set { col_num = value; }
        }
        public int Row_num
        {
            get { return row_num; }
            set { row_num = value; }
        }

        #endregion

    }
}