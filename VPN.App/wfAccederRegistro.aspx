<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="wfAccederRegistro.aspx.cs" Inherits="VPN.App.wfAccederRegistro" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
<%--    <script src="js/jquery-1.9.1.min.js"></script>
    <script src="js/html5-qrcode.min.js"></script>--%>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>

    <div class="container border border-info" style="margin-top: 40px;">
        <div class="form-group row">
            <div class="col-sm-8 mt-4">
                <!--mt-3 = Margin Top-->
                <h4 style="text-align: right">Buscar mis datos y registrarme</h4>
            </div>
            <div class="col-sm-3" style="text-align: right">

                <asp:Timer ID="Timer2" runat="server" Interval="1000" OnTick="Timer2_Tick" Enabled="false"></asp:Timer>

                <img src="https://vidaparalasnaciones.com/wp-content/uploads/2020/06/cropped-Logo.jpg" />

            </div>
        </div>
        <br>

        <%--        <div class="text-right p-4" style="color: blue; font-size: 17px">
            <asp:linkbutton id="lblbuscarMiembro" OnClick="linkBuscarMiembro_Click" runat="server">Ir a registro de miembros</asp:linkbutton>
        </div>--%>

        <div class="form-group row">
            <div class="col-sm-6" style="text-align: right">
                <label for="nombre">Ingrese la cédula a buscar<span id="cedulaspan" style="color: red; font-size: 14px"> *</span></label>
            </div>
            <div class="col-sm-2" style="text-align: left">
                <asp:TextBox runat="server" class="form-control" placeholder="Cédula" ID="txtCedula" MaxLength="10"> </asp:TextBox>
                <asp:RequiredFieldValidator ID="rqvbuscarMiembro" ForeColor="Red" ErrorMessage="Texto Requerido" ControlToValidate="txtCedula" runat="server" />
            </div>
            <div class="col-sm-4" style="text-align: left">
                <asp:Button runat="server" ID="btnBuscarMiembro" CssClass="btn btn-primary" OnClick="btnBuscarMiembro_Click" Text="Buscar" CausesValidation="true" />
            </div>
        </div>

   </div>


   <div class="container border border-info p-3" style="margin-top: 40px;">

       <div class="form-group row">
           <div class="col-sm-12 m-3">
               <h4 style="text-align: center">Generador y lector de QR</h4>
           </div>
       </div>

        <div class="form-group row">
            <div class="col-sm-4" style="text-align: right">
                <label for="Name" id="lblDatosQR">Ingrese la URL</label>
            </div>

            <div class="col-sm-4" style="text-align: left">
                <asp:TextBox runat="server" Cssclass="form-control" placeholder="URL" ID="txtUrlQR"> </asp:TextBox>
            </div>

            <div class="col-sm-4">
                <asp:Button runat ="server" ID="btnGenerarQR" CssClass="btn btn-primary" OnClick="btnGenerarQR_Click" Text="Generar QR" CausesValidation="false" />
            </div>
        </div>

        <div class="form-group row">
            <div class="col-sm-12" style="text-align: center">
                <img runat="server" id="ImgCtrl" />
            </div>
        </div>

        <div class="form-group row">
           <div class="col-sm-12" style="text-align: center">
                <asp:Label Text="" ID="lblQR" runat="server" />
            </div>
        </div>

    <div class="form-group row p-3">

        <div class="col-sm-6" style="text-align: right">
            <label for="camara">Cámaras identificadas <span id="camaraspan" style="color: red; font-size: 14px">*</span></label>
        </div>
        <div class="col-sm-6">
            <asp:DropDownList runat="server" ID="ddlCamaras" CssClass="form-control" AutoPostBack="True">
            </asp:DropDownList>

            <%--<asp:RequiredFieldValidator runat="server" ID="rqvCelebracion" ControlToValidate="ddlCelebracion" InitialValue="0" ForeColor="Red" ErrorMessage="Falta seleccionar la celebración"></asp:RequiredFieldValidator>--%>
        </div>
    </div>

    <div class="form-group row">
        <div class="col-sm-6" style="text-align: right">
            <asp:Button runat="server" ID="btnIniciarEscaneoQR" CssClass="btn btn-primary" OnClick="btnIniciarEscaneoQR_Click" Text="Iniciar Escaneo QR" CausesValidation="false" />
        </div>
        <div class="col-sm-6" style="text-align: left">
            <asp:Button runat="server" ID="btnPararCamara" CssClass="btn btn-primary" OnClick="btnPararCamara_Click" Text="Parar Escaneo QR" CausesValidation="false" />
        </div>
    </div>

    <div class="form-group row">
        <div class="col-sm-12" style="text-align: right">
            <img runat="server" id="imgCamara" />
        </div>
        <asp:Timer ID="timer1" runat="server" Interval="1000" Enabled="False" />
    </div>

       <div class="form-group row" style="text-align: center;">
           <div class="col-sm-12">
                <video id="preview" style="text-align: center; width: 600px; height: 600px; margin: 5px;"></video>
           </div>
       </div>

    <div class="container" style="margin-top: 40px; text-align:center">
        <div class="form-group row" style="align-content: center">
            <div class="col-sm-12 btn btn-primary" style="text-align: right">
                <asp:TextBox runat="server" CssClass="form-control" placeholder="QR Pendiente por leer" ID="txtRecuperarQR" Style="text-align: center; color: red; font-size: 17px"> </asp:TextBox>
            </div>
        </div>
    </div>

  </div>



<script src="https://rawgit.com/schmich/instascan-builds/master/instascan.min.js"></script>
<script type="text/javascript">

    var scanner = new Instascan.Scanner({
        video: document.getElementById('preview'),
        scanPeriod: 5,
        mirror: false
    });

    function IniciarQR() {
        Instascan.Camera.getCameras().then(function (cameras) {
            console.log(cameras);
            if (cameras.length > 0) {
                scanner.start(cameras[0]);
                $('[name="options"]').on('change', function () {
                    if ($(this).val() == 1) {
                        if (cameras[0] != "") {
                            scanner.start(cameras[0]);
                        } else {
                            alert('No Front camera found!');
                        }
                    } else if ($(this).val() == 2) {
                        if (cameras[1] != "") {
                            scanner.start(cameras[1]);
                        } else {
                            alert('No Back camera found!');
                        }
                    }
                });
            } else {
                console.error('No cameras found.');
                alert('No cameras found.');
            }
        }).catch(function (e) {
            //console.error(e);
            // alert(e);
        });

        scanner.addListener('scan', function (content) {
            //console.log(content + " ENLACE");
            $('#<%=txtRecuperarQR.ClientID%>').val(content);
            //alert(content);
            //window.open(content);
            //window.location.href=content;
        });

        function PararQR() {
            scanner.start = false;
        }

    }
</script>


   <%-- <div id="reader" style="width:300px; height:250px">testttt</div>--%>
    <%--<asp:Panel ID="reader" CssClass="img-fluid img-thumbnail" runat="server" style="width:300px; height:250px"></asp:Panel>--%>
<%--    <asp:Image ID="reader" CssClass="img-fluid img-thumbnail" runat="server" style="width:300px; height:250px" />--%>
<%--        <p>
            Datos del Código QR:
            <asp:TextBox ID="txtCodigo" runat="server" Width="371px"></asp:TextBox>
        </p>
        <br />--%>


<%--    <script>
            $(document).ready(function () {
                $('#reader').html5_qrcode(function (data) {
                    $('#<%=txtUrlQR.ClientID%>').val(data);
            },
                    function (error) {
                        alert("error1");
                }, function (videoError) {
                    alert("No hay cámara. Error 2");
                }
            );
        });
    </script>--%>

<%--    <div class="btn-group btn-group-toggle mb-5" data-toggle="buttons" style="text-align: center;">
        <label class="btn btn-primary active">
          <input type="radio" name="options" value="1" autocomplete="off" checked> Front Camera
        </label>
        <label class="btn btn-secondary">
          <input type="radio" name="options" value="2" autocomplete="off"> Back Camera
        </label>
    </div>--%>

</asp:Content>


