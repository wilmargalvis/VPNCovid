
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VPN.ReglasNegocio;
using VPN.Tecnologias;
using OfficeOpenXml;
using System.IO;

namespace VPN.App
{
    public partial class wfConsultaUsuarios : System.Web.UI.Page
    {
        Pdf GetPdf = new Pdf();
        ExportarExcel GetExcel = new ExportarExcel();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) {
                //exportarExcel();

            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            lbltemperatura.Visible = false;
            lblNombre.Visible = false;
            txtTemperatura.Visible = false;
            btnGuardarTemperatura.Visible = false;

            if (string.IsNullOrEmpty(txtNombre.Text) && string.IsNullOrEmpty(txtCedula.Text))
            {
                mensaje.Visible = true;
                mensaje.Attributes["class"] = "alert alert-info";
                lblMensaje.Text = "No ha ingresado los datos del miembro que desea buscar";
                
                return;
            }
            mensaje.Visible = false;
            clsBRRegistroMiembros objBR = new clsBRRegistroMiembros();
            DataTable dt = objBR.BuscarListadoAsistenciaCelebracion(txtCedula.Text, txtNombre.Text);

            gvTablaUno.DataSource = dt;
            gvTablaUno.DataBind();
            gvTablaUno.ForeColor= System.Drawing.Color.White;

            if(gvTablaUno.Rows.Count ==0){
                txtTemperatura.Visible = false;
                lbltemperatura.Visible = false;
                btnGuardarTemperatura.Visible = false;
            }
        }

        public void MsgBox(String ex, Page pg, Object obj)
        {
            string s = "<SCRIPT language='javascript'>alert('" + ex.Replace("\r\n", "\\n").Replace("'", "") + "'); </SCRIPT>";
            Type cstype = obj.GetType();
            ClientScriptManager cs = pg.ClientScript;
            cs.RegisterClientScriptBlock(cstype, s, s.ToString());
        }

        protected void btnGuardarTemperatura_Click(object sender, EventArgs e)
        {
            string IDMiembro = hfMiembroId.Value;
            clsBRRegistroMiembros objGuardarTemperatura = new clsBRRegistroMiembros();
            objGuardarTemperatura.GuadarTemperatura(IDMiembro,txtTemperatura.Text);
            mensaje.Visible = true;
            mensaje.Attributes["class"] = "alert alert-info";
            lblMensaje.Text = "Se ha actualizado la temperatura de " + lblNombre.Text;
            //MsgBox("Miembro actualizado correctamente", this.Page, this);
        }

        protected void btnEditar_Command(object sender, CommandEventArgs e)
        {
            mensaje.Visible = false;
            hfMiembroId.Value = e.CommandArgument.ToString();
            lblNombre.Text = e.CommandName;
            txtTemperatura.Text = "";
            lbltemperatura.Visible = true;
            lblNombre.Visible = true;
            txtTemperatura.Visible = true;
            btnGuardarTemperatura.Visible = true;
        }
        protected  StringBuilder ConsultarMiembros() {

            StringBuilder sbResultado = new StringBuilder();                       
            clsBRRegistroMiembros objBR = new clsBRRegistroMiembros();
            DataTable dt = objBR.BuscarAsistenciaxFechas(Convert.ToDateTime(txtFecha.Text), Convert.ToDateTime(txtFecha2.Text));

            sbResultado.Append("<div style=\"font-size: 9pt; font-family: Tahoma;\">");
            sbResultado.Append("<table width=\"100%\" border=\"0\">");
            sbResultado.Append("<tr>");

            sbResultado.Append("<td style=\"text-align: center;background-color:#BDBDBD\" width=\"20%\">");
            sbResultado.Append("Nombre");
            sbResultado.Append("</td>");

            sbResultado.Append("<td style=\"text-align: center;background-color:#BDBDBD\" width=\"20%\">");
            sbResultado.Append("Cedula");
            sbResultado.Append("</td>");

            sbResultado.Append("<td style=\"text-align: center;background-color:#BDBDBD\" width=\"20%\">");
            sbResultado.Append("Edad");
            sbResultado.Append("</td>");

            sbResultado.Append("<td style=\"text-align: center;background-color:#BDBDBD\" width=\"20%\">");
            sbResultado.Append("Celebracion");
            sbResultado.Append("</td>");

            sbResultado.Append("<td style=\"text-align: center;background-color:#BDBDBD\" width=\"20%\">");
            sbResultado.Append("Temperatura");
            sbResultado.Append("</td>");

            sbResultado.Append("</tr>");

            foreach (DataRow mfila in dt.Rows) {

                sbResultado.Append("<tr>");
              
                sbResultado.Append("<td style=\"text-align: center; width=\"20%\">");
                sbResultado.Append(mfila["Nombre"]);
                sbResultado.Append("</td>");
                
                sbResultado.Append("<td style=\"text-align: center; width=\"20%\">");
                sbResultado.Append(mfila["Cedula"]);
                sbResultado.Append("</td>");


                sbResultado.Append("<td style=\"text-align: center; width=\"20%\">");
                sbResultado.Append(mfila["Edad"]);
                sbResultado.Append("</td>"); 


                sbResultado.Append("<td style=\"text-align: center; width=\"20\">");
                sbResultado.Append(mfila["Celebracion"]);
                sbResultado.Append("</td>");



                sbResultado.Append("<td style=\"text-align: center; width=\"20\">");
                sbResultado.Append(mfila["Temperatura"]);
                sbResultado.Append("</td>");

                sbResultado.Append("<tr>");
            }

            sbResultado.Append("</table>");

            sbResultado.Append("</BR>");
            sbResultado.Append("</div>");
            hfMiembroId.Value = "0";
            return sbResultado;


        }


