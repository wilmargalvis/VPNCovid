//------------------------------------------------------------------------------
// <auto-generated>
//     Este código fue generado por una herramienta.
//     Versión de runtime:4.0.30319.42000
//
//     Los cambios en este archivo podrían causar un comportamiento incorrecto y se perderán si
//     se vuelve a generar el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace VPN.App.ServiceReference1 {
    using System.Runtime.Serialization;
    using System;
    
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Runtime.Serialization", "4.0.0.0")]
    [System.Runtime.Serialization.DataContractAttribute(Name="Persona", Namespace="http://schemas.datacontract.org/2004/07/LRP.CapacitacionServiciosWCF")]
    [System.SerializableAttribute()]
    public partial class Persona : object, System.Runtime.Serialization.IExtensibleDataObject, System.ComponentModel.INotifyPropertyChanged {
        
        [System.NonSerializedAttribute()]
        private System.Runtime.Serialization.ExtensionDataObject extensionDataField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string ApellidoField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string NombreField;
        
        [global::System.ComponentModel.BrowsableAttribute(false)]
        public System.Runtime.Serialization.ExtensionDataObject ExtensionData {
            get {
                return this.extensionDataField;
            }
            set {
                this.extensionDataField = value;
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string Apellido {
            get {
                return this.ApellidoField;
            }
            set {
                if ((object.ReferenceEquals(this.ApellidoField, value) != true)) {
                    this.ApellidoField = value;
                    this.RaisePropertyChanged("Apellido");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string Nombre {
            get {
                return this.NombreField;
            }
            set {
                if ((object.ReferenceEquals(this.NombreField, value) != true)) {
                    this.NombreField = value;
                    this.RaisePropertyChanged("Nombre");
                }
            }
        }
        
        public event System.ComponentModel.PropertyChangedEventHandler PropertyChanged;
        
        protected void RaisePropertyChanged(string propertyName) {
            System.ComponentModel.PropertyChangedEventHandler propertyChanged = this.PropertyChanged;
            if ((propertyChanged != null)) {
                propertyChanged(this, new System.ComponentModel.PropertyChangedEventArgs(propertyName));
            }
        }
    }
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ServiceModel.ServiceContractAttribute(ConfigurationName="ServiceReference1.IServiceTest")]
    public interface IServiceTest {
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IServiceTest/GetData", ReplyAction="http://tempuri.org/IServiceTest/GetDataResponse")]
        string GetData(int value);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IServiceTest/GetData", ReplyAction="http://tempuri.org/IServiceTest/GetDataResponse")]
        System.Threading.Tasks.Task<string> GetDataAsync(int value);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IServiceTest/testRetunString", ReplyAction="http://tempuri.org/IServiceTest/testRetunStringResponse")]
        string testRetunString(string param1, string param2);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IServiceTest/testRetunString", ReplyAction="http://tempuri.org/IServiceTest/testRetunStringResponse")]
        System.Threading.Tasks.Task<string> testRetunStringAsync(string param1, string param2);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IServiceTest/testObject", ReplyAction="http://tempuri.org/IServiceTest/testObjectResponse")]
        string testObject(VPN.App.ServiceReference1.Persona persona);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IServiceTest/testObject", ReplyAction="http://tempuri.org/IServiceTest/testObjectResponse")]
        System.Threading.Tasks.Task<string> testObjectAsync(VPN.App.ServiceReference1.Persona persona);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IServiceTest/testReturnInt", ReplyAction="http://tempuri.org/IServiceTest/testReturnIntResponse")]
        int testReturnInt(int valor, int valor2);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IServiceTest/testReturnInt", ReplyAction="http://tempuri.org/IServiceTest/testReturnIntResponse")]
        System.Threading.Tasks.Task<int> testReturnIntAsync(int valor, int valor2);
    }
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public interface IServiceTestChannel : VPN.App.ServiceReference1.IServiceTest, System.ServiceModel.IClientChannel {
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public partial class ServiceTestClient : System.ServiceModel.ClientBase<VPN.App.ServiceReference1.IServiceTest>, VPN.App.ServiceReference1.IServiceTest {
        
        public ServiceTestClient() {
        }
        
        public ServiceTestClient(string endpointConfigurationName) : 
                base(endpointConfigurationName) {
        }
        
        public ServiceTestClient(string endpointConfigurationName, string remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public ServiceTestClient(string endpointConfigurationName, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public ServiceTestClient(System.ServiceModel.Channels.Binding binding, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(binding, remoteAddress) {
        }
        
        public string GetData(int value) {
            return base.Channel.GetData(value);
        }
        
        public System.Threading.Tasks.Task<string> GetDataAsync(int value) {
            return base.Channel.GetDataAsync(value);
        }
        
        public string testRetunString(string param1, string param2) {
            return base.Channel.testRetunString(param1, param2);
        }
        
        public System.Threading.Tasks.Task<string> testRetunStringAsync(string param1, string param2) {
            return base.Channel.testRetunStringAsync(param1, param2);
        }
        
        public string testObject(VPN.App.ServiceReference1.Persona persona) {
            return base.Channel.testObject(persona);
        }
        
        public System.Threading.Tasks.Task<string> testObjectAsync(VPN.App.ServiceReference1.Persona persona) {
            return base.Channel.testObjectAsync(persona);
        }
        
        public int testReturnInt(int valor, int valor2) {
            return base.Channel.testReturnInt(valor, valor2);
        }
        
        public System.Threading.Tasks.Task<int> testReturnIntAsync(int valor, int valor2) {
            return base.Channel.testReturnIntAsync(valor, valor2);
        }
    }
}
