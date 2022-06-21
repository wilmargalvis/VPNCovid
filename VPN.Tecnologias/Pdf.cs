using ExpertPdf.HtmlToPdf;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VPN.Tecnologias
{
    public class Pdf
    {


        private PdfConverter GetPDFConverter(string titulo)
        {

            // create the PDF converter
            PdfConverter pdfConverter = new PdfConverter();
            pdfConverter.LicenseKey = ConfigurationManager.AppSettings["ClavePDF"];
            // set PDF options
            PdfPageSize pageSize = PdfPageSize.Letter;
            pdfConverter.PdfDocumentOptions.PdfPageSize = pageSize;
            pdfConverter.PdfDocumentOptions.PdfPageOrientation = PDFPageOrientation.Portrait;
            pdfConverter.PdfDocumentOptions.ShowHeader = true;
            pdfConverter.PdfDocumentOptions.ShowFooter = true;
            pdfConverter.PdfDocumentOptions.LeftMargin = 20;
            pdfConverter.PdfDocumentOptions.RightMargin = 20;
            pdfConverter.PdfDocumentOptions.TopMargin = 5;
            pdfConverter.PdfDocumentOptions.BottomMargin = 20;
            pdfConverter.PdfDocumentOptions.GenerateSelectablePdf = true;
            pdfConverter.PdfDocumentOptions.EmbedFonts = true;
            pdfConverter.PdfDocumentOptions.LiveUrlsEnabled = true;
            pdfConverter.PdfHeaderOptions.HeaderText = titulo;
            pdfConverter.RenderingEngine = RenderingEngine.WebKit2;


            pdfConverter.PdfHeaderOptions.HeaderImageWidth = 180;
            pdfConverter.PdfHeaderOptions.HeaderImageLocation = new PointF(0, 27);
            ; //Tahoma
            pdfConverter.PdfHeaderOptions.HeaderSubtitleTextFontSize = 7;
            pdfConverter.PdfHeaderOptions.HeaderHeight = 95;
            pdfConverter.PdfHeaderOptions.HeaderTextFontType = PdfFontType.Helvetica;
            pdfConverter.PdfHeaderOptions.HeaderTitleSubtitleYSpacing = 40;
            //pdfConverter.PdfHeaderOptions.HeaderSubtitleText = "Este es el estado de los negocios generado automáticamente por el sistema SOUL en la fecha y hora que aparecen al pie de página. Para una versión actualizada, visite https://soul.magnum.com.co.com.co/Clientes";
            pdfConverter.PdfHeaderOptions.HeaderTextYLocation = 30;

            pdfConverter.PdfFooterOptions.FooterTextFontType = PdfFontType.Helvetica;
            pdfConverter.PdfFooterOptions.FooterText = "Fecha de generación: " + DateTime.Now.ToString();
            pdfConverter.PdfFooterOptions.PageNumberText = "Página";
            pdfConverter.RenderingEngine = RenderingEngine.WebKit2;

            return pdfConverter;
        }





        public byte[] Imprimir(StringBuilder sbResultado,string pTitulo)
        {          
            PdfConverter pdfConverter = GetPDFConverter(pTitulo);
            Byte[] mDocumento = pdfConverter.GetPdfBytesFromHtmlString(sbResultado.ToString());
            return mDocumento;
        }
    }
        
}
