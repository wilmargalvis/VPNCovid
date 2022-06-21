using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.IO;
using OfficeOpenXml;
using System.Data;

namespace VPN.Tecnologias
{
    public class ExportarExcel
    {
        public MemoryStream Exportar_Excel(DataTable dt) {

            using (ExcelPackage pck = new ExcelPackage())
            {
                ExcelWorksheet ws = pck.Workbook.Worksheets.Add("Logs");
                ws.Cells["A1"].LoadFromDataTable(dt, true);
                var ms = new System.IO.MemoryStream();
                pck.SaveAs(ms);
                return ms;
            }
        }

        public byte[] binExportar_Excel(DataTable dt)
        {
            using (ExcelPackage pck = new ExcelPackage())
            {
                ExcelWorksheet ws = pck.Workbook.Worksheets.Add("Logs");
                ws.Cells["A1"].LoadFromDataTable(dt, true);
                //byte[] bina = pck.GetAsByteArray();
                //var bina = new System.IO.MemoryStream(pck.GetAsByteArray());
                //var bin = new byte[1000];

                pck.SaveAs(new System.IO.MemoryStream(pck.GetAsByteArray()));
                return pck.GetAsByteArray();
            }
        }
    }
}
