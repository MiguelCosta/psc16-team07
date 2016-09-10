using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;
using System.Web.Hosting;

namespace MyMenu.Api.Helpers
{
    public static class ResponseHelper
    {
        /// <summary>
        /// Generate response with image
        /// </summary>
        /// <param name="file"></param>
        /// <returns></returns>
        public static async Task<HttpResponseMessage> GenerateResponseImage(string file)
        {
            var result = new HttpResponseMessage(HttpStatusCode.OK);
            string filePath = HostingEnvironment.MapPath(file);
            if(File.Exists(filePath) == false)
            {
                return new HttpResponseMessage(HttpStatusCode.NotFound);
            }

            var fileStream = new FileStream(filePath, FileMode.Open);
            var image = Image.FromStream(fileStream);
            var memoryStream = new MemoryStream();
            image.Save(memoryStream, ImageFormat.Jpeg);

            result.Content = new ByteArrayContent(memoryStream.ToArray());
            result.Content.Headers.ContentType = new MediaTypeHeaderValue("image/jpeg");

            await fileStream.FlushAsync();
            fileStream.Close();
            await memoryStream.FlushAsync();
            memoryStream.Close();

            return result;
        }
    }
}
