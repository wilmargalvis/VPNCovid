using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VPN.ReglasNegocio;

//Referencia para consumir un servicio
using VPN.App.ServiceReference1;

//referencias para Código QR

using System.IO;
using System.Drawing;
using MessagingToolkit.QRCode.Codec;
using MessagingToolkit.QRCode.Codec.Data;

//Referencia para codigo de barras con Zxing y Video Forge
using AForge.Video;
using AForge.Video.DirectShow;
using ZXing;

namespace VPN.App
{
    public partial class wfAccederRegistro : System.Web.UI.Page
    {
        private Bitmap imgDecoder;

        //public wfAccederRegistro(Bitmap ImgDecoder)
        //{
        //    imgDecoder = ImgDecoder;
        //}

        FilterInfoCollection filterInfoCollection;
        VideoCaptureDevice captureDevice;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                filterInfoCollection = new FilterInfoCollection(FilterCategory.VideoInputDevice);
                foreach (FilterInfo filterinfo in filterInfoCollection)
                {
                    ddlCamaras.Items.Add(filterinfo.Name);
                    ddlCamaras.SelectedIndex = 3;
                }

                //consumir un servicio
                //ServiceTestClient service = new ServiceTestClient();
                //string respuesta = service.testRetunString("wilmar","galvis");
            }

        }

        protected void btnIniciarEscaneoQR_Click(object sender, EventArgs e)
        {
            ClientScript.RegisterStartupScript(GetType(), "Iniciar Scaneo QR","IniciarQR()",true);

            //try
            //{
            //    captureDevice = new VideoCaptureDevice(filterInfoCollection[ddlCamaras.SelectedIndex].MonikerString);
            //    captureDevice.NewFrame += CaptureDevice_NewFrame;
            //    captureDevice.Start();
            //    timer1.Enabled = true;
            //}
            //catch
            //{
                
            //}
        }

        protected void btnPararCamara_Click(object sender, EventArgs e)
        {
            //if (captureDevice.IsRunning)
            //    captureDevice.Stop();

            ClientScript.RegisterStartupScript(GetType(), "Iniciar Scaneo QR", "PararQR()", true);
        }
        private void CaptureDevice_NewFrame(object sender, NewFrameEventArgs eventArgs)
        {
            Bitmap img = (Bitmap)eventArgs.Frame.Clone();
            System.Drawing.Image imagen = (System.Drawing.Image)img;

            using (MemoryStream ms = new MemoryStream())
            {
                imagen.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg);
                byte[] imageBytes = ms.ToArray();
                imgCamara.Src = "data:image/gif;base64," + Convert.ToBase64String(imageBytes);
                imgCamara.Width = 200;
                imgCamara.Height = 200;
            }

            if (imgCamara.Src != null)
            {
                BarcodeReader barcodeReader = new BarcodeReader();
                Result result = barcodeReader.Decode((Bitmap)img);
                if (result != null) {
                    txtUrlQR.Text = result.ToString();
                    timer1.Enabled = false;
                    if (captureDevice.IsRunning)
                        captureDevice.Stop();
                }
            }
        }
        private void timer1Tick() {

        }
        protected void btnBuscarMiembro_Click(object sender, EventArgs e)
        {
            int MiembroID = 0;
            Response.Redirect("~/wfRegistroMiembros.aspx?MiembroID=" + MiembroID.ToString() + "&" + "CC=" + txtCedula.Text);
        }

        protected void btnModal_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "myModal", "$('#exampleModalLong').modal(); ", true);
        }

        public void btnGenerarQR_Click(object sender, EventArgs e)
        {
            QRCodeEncoder encoder = new QRCodeEncoder();
            Bitmap img = encoder.Encode(txtUrlQR.Text);
            imgDecoder = img;
            System.Drawing.Image QR = (System.Drawing.Image)img;

            using (MemoryStream ms = new MemoryStream())
            {
                QR.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg);
                byte[] imageBytes = ms.ToArray();
                ImgCtrl.Src = "data:image/gif;base64," + Convert.ToBase64String(imageBytes);
                ImgCtrl.Width = 200;
                ImgCtrl.Height = 200;
            }

            //Lee la información del código QR generado
            QRCodeBitmapImage qbm = new QRCodeBitmapImage(img);
            QRCodeDecoder decodeer = new QRCodeDecoder();
            lblQR.Text ="Lectura del código es: " + decodeer.Decode(qbm);
        }

        protected void Timer2_Tick(object sender, EventArgs e)
        {
            //if (imgCamara.Src != null)
            //{
            //    BarcodeReader barcodeReader = new BarcodeReader();
            //    Bitmap img = (Bitmap)eventArgs.Frame.Clone();

            //    Result result = barcodeReader.Decode((Bitmap)img);
            //    if (result != null)
            //    {
            //        txtUrlQR.Text = result.ToString();
            //        timer1.Enabled = false;
            //        if (captureDevice.IsRunning)
            //            captureDevice.Stop();
            //    }
            //}
        }
    }
}