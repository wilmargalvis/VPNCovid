using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VPN.EntidadesNegocio;
using VPN.ReglasNegocio;
namespace VPN
{
    public partial class wfRegistroMiembros : System.Web.UI.Page
    {
        clsBERegistroMiembros objMiembros = new clsBERegistroMiembros();
        private readonly clsBRRegistroMiembros clsBRRegistroMiembros = new clsBRRegistroMiembros();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)//Cuando refresque haga algo
            {
                LlenarMaestro();
                buscarDisponibilidad();

                //hfMiembroId.Value = Request.QueryString["MiembroID"];

                //if ( !string.IsNullOrEmpty(Request.QueryString["MiembroID"])){

                //    if (int.Parse(hfMiembroId.Value) != 0)
                //    {
                //        ConsultarxId();
                //    }
                //    else { 
                //        hfMiembroId.Value = "0";
                //        txtCedula.Text= Request.QueryString["CC"];
                //    }              
                //}
                lblDisponible.Visible = false;
                hfMiembroId.Value = "0";
                //rbTipoMiembro.SelectedValue = "2";
            }
        }

        protected void btnBuscarMiembro_Click(object sender, EventArgs e)
        {
            //txtCedulaBuscar.Text = txtCedulaBuscar.Text.Trim(new Char[] { ' ', '*', '.' });
            int MiembroID = 0;
            mensaje.Visible = false;
            buscarDisponibilidad();
            clsBRRegistroMiembros Obj = new clsBRRegistroMiembros();
            DataTable dtMiembros = Obj.BuscarMiembro(Int64.Parse(txtCedulaBuscar.Text));
            if (dtMiembros.Rows.Count > 0)// Si encontró al usuario
            {
                hfMiembroId.Value = dtMiembros.Rows[0]["MiembroID"].ToString();
                txtCedula.Text = dtMiembros.Rows[0]["Cedula"].ToString();
                txtNombre.Text = dtMiembros.Rows[0]["Nombre"].ToString();
                txtEdad.Text = dtMiembros.Rows[0]["Edad"].ToString();
                txtCelular.Text = dtMiembros.Rows[0]["Celular"].ToString();
                txtCorreo.Text = dtMiembros.Rows[0]["Correo"].ToString();
                ContenedorBuscador.Visible = false;
                ContenedorRegistro.Visible = true;
                txtCedula.Enabled = false;
                ddlCelebracion.SelectedIndex = -1;
                lblDisponible.Text = "";
            }
            else
            {
                hfMiembroId.Value = "0"; // no se encuentra el miembro, es un usuario nuevo
                lblMensaje.Text = "Su identificación: " + txtCedulaBuscar.Text + " no ha sido encontrada, completa los datos";
                mensaje.Attributes["class"] = "alert alert-warning";
                mensaje.Visible = true;
                txtCedula.Text=txtCedulaBuscar.Text;
                txtCedulaBuscar.Text = "";
                rbSintomasCovid.SelectedValue = "0";
                ContenedorBuscador.Visible = false;
                ContenedorRegistro.Visible = true;
                ddlCelebracion.SelectedIndex = -1;
                LimpiarRegistro();
            }
            
        }

        private void LimpiarRegistro()
        {
            txtNombre.Text = "";
            txtEdad.Text= "";
            txtCelular.Text = "";
            txtCorreo.Text = "";
            //rbTipoMiembro.SelectedValue = "2";
            rbSintomasCovid.SelectedValue ="0";
            txtCedula.Enabled = true;
            chkConsentimiento.Checked = false;
            objMiembros.MiembroId = 0;
        }

        /// <summary>
        /// Consulta
        /// </summary>
        /// 

        #region consultar xID Terminar los campos

        #endregion


        private void LlenarMaestro()
        {
            DataTable dtCelebracion = clsBRRegistroMiembros.LlenarMaestro();
            ddlCelebracion.DataSource = dtCelebracion;
            ddlCelebracion.DataTextField = "Celebracion";
            ddlCelebracion.DataValueField = "CelebracionID";
            ddlCelebracion.DataBind();
            ddlCelebracion.Items.Insert(0, new ListItem("-- SELECCIONE AQUÍ EL SERVICIO --","0"));
        }

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            if (ddlCelebracion.SelectedIndex <=0) {
                mensaje.Visible = true;
                mensaje.Attributes["class"] = "alert alert-info";
                lblMensaje.Text = "Aún no ha seleccionado la celebración a la que asistirá";
                return;
            }

            if (Convert.ToInt32(lblDisponible.Text) <= 0)
            {
                mensaje.Visible = true;
                mensaje.Attributes["class"] = "alert alert-info";
                lblMensaje.Text = "El servicio seleccionado NO tiene puestos disponibles, seleccione otra celebración";
                lblDisponible.Text = "0";
                //MsgBox("El servicio seleccionado no tiene puestos disponibles", this.Page, this);
            }
            else {
                //int Registro_duplicado=clsBERegistroMiembros.VerificartAsistenciaDuplicada();
                LlenarEntidad();
                int asistenciaDuplicada = clsBRRegistroMiembros.Guardar(objMiembros);

                if (asistenciaDuplicada == 0)// La reserva no está duplicada
                {
                    mensaje.Visible = true;
                    mensaje.Attributes["class"] = "alert alert-info";
                    //mensaje.Attributes("style") = "height:200px; color:Red";
                    lblMensaje.Text = "Asiento guardado exitosamente para el usuario: " + txtNombre.Text + ", en la celebración " + ddlCelebracion.SelectedItem.Text ;

                    lblDisponible.Text = "";
                    txtCedulaBuscar.Text = "";

                    ContenedorRegistro.Visible = false;
                    ContenedorBuscador.Visible = true;
                    txtCedula.Enabled = true;
                }
                else {
                    mensaje.Visible = true;
                    mensaje.Attributes["class"] = "alert alert-warning";
                    lblMensaje.Text = "La reserva de la celebración " + ddlCelebracion.SelectedItem.Text + " para "+ txtCedula.Text +", ya fue registrada antes";
                    lblDisponible.Text = "";

                    ContenedorRegistro.Visible = false;
                    ContenedorBuscador.Visible = true;
                    txtCedula.Enabled = true;
                    ddlCelebracion.SelectedIndex = -1;
                }

            }

        }
        private void LlenarEntidad()
        {
            objMiembros.Celebracion = int.Parse(ddlCelebracion.SelectedValue);
            objMiembros.Cedula = txtCedula.Text;
            objMiembros.Nombre = txtNombre.Text;
            objMiembros.Edad = int.Parse(txtEdad.Text);
            objMiembros.Celular = Int64.Parse(txtCelular.Text);
            objMiembros.Correo = txtCorreo.Text;           
            //objMiembros.TipoMiembro = int.Parse(rbTipoMiembro.SelectedValue);
            objMiembros.SintomasCovid = int.Parse(rbSintomasCovid.SelectedValue);
            objMiembros.Consentimiento = chkConsentimiento.Checked ? 1 : 0;
            objMiembros.FechaActualizacion = System.DateTime.Today;
            objMiembros.MiembroId = int.Parse(hfMiembroId.Value);
            objMiembros.Asientos = int.Parse(lblDisponible.Text);
            if (hfMiembroId.Value == "0")
            {
                objMiembros.FechaIngreso = System.DateTime.Today;
            }
            else { objMiembros.FechaIngreso = null; }
        }

        protected void txtCedula_TextChanged(object sender, EventArgs e)
        {
            string x = txtCedula.Text;
        }

        protected void ddlCelebracion_Change(object sender, EventArgs e)
        {
            buscarDisponibilidad();
        }

        private void buscarDisponibilidad()
        {
            mensaje.Visible = false;

            if (ddlCelebracion.SelectedIndex<=0) {
                return;
            }
            int disponibilidad = clsBRRegistroMiembros.ConsultarDisponibilidadxCelebracionId(Convert.ToInt32(string.IsNullOrEmpty(ddlCelebracion.SelectedValue.ToString()) ? "0" : ddlCelebracion.SelectedValue.ToString()));
            lblDisponible.Text = disponibilidad.ToString();
            lblDisponible.Visible = true;
            if (Convert.ToInt32(lblDisponible.Text) <= 0)
            {
                mensaje.Visible = true;
                mensaje.Attributes["class"] = "alert alert-info";
                lblMensaje.Text = "El servicio seleccionado NO tiene puestos disponibles, seleccione otra celebración";
                //MsgBox("El servicio seleccionado no tiene puestos disponibles", this.Page, this);
            }
        }

        public void MsgBox(String ex, Page pg, Object obj)
        {
            string s = "<SCRIPT language='javascript'>alert('" + ex.Replace("\r\n", "\\n").Replace("'", "") + "'); </SCRIPT>";
            Type cstype = obj.GetType();
            ClientScriptManager cs = pg.ClientScript;
            cs.RegisterClientScriptBlock(cstype, s, s.ToString());
        }

        private void alert(string message)
        {
            Response.Write("<script>alert('" + message + "')</script>");
            
        }

        protected void btnNuevo_Command(object sender, CommandEventArgs e)
        {
            Response.Redirect("~/wfRegistroMiembros.aspx");
        }

    }
}