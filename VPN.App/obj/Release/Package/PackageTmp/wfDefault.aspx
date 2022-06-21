<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Layout.Master" CodeBehind="wfDefault.aspx.cs" Inherits="VPN.App.wfDefault" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <script>
function colorChanged(sender) {
  sender.get_element().style.color = 
       "#" + sender.get_selectedColor();
}
    </script>
&nbsp;

   </asp:Content>
