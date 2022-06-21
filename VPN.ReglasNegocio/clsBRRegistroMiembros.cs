using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VPN.EntidadesNegocio;
using VPN.DatosNegocio;
using System.Data;

namespace VPN.ReglasNegocio
{
    public class clsBRRegistroMiembros
    {

        private readonly clsDARegistroMiembros clsDARegistroMiembros = new clsDARegistroMiembros();
        public int Guardar(clsBERegistroMiembros objMiembros)
        {
            return clsDARegistroMiembros.Guardar(objMiembros);
        }

        public DataTable Consultar()
        {
          return  clsDARegistroMiembros.Consultar();
        }

        public DataTable BuscarListadoAsistenciaCelebracion(string cedula, string nombre)
        {
            return clsDARegistroMiembros.BuscarListadoAsistenciaCelebracion(cedula, nombre);
        }

        public DataTable BuscarAsistenciaxFechas(DateTime fecha1, DateTime fecha2)
        {
            return clsDARegistroMiembros.BuscarAsistenciaxFechas(fecha1, fecha2);
        }

        public DataTable BuscarMiembro(Int64 Cedula)
        {
            return clsDARegistroMiembros.BuscarMiembro(Cedula);   
        }

        public DataTable LlenarMaestro()
        {
            return clsDARegistroMiembros.LlenarMaestro();
        }

        public int ConsultarDisponibilidadxCelebracionId(int pCelebracionId)
        {
            return clsDARegistroMiembros.ConsultarDisponibilidadxCelebracionId(pCelebracionId);
        }

        public void GuadarTemperatura(string iDMiembro, string Temperatura)
        {
            clsDARegistroMiembros.GuardarTemperatura(iDMiembro,Temperatura);
        }

        public DataTable objConsultarNuevos(DateTime fecha1, DateTime fecha2)
        {
            return clsDARegistroMiembros.objConsultarNuevos(fecha1,fecha2);
        }
    }
}
