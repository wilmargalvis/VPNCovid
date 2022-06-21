<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="wfConsultaUsuarios.aspx.cs" Inherits="VPN.App.wfConsultaUsuarios" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


<style>
.ModalPopupBG {
    background-color: #666699;
    filter: alpha(opacity=50);
    opacity: 0.7;
}

.HellowWorldPopup {
    min-width: 520px;
    min-height: 200px;
    background: #808080;
    justify-content: center;
}


</style>




    <div class="container border border-info" style="margin-top: 40px;">


        <div class="form-group row">
            <div class="col-sm-10 mt-4">
                <!--mt-3 = Margin Top-->
                <h4 style="text-align: center">Buscar Reserva de asistencia a VPN</h4>
            <div class="text-right p-3">
                <asp:HyperLink NavigateUrl="~/wfRegistroMiembros.aspx" runat="server" Text="Ir a registro de miembros" />
            </div>

            </div>
            <div class="col-sm-2">
                <img src="https://vidaparalasnaciones.com/wp-content/uploads/2020/06/cropped-Logo.jpg" />

            </div>
        </div>
        <br>

        <%--        <div class="text-right p-4" style="color: blue; font-size: 17px">
            <asp:linkbutton id="lblbuscarMiembro" OnClick="linkBuscarMiembro_Click" runat="server">Ir a registro de miembros</asp:linkbutton>
        </div>--%>

        <div class="form-group row">
            <div class="col-sm-3">
                <label for="nombre">Ingrese el nombre<span id="nombrespan" style="color: red; font-size: 14px"> *</span></label>
            </div>
            <div class="col-sm-3">

                <asp:TextBox runat="server" placeholder="Nombre" ID="txtNombre" ValidationGroup="Validarbusqueda" class="form-control"></asp:TextBox>

            </div>
            <div class="col-sm-3">
                <label for="nombre">Ingrese la Cédula<span id="cedulaspan" style="color: red; font-size: 14px"> *</span></label>
            </div>
            <div class="col-sm-3">
                <asp:TextBox runat="server" class="form-control" placeholder="Cédula" ID="txtCedula" ValidationGroup="Validarbusqueda" type="number"> </asp:TextBox>
            </div>
        </div>

        <div class="p-3" style="text-align: center;">
            <asp:Button runat="server" ID="btnBuscar" CssClass="btn btn-primary" OnClick="btnBuscar_Click" Text="Buscar" ValidationGroup="Validarbusqueda" CausesValidation="true" />
            <asp:Button Text="Imprimir" ID="btnImprimir" CssClass=" btn btn-primary" OnClick="btnImprimir_Click" runat="server" ValidationGroup="validarIngresoFecha" CausesValidation="true"/>
        </div>
        <asp:GridView ID="gvTablaUno" runat="server" AutoGenerateColumns="false" HorizontalAlign="Center" BackColor="#adb5bd" BorderColor="#ffffff">
            <Columns>
                <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                <asp:BoundField DataField="Cedula" HeaderText="Cedula" />
                <asp:BoundField DataField="Edad" HeaderText="Edad" />
                <asp:BoundField DataField="Celebracion" HeaderText="Celebración Seleccionada" />

                <asp:TemplateField HeaderText="Editar">
                    <ItemTemplate>
                        <asp:LinkButton runat="server" ID="btnEditar" CommandArgument='<%# Eval("AsistenciaxcelebracionID") %>' CommandName='<%# Eval("Nombre") %>' OnCommand="btnEditar_Command" Text="Editar" CausesValidation="false" CssClass="btn btn-primary" />

                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView><br>

        <div class="form-group row">
            <div class="col-sm-6" style="text-align: right">
                <asp:Label runat="server" ID="lbltemperatura" Text="Temperatura" Visible="false"/>
                <asp:Label runat="server" ID="lblNombre" Font-Bold="true"></asp:Label>
                <asp:HiddenField runat="server" ID="hfMiembroId" Value="0" />
            </div>
             <div class="col-sm-2" style="text-align: right">
                <asp:TextBox runat="server" ID="txtTemperatura" PlaceHolder="Temperatura" ValidationGroup="validarTemperatura" Visible="false" />
            </div>
            <div class="col-sm-2" style="text-align: left">
                <asp:Button Text="Actualizar" ID="btnGuardarTemperatura" CssClass=" btn btn-primary" OnClick="btnGuardarTemperatura_Click" runat="server" ValidationGroup="validarTemperatura" CausesValidation="true" Visible="false"/>
            </div>

            <div class="col-sm-2">

            </div>

          </div>

    <div class="form-group row">
        <div class="col-sm-12" style="text-align: center">
            <asp:RequiredFieldValidator ID="rqvTemperatura" ErrorMessage="No ha ingresado la temperatura" ForeColor="Red" ControlToValidate="txtTemperatura" ValidationGroup="validarTemperatura" runat="server" />  
         </div>
     </div>

    <div class="form-group row">
        <div class="col-sm-12" style="text-align: center">
            <asp:RegularExpressionValidator ID="rvtxtTemperatura" runat="server"
                ErrorMessage="Ingrese coma(,) en lugar del punto(.)"
                ValidationExpression="[0-9]+(,[0-9]{1,3})?"
                ControlToValidate="txtTemperatura" ValidationGroup="validarTemperatura"
                Display="Dynamic" ForeColor="Red"></asp:RegularExpressionValidator>
        </div>
    </div>

    <div class="form-group row" style="text-align: center">
        <div class="col-sm-12">
            <div runat="server" id="mensaje" visible="false">
                <asp:Label runat="server" ID="lblMensaje" />
            </div>
        </div>
    </div>

    </div>


<%--    Modal--%>
    <div>
 <ajaxToolkit:ModalPopupExtender ID="mpBuscador" runat="server"
    TargetControlID="hfModal" 
    PopupControlID="Panel1" 
    BackgroundCssClass="modalBackground" 
    DropShadow="true" 
    OnOkScript="onOk()"
    >
   

</ajaxToolkit:ModalPopupExtender>

        <asp:HiddenField runat="server" ID="hfModal" />
     <asp:panel id="Panel1" runat="server">

	    <div class="HellowWorldPopup">
                   
                 <div class="modal-content">

                     <div class="modal-header">
                        <h5 class="modal-title">Buscar</h5>
                     </div>

                       <div class="modal-body">
                           <div class="form-group row">
                                 <div class="col-6">
                                 <asp:Label runat="server" Text="Ingrese fecha inicial"></asp:Label>
                                </div>
                                <div class="col-6">
                                 <asp:Label runat="server" Text="Ingrese fecha final"></asp:Label>
                                </div>
                           </div>

                           <div class="form-group row">

                                 <div class="col-6">
                                      <asp:TextBox runat="server" ID="txtFecha"></asp:TextBox>
                                     <asp:Image runat="server"  ImageUrl="~/images/Calendar.png"  ID="imgCalendar"/>
                                      <ajaxToolkit:CalendarExtender ID="txtFecha_CalendarExtender" Format="dd/MM/yyyy" runat="server" BehaviorID="txtFecha_CalendarExtender" TargetControlID="txtFecha" PopupButtonID="imgCalendar" />
                                     <asp:RequiredFieldValidator InitialValue=""  runat="server" ID="rq" ControlToValidate="txtFecha" ForeColor="Red" ErrorMessage="*"></asp:RequiredFieldValidator>
                                </div>
                               <div class="col-6">
                                   <asp:TextBox runat="server" ID="txtFecha2"></asp:TextBox>
                                   <asp:Image runat="server" ImageUrl="~/images/Calendar.png" ID="imgCalendar2" />
                                   <ajaxToolkit:CalendarExtender ID="txtFecha_CalendarExtender2" Format="dd/MM/yyyy" runat="server" BehaviorID="txtFecha_CalendarExtender2" TargetControlID="txtFecha2" PopupButtonID="imgCalendar2" />
                                   <asp:RequiredFieldValidator InitialValue="" runat="server" ID="rq2" ControlToValidate="txtFecha2" ForeColor="Red" ErrorMessage="*"></asp:RequiredFieldValidator>
                               </div>
                           </div>

                  </div>
                  <div class="modal-footer">
                      <asp:Button runat="server"  ID="btnDescargar" Text="Descargar asistencia" CssClass="btn btn-primary" OnClick="btnDescargar_Click"/>
                      <asp:Button runat="server"  ID="btnDescargarNuevos" Text="Descargar nuevos" CssClass="btn btn-primary" OnClick="btnDescargarNuevos_Click"/>
                      <asp:Button runat="server"  ID="btnCerrar" Text="Cerrar" CssClass="btn btn-secondary" OnClick="btnCerrar_Click" CausesValidation="false"/>
                  </div>

               </div>
            </div>
    </asp:panel>

        </div>
</asp:Content>
