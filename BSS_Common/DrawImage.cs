using System;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;
using System.Drawing.Drawing2D;
using System.Web;

namespace Trilink.Common
{
    /// <summary>
    ///图片处理
    /// </summary>
    public class DrawImage
    {
        public DrawImage() { }

        #region 计算图片压缩大小
        /// <summary>
        ///  计算图片压缩大小
        /// </summary>
        /// <param name="maxWidth">压缩的最大宽度</param>
        /// <param name="maxHeight">压缩的最大高度</param>
        /// <param name="width">原始宽度</param>
        /// <param name="height">原始高度</param>
        /// <returns>返回等比例压缩后的size</returns>
        private Size compressNewSize(int maxWidth, int maxHeight, int width, int height)
        {
            double w = 0.0;
            double h = 0.0;
            double sw = Convert.ToDouble(width);
            double sh = Convert.ToDouble(height);
            double mw = Convert.ToDouble(maxWidth);
            double mh = Convert.ToDouble(maxHeight);

            if (sw < mw && sh < mh)
            {
                w = sw;
                h = sh;
            }
            else if ((sw / sh) > (mw / mh))
            {
                w = maxWidth;
                h = (w * sh) / sw;
            }
            else
            {
                h = maxHeight;
                w = (h * sw) / sh;
            }
            return new Size(Convert.ToInt32(w), Convert.ToInt32(h));
        }
        #endregion

        #region 计算图片裁剪大小
        /// <summary>
        ///  计算图片压缩大小
        /// </summary>
        /// <param name="maxWidth">裁剪的最大宽度</param>
        /// <param name="maxHeight">裁剪的最大高度</param>
        /// <param name="width">原始宽度</param>
        /// <param name="height">原始高度</param>
        /// <returns>返回等比例裁剪后的size</returns>
        private Size cutNewSize(int maxWidth, int maxHeight, int width, int height)
        {
            double w = 0.0;
            double h = 0.0;
            double sw = Convert.ToDouble(width);
            double sh = Convert.ToDouble(height);
            double mw = Convert.ToDouble(maxWidth);
            double mh = Convert.ToDouble(maxHeight);

            if (sw < mw || sh < mh)
            {
                w = sw;
                h = sh;
            }
            else if ((sw / sh) > (mw / mh))
            {
                w = (sw / sh) * mh;
                h = mh;
            }
            else
            {
                h = (sh / sw) * mw;
                w = mw;
            }

            return new Size(Convert.ToInt32(w), Convert.ToInt32(h));
        }
        #endregion

        #region 处理图片并输出
        /// <summary>
        ///  处理图片并输出
        /// </summary>
        /// <param name="maxWidth">处理的最大宽度</param>
        /// <param name="maxHeight">处理的最大高度</param>
        /// <param name="imgdata">处理的图片对象</param>
        /// <param name="type">处理的类型,0为压缩,1为裁剪</param>
        /// <returns>处理图片并输出处理后的图像</returns>
        public void SendSmallImage(int? maxWidth, int? maxHeight, object imgdata, int type)
        {
            MemoryStream stream1 = new MemoryStream((byte[])imgdata);
            Image img = Image.FromStream(stream1);
            ImageFormat thisFormat = img.RawFormat;
            Size newSize = new Size(img.Width, img.Height);
            Bitmap outBmp = new Bitmap(img.Width, img.Height);
            if (maxWidth != null && maxHeight != null)
            {
                newSize = (type == 0 ? compressNewSize(maxWidth.Value, maxHeight.Value, img.Width, img.Height) : cutNewSize(maxWidth.Value, maxHeight.Value, img.Width, img.Height));
                outBmp = (type == 0 ? new Bitmap(newSize.Width, newSize.Height) : new Bitmap(maxWidth.Value, maxHeight.Value));
            }
            else type = 0;
            Graphics g = Graphics.FromImage(outBmp);

            //设置画布的描绘质量
            g.CompositingQuality = CompositingQuality.HighQuality;
            g.SmoothingMode = SmoothingMode.HighQuality;
            g.InterpolationMode = InterpolationMode.HighQualityBicubic;
            if (type == 0)
            {
                g.DrawImage(img, new Rectangle(0, 0, newSize.Width, newSize.Height), 0, 0, img.Width, img.Height, GraphicsUnit.Pixel);
            }
            else
            {
                SolidBrush sb = new SolidBrush(Color.White);
                g.FillRectangle(sb, 0, 0, maxWidth.Value, maxHeight.Value);
                g.DrawImage(img, new Rectangle((maxWidth.Value - newSize.Width) / 2, (maxHeight.Value - newSize.Height) / 2, newSize.Width, newSize.Height), 0, 0, img.Width, img.Height, GraphicsUnit.Pixel);
            }
            g.Dispose();
            if (thisFormat.Equals(ImageFormat.Gif))
            {
                HttpContext.Current.Response.ContentType = "image/gif";
            }
            else
            {
                HttpContext.Current.Response.ContentType = "image/jpeg";
            }

            //以下代码为保存图片时，设置压缩质量
            EncoderParameters encoderParams = new EncoderParameters();
            long[] quality = new long[1];
            quality[0] = 100;

            EncoderParameter encoderParam = new EncoderParameter(System.Drawing.Imaging.Encoder.Quality, quality);
            encoderParams.Param[0] = encoderParam;

            //获得包含有关内置图像编码解码器的信息的ImageCodecInfo 对象。
            ImageCodecInfo[] arrayICI = ImageCodecInfo.GetImageEncoders();
            ImageCodecInfo jpegICI = null;
            for (int x = 0; x < arrayICI.Length; x++)
            {
                if (arrayICI[x].FormatDescription.Equals("JPEG"))
                {
                    jpegICI = arrayICI[x];//设置JPEG编码
                    break;
                }
            }

            if (jpegICI != null)
            {
                outBmp.Save(HttpContext.Current.Response.OutputStream, jpegICI, encoderParams);
            }
            else
            {
                outBmp.Save(HttpContext.Current.Response.OutputStream, thisFormat);
            }

            img.Dispose();
            outBmp.Dispose();
            HttpContext.Current.Response.End();
        }
        #endregion
    }
}
