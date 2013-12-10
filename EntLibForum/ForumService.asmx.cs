using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Script.Services;
using System.IO;
using System.Text;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Web.Script.Serialization;
using System.Runtime.Serialization.Json;
using System.Web.SessionState;
using System.Diagnostics;
using System.Text.RegularExpressions;
using Trilink.BLL;
using Trilink.Model;

namespace yaf
{
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    // 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消对下行的注释。 
    [System.Web.Script.Services.ScriptService]

    public class ForumService : System.Web.Services.WebService, IRequiresSessionState
    {
        public ForumService()
        {

            //如果使用设计的组件，请取消注释以下行 
            //InitializeComponent(); 
        }

        public class test_1
        {
            public int a;
            public int b;
        };

        public class test_2
        {
            public int c;
            public int d;
        };

        public class test_3
        {
            public test_1 e;
            public test_2 f;
        };



        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }

        [WebMethod]
        public string GetForumList(string BoardID, string CategoryID)
        {
            CategoryAndForumManager categoryAndForumManager = new CategoryAndForumManager();

            return getJsonStr(categoryAndForumManager.GetCategoryAndForumByBoardID(BoardID, CategoryID)); 
        }

        public string getJsonStr(object obj)
        {
            DataContractJsonSerializer serializer = new DataContractJsonSerializer(obj.GetType());
            MemoryStream ms = new MemoryStream();
            serializer.WriteObject(ms, obj);
            string jsonString = Encoding.UTF8.GetString(ms.ToArray());
            ms.Close();
            return jsonString;
        }
    }
}