        protected void Imprimirpdf(string pNombreArchivo) {

            StringBuilder sb = new StringBuilder();
            sb.Append(ConsultarMiembros());
            Byte[] mDocumento = GetPdf.Imprimir(sb, "Celebraciones");
            Response.Clear();
            Response.ContentType = "application/pdf";
            Response.Headers.Add("content-disposition", "attachment;filename=" + pNombreArchivo+"_"+ txtFecha.Text+"_" + txtFecha2.Text + ".pdf");
            Response.Buffer = true;
            Response.BinaryWrite(mDocumento);
            Response.Flush();
            Response.End();

        }

        protected void btnImprimir_Click(object sender, EventArgs e)
        {
            mpBuscador.Show();
        }

        protected void btnCerrar_Click(object sender, EventArgs e)
        {
            mpBuscador.Hide();
        }

        protected void btnDescargar_Click(object sender, EventArgs e)
        {
            Imprimirpdf("Celebraciones");
        }

        //TODO Centralizar
        protected void exportarExcel() {
            clsBRRegistroMiembros objConsultarNuevos = new clsBRRegistroMiembros();
            DataTable dt= objConsultarNuevos.objConsultarNuevos(Convert.ToDateTime(txtFecha.Text), Convert.ToDateTime(txtFecha2.Text));

            //using (ExcelPackage pck = new ExcelPackage())
            //{
            //    ExcelWorksheet ws = pck.Workbook.Worksheets.Add("Logs");
            //    ws.Cells["A1"].LoadFromDataTable(dt, true);
            //    var ms = new System.IO.MemoryStream();
            //    pck.SaveAs(ms);
            //    Response.Clear();
            //    Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            //    Response.AddHeader("Content-Disposition", "attachment;filename=" + "archivo" + ".xlsx");
            //    ms.WriteTo(Response.OutputStream);
            //    Response.End();
            //}

            //byte[] binarioExcel= GetExcel.binExportar_Excel(dt);
            //Response.Clear();
            //Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            //Response.AddHeader("Content-Disposition", "attachment;filename=" + "archivo" + ".xlsx");
            //Response.Buffer = true;
            //Response.BinaryWrite(binarioExcel);
            //Response.Flush();
            //Response.End();

        }

        protected void btnDescargarNuevos_Click(object sender, EventArgs e)
        {
            clsBRRegistroMiembros objConsultarNuevos = new clsBRRegistroMiembros();
            DataTable dt = objConsultarNuevos.objConsultarNuevos(Convert.ToDateTime(txtFecha.Text), Convert.ToDateTime(txtFecha2.Text));

            MemoryStream MemoryExcel = GetExcel.Exportar_Excel(dt);
            Response.Clear();
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.AddHeader("Content-Disposition", "attachment;filename=" + "Nuevos VPN " + "_ " + txtFecha.Text + "_" + txtFecha2.Text + ".xlsx");
            MemoryExcel.WriteTo(Response.OutputStream);
            Response.End();
        }
    }
}