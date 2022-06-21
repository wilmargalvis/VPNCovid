using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VPN.EntidadesNegocio
{
    public class clsBERegistroMiembros
    {
        public int MiembroId { get; set; }
        public int Celebracion { get; set; }
        public string Cedula { get; set; }
        public string Nombre { get; set; }
        public int Edad { get; set; }
        public Int64 Celular { get; set; }
        public string Correo { get; set; }
        //public int TipoMiembro { get; set; }
        public int SintomasCovid { get; set; }
        public string Temperatura { get; set; }
        public int Consentimiento { get; set; }
        public DateTime FechaActualizacion { get; set; }
        public int Estado { get; set; }
        public int Asientos { get; set; }
        public DateTime? FechaIngreso { get; set; }

    }
}
