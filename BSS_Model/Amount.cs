using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Trilink.Model
{
    /// <summary>
    ///Amount 的摘要说明
    /// </summary>
    public class Amount
    {
        #region
        public Amount()
        {
            //
            //TODO: 在此处添加构造函数逻辑
            //
        }
        #endregion
        #region
        private int amount;
        #endregion
        #region
        public int Amounts
        {
            get { return amount; }
            set { amount = value; }
        }
        #endregion
    }
}