<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="wfRegistroMiembros.aspx.cs" Inherits="VPN.wfRegistroMiembros" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">


     <div class="container border border-info" runat="server" style="margin-top: 40px;" id="ContenedorBuscador">
        <div class="form-group row">
            <div class="col-sm-8 mt-4">
                <!--mt-3 = Margin Top-->
                <h4 style="text-align: right">Buscar mis datos y registrarme</h4>
            </div>
            <div class="col-sm-3" style="text-align: right">
                <img src="https://vidaparalasnaciones.com/wp-content/uploads/2020/06/cropped-Logo.jpg" />

            </div>
        </div>

        <%--<div class="text-right p-4" style="color: blue; font-size: 17px">
            <asp:linkbutton id="lblbuscarMiembro" OnClick="linkBuscarMiembro_Click" runat="server">Ir a registro de miembros</asp:linkbutton>
        </div>--%>

<%--         <div class="form-group row">
             <div class="col-sm-12" style="text-align:center;">
                 <span style="font-weight:500">Próximos Eventos Especiales:</span>
                 <asp:Label runat="server" ForeColor="Red"> Primera reunión de Mujeres, viernes 19 de febrero 07:00pm</asp:Label>
             </div>
         </div>--%>

        <div class="form-group row">
            <div class="col-sm-6" style="text-align: right">
                <label for="nombre">Ingrese la cédula a buscar<span id="cedulabuscarspan" style="color: red; font-size: 14px"> *</span></label>
            </div>
            <div class="col-sm-2" style="text-align: left">
                <asp:TextBox runat="server" CssClass="form-control" placeholder="Cédula" ID="txtCedulaBuscar" Type="number" > </asp:TextBox><br>
                <asp:RequiredFieldValidator ID="rqvbuscarMiembro" ForeColor="Red" ErrorMessage="Ingrese el número" ControlToValidate="txtCedulaBuscar" ValidationGroup="buscarusuario" runat="server" />
            </div>
            <div class="col-sm-4" style="text-align: left">
                <asp:Button runat="server" ID="btnBuscarMiembro" CssClass="btn btn-primary" OnClick="btnBuscarMiembro_Click" Text="Buscar" ValidationGroup="buscarusuario" CausesValidation="true" />
            </div>
        </div>

         <!--"^(\d{1,10})$"  =   máximo de 10 números-->
         <div class="form-group row">
             <div class="col-sm-12" style="text-align: center">
                    <asp:RegularExpressionValidator ID="revtxtCedulaBuscar" runat="server"             
                    ErrorMessage="Ingrese un mínimo 7 números, y un máximo 10 números"            
                    ValidationExpression="^[\s\S]{7,10}$"
                    ControlToValidate="txtCedulaBuscar" ValidationGroup="buscarusuario"            
                    Display="Dynamic" ForeColor="Red"></asp:RegularExpressionValidator>
             </div>
         </div>

    </div>

    <div class="form-group row" style="text-align: center">
        <div class="col-sm-12">
            <div runat="server" id="mensaje" visible="false">
                <asp:Label runat="server" ID="lblMensaje" />
            </div>
        </div>
    </div>

    <%--  FORMULARIO DE REGISTRO COVID-19 --%>

    <div class="container border border-info" runat="server" style="margin-top: 40px;" id="ContenedorRegistro" visible="false">

        <div class="form-group row">
            <div class="col-sm-4 text-right">
                <br>
                <h3 style="align-self: auto;" for="titulo-registro">Registro Iglesia VPN</h3>
                <asp:HiddenField runat="server" ID="hfMiembroId" Value="0" />
            </div>

<%--            <div class="col-sm-0 spinner-border text-danger spinner-border m-4" role="status" id="cargando">
                <span class="sr-only">Loading...</span>
            </div>--%>

            <div class="col-sm-4 text-right p-1">
                <img src="https://vidaparalasnaciones.com/wp-content/uploads/2020/06/cropped-Logo.jpg" />
                <!---->
            </div>

        </div>


        <div class="form-group row">
            <div class="col-sm-3">
                <label for="celebracion">Elija el servicio al que asistirá<span id="celebracionspan" style="color: red; font-size: 14px">*</span></label>
            </div>
            <div class="col-sm-6">
                <asp:DropDownList runat="server" ID="ddlCelebracion" CssClass="form-control" OnSelectedIndexChanged="ddlCelebracion_Change" AutoPostBack="True">
                   
                </asp:DropDownList>

                <asp:RequiredFieldValidator runat="server" ID="rqvCelebracion" ControlToValidate="ddlCelebracion" InitialValue="0" ForeColor="Red" ErrorMessage="Falta seleccionar la celebración"></asp:RequiredFieldValidator>
            </div>
            <div class="col-sm-3">
                <span id="disponibilidadspan" style="color: red; font-size: 14px">Puestos Disponibles: </span>
               
                <asp:Label ID="lblDisponible" runat="server"></asp:Label>
               
            </div>
        </div>

        <div class="form-group row">
            <div class="col-sm-3">
                <label for="cedula">Cédula o Identificación <span id="cedulaspan" style="color: red; font-size: 14px"> *</span></label>
            </div>
            <div class="col-sm-3">

                <asp:TextBox runat="server" placeholder="Cédula" ID="txtCedula"  type="number" CssClass="form-control" required ></asp:TextBox>

            </div>
            <div class="col-sm-3">
                <label for="nombre">Nombre<span id="nombrespan" style="color: red; font-size: 14px"> *</span></label>
            </div>
            <div class="col-sm-3">
                <asp:TextBox runat="server" CssClass="form-control" placeholder="Nombre" ID="txtNombre" required />
            </div>
        </div>

        <div class="form-group row">
            <div class="col-sm-3">
                <label for="edad">Edad<span id="edadspan" style="color: red; font-size: 14px"> *</span></label>
            </div>
            <div class="col-sm-3">
                <asp:TextBox runat="server" type="number" CssClass="form-control" placeholder="Edad" ID="txtEdad" MaxLength="2" required />
            </div>
            <div class="col-sm-3">
                <label for="temp">Celular o fijo<span id="celularspan" style="color: red; font-size: 14px"> *</span></label>
            </div>
            <div class="col-sm-3">
                <asp:TextBox runat="server" CssClass="form-control" placeholder="Celular o Fijo" ID="txtCelular" MaxLength="10"  required />
            </div>
        </div>

        <div class="form-group row">
            <div class="col-sm-3">
                <label for="temp">Correo Electrónico<span id="correospan" style="color: red; font-size: 14px"> *</span></label>
            </div>
            <div class="col-sm-3">
                <asp:TextBox runat="server" CssClass="form-control" placeholder="Correo" ID="txtCorreo" />
            </div>

<%--            <div class="col-sm-3">
                <label for="celebracion">Es primera vez que asiste a VPN?<span id="tipoMiembrospan" style="color: red; font-size: 14px;text-align:left"> *</span></label>
            </div>--%>

<%--            <div class="col-sm-3">
                <asp:RadioButtonList ID="rbTipoMiembro" runat="server" required="required" aria-required="true" CausesValidation="true" RepeatDirection="Horizontal">
                    <asp:ListItem Value="1">Si</asp:ListItem>
                    <asp:ListItem Value="0">No</asp:ListItem>
                    <asp:ListItem Value="2" Selected="True">Seleccione</asp:ListItem>
                    
                </asp:RadioButtonList>
                <asp:RequiredFieldValidator ID="rvfvalidation" ErrorMessage="Requerido" ControlToValidate="rbTipoMiembro" ForeColor="Red" runat="server" InitialValue="2" />
            </div>--%>

         </div><br>

        <div class="form-group row">
            <div class="col-sm-12" style="text-align: center;">
                <label for="temp" style="font-weight: bolder">Declaro NO TENER, ni haber tenido síntomas asociados al COVID-19 y no haber estado en contacto con personas con síntomas asociados COVID-19 en los últimos 15 días. </label>
            </div>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ErrorMessage="Requerido" ControlToValidate="rbSintomasCovid" ForeColor="Red" runat="server" />

        </div>

        <div class="form-group row">
            <div class="col-sm-2" style="text-align: right">
                    <asp:RadioButtonList ID="rbSintomasCovid" runat="server" required="required" aria-required="true" RepeatDirection="Horizontal">
                        <asp:ListItem Value="1">Si</asp:ListItem>
                        <asp:ListItem Value="0">No</asp:ListItem>
                    </asp:RadioButtonList>
            </div>
            <div class="col-sm-10" style="text-align: left">
                    <a href="#exampleModal" data-bs-toggle="modal" data-bs-target="#exampleModal">Ver Síntomas</a>
            </div>
        </div>

        <div class="form-group form-check" style="text-align: center;">

            <div class="col-sm-12" style="text-align: center">
                <asp:CheckBox runat="server" CssClass="form-check-input" ID="chkConsentimiento" required="required" aria-required="true" />
                <asp:Label runat="server" CssClass="form-check-label" for="chkConsentimiento">Doy consentimiento para que VIDA PARA LAS NACIONES almacene mis datos y se ponga en contacto conmigo </asp:Label>
                <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="*Requerido" ForeColor="Red" ClientValidationFunction="ValidateCheckBox"></asp:CustomValidator>
            </div>

        </div>

        <div class="form-group row">
            <div class="alert alert-danger col-sm-12" runat="server" id="Div1" visible="false">
                <asp:Label runat="server" ID="Label1"></asp:Label>

            </div>
            </div>
        <div class="form-group row">
            <div class="col-sm-12">
                <div style="text-align: center;">
                    <asp:Button runat="server" ID="btnRegistrar" CssClass="btn btn-primary" OnClick="btnRegistrar_Click" Text="Guardar" CausesValidation="true"/>
                    <asp:LinkButton runat="server" ID="btnNuevo" OnCommand="btnNuevo_Command" Text="Nuevo" CausesValidation="false" CssClass="btn btn-primary"/>
                </div>
            </div>
        </div>
        
    </div>


    <%--MENSAJE MODAL--%>


  <!-- Modal -->
  <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">

    <div class="modal-dialog" >
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Síntomas Covid-19</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
            <ol>
                <li>Fiebre (temperatura mayor a 38 °C)</li>
                <li>Dolor de garganta</li>
                <li>Congestión nasal</li>
                <li>Tos</li>
                <li>Dificultad para respirar</li>
                <li>Fatiga</li>
                <li>Escalofrio</li>
                <li>Dolor muscular</li>
                <li>Pérdida de gusto</li>
                <li>Pérdida de olfato</li>
                <li>Diarrea</li>
                <li><p>Convive o ha tenido contacto cercano en los últimos 14 días (a menos de 2 metros y por más de 15 minutos) con alguien diagnosticado con COVID-19 o en proceso de diagnóstico </p></li>
            </ol>
            
            <p><b>Recuerda:</b></p>

            <ul>
                <li>Llevar y portar todo el tiempo el tapabocas</li>
                <li>Subir el tapabocas hasta la nariz</li>
                <li>Evitar el contacto directo con los hermanos</li>
                <li>Conservar una distancia prudente al saludar y conversar</li>
                <li>Tomar y frotar el gel antibacterial en sus manos, a la entrada del templo</li>
            </ul>

        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>

        <script>
            function ValidateCheckBox(sender, args) {
                if (document.getElementById("<%=chkConsentimiento.ClientID %>").checked == true) {
                    args.IsValid = true;
                } else {
                    args.IsValid = false;
                }
            }

        </script>


</asp:Content>
