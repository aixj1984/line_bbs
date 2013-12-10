using System.Net.Mail;
using System.Net;
using System.Text;

namespace Trilink.Common
{
    /// <summary> 
    /// 邮件发送类
    /// </summary> 
    public class SendMail
    {
        /// <summary> 
        /// 发送邮件 
        /// </summary> 
        /// <param name="fromaddress">邮件发送地址</param>
        /// <param name="fromname">邮件发送者名称</param>
        /// <param name="toaddress">邮件接收地址</param>
        /// <param name="toname">邮件接收者名称</param>
        /// <param name="subject">邮件主题</param>
        /// <param name="isbodyhtml">邮件正文是否Html</param>
        /// <param name="body">邮件正文</param>
        /// <param name="bodyencoding">邮件正文编码格式</param>
        /// <param name="smtphost">邮件发送服务器地址(SMTP)</param>
        /// <param name="username">邮件服务登陆账号</param>
        /// <param name="password">邮件服务登陆密码</param>
        public static void Send(string fromaddress, string fromname, string toaddress, string toname, string subject, bool isbodyhtml, string body
                , Encoding bodyencoding, string smtphost, string username, string password)
        {
            MailAddress mailfrom = new MailAddress(fromaddress, fromname);
            MailAddress mailto = new MailAddress(toaddress, toname);
            MailMessage message = new MailMessage(mailfrom, mailto);
            message.Subject = subject;
            message.IsBodyHtml = isbodyhtml;
            message.Body = body;
            message.BodyEncoding = bodyencoding;
            SmtpClient client = new SmtpClient(smtphost);
            client.UseDefaultCredentials = false;
            client.DeliveryMethod = SmtpDeliveryMethod.Network;
            client.Credentials = new NetworkCredential(username, password);
            client.Send(message);
        }
    }
}
