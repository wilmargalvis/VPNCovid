using Microsoft.Practices.EnterpriseLibrary.Data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VPN.EntidadesNegocio;

namespace VPN.DatosNegocio
{
    public class clsDARegistroMiembros
    {

        //ExecuteNonQuery guardar o modificar
        //ExecuteScalar devolver string o entero
        //ExecuteDataSet devolver conjunto de datos

        private readonly Database _dbDB = new DatabaseProviderFactory().Create("Instancia ASIEL");

        public int Guardar(clsBERegistroMiembros objMiembros)
        { 
            System.Data.Common.DbCommand dbCommandConsulta = null;
            dbCommandConsulta = _dbDB.GetStoredProcCommand("spMiembros_Guardar");
            _dbDB.AddInParameter(dbCommandConsulta, "pMiembroID", DbType.Int64, objMiembros.MiembroId);
            _dbDB.AddInParameter(dbCommandConsulta, "pCedula", DbType.String, objMiembros.Cedula);
            _dbDB.AddInParameter(dbCommandConsulta, "pNombre", DbType.String, objMiembros.Nombre);
            _dbDB.AddInParameter(dbCommandConsulta, "pEdad", DbType.String, objMiembros.Edad);
            _dbDB.AddInParameter(dbCommandConsulta, "pCelular", DbType.String, objMiembros.Celular);
            _dbDB.AddInParameter(dbCommandConsulta, "pCorreo", DbType.String, objMiembros.Correo);
            _dbDB.AddInParameter(dbCommandConsulta, "pFechaActualizacion", DbType.Date, objMiembros.FechaActualizacion);
            _dbDB.AddInParameter(dbCommandConsulta, "pFechaIngreso", DbType.Date, objMiembros.FechaIngreso);
             string pMiembroID = _dbDB.ExecuteScalar(dbCommandConsulta).ToString();


            System.Data.Common.DbCommand dbCommandAsistencia_Duplicada = null;
            dbCommandAsistencia_Duplicada = _dbDB.GetStoredProcCommand("spAsistenciaxcelebracion_VerificarDuplicados");
            _dbDB.AddInParameter(dbCommandAsistencia_Duplicada, "pMiembroId", DbType.Int64, pMiembroID);
            _dbDB.AddInParameter(dbCommandAsistencia_Duplicada, "pCelebracionID", DbType.String, objMiembros.Celebracion);
            int VerificarAsistenciaDuplicada = (int)_dbDB.ExecuteScalar(dbCommandAsistencia_Duplicada);

            if (VerificarAsistenciaDuplicada == 0) // Si aún no se registra en la celebración
            {
                System.Data.Common.DbCommand dbCommandConsultaAsistencia = null;
                dbCommandConsultaAsistencia = _dbDB.GetStoredProcCommand("spAsistenciaCelebracion_Guardar");
                _dbDB.AddInParameter(dbCommandConsultaAsistencia, "pMiembroID", DbType.String, pMiembroID);
                _dbDB.AddInParameter(dbCommandConsultaAsistencia, "pCelebracionID", DbType.String, objMiembros.Celebracion);
                _dbDB.AddInParameter(dbCommandConsultaAsistencia, "pSintomasCovid", DbType.String, objMiembros.SintomasCovid);
                _dbDB.AddInParameter(dbCommandConsultaAsistencia, "pConsentimiento", DbType.String, objMiembros.Consentimiento);
                _dbDB.AddInParameter(dbCommandConsultaAsistencia, "pFechaRegistroCelebracion", DbType.Date, objMiembros.FechaActualizacion);
                _dbDB.ExecuteNonQuery(dbCommandConsultaAsistencia);

                System.Data.Common.DbCommand dbCommandActualizarAsientos = null;
                dbCommandActualizarAsientos = _dbDB.GetStoredProcCommand("spCelebraciones_ActualizarAsientos");
                _dbDB.AddInParameter(dbCommandActualizarAsientos, "pCelebracionID", DbType.String, objMiembros.Celebracion);
                _dbDB.AddInParameter(dbCommandActualizarAsientos, "pPersonas", DbType.String, objMiembros.Asientos);
                _dbDB.ExecuteNonQuery(dbCommandActualizarAsientos);
                return 0;
            }
            else {
                return 1;
            }

        }

        public DataTable objConsultarNuevos(DateTime fecha1, DateTime fecha2)
        {
            System.Data.Common.DbCommand dbCommandConsultaMiembrosNuevos = null;
            dbCommandConsultaMiembrosNuevos = _dbDB.GetStoredProcCommand("spAsistenciaCelebracionExportarNuevos");
            _dbDB.AddInParameter(dbCommandConsultaMiembrosNuevos, "pFecha1", DbType.Date, fecha1);
            _dbDB.AddInParameter(dbCommandConsultaMiembrosNuevos, "pFecha2", DbType.Date, fecha2);
            return _dbDB.ExecuteDataSet(dbCommandConsultaMiembrosNuevos).Tables[0];
        }

        public DataTable BuscarMiembro(Int64 pMiembroID)
        {
            System.Data.Common.DbCommand dbCommandConsultaAccesoMiembro = null;
            dbCommandConsultaAccesoMiembro = _dbDB.GetStoredProcCommand("spMiembros_Buscar");
            _dbDB.AddInParameter(dbCommandConsultaAccesoMiembro, "pCedula", DbType.Int64, pMiembroID);
            return _dbDB.ExecuteDataSet(dbCommandConsultaAccesoMiembro).Tables[0];

        }

        public int ConsultarDisponibilidadxCelebracionId(int pCelebracionId)
        {
            System.Data.Common.DbCommand dbCommandConsulta = null;
            dbCommandConsulta = _dbDB.GetStoredProcCommand("spCelebraciones_ConsultarDisponibilidad");
            _dbDB.AddInParameter(dbCommandConsulta, "pCelebracionId", DbType.Int64, pCelebracionId);
            return (int)_dbDB.ExecuteScalar(dbCommandConsulta);
        }

        public void GuardarTemperatura(string iDMiembro, string temperatura)
        {
            System.Data.Common.DbCommand dbCommandConsulta = null;
            dbCommandConsulta = _dbDB.GetStoredProcCommand("spAsistenciaxCelebracion_Actualizar");
            _dbDB.AddInParameter(dbCommandConsulta, "pAsistenciaxcelebracionID", DbType.String, iDMiembro);
            _dbDB.AddInParameter(dbCommandConsulta, "pTemperatura", DbType.String, temperatura);
            _dbDB.AddInParameter(dbCommandConsulta, "pFechaRegistroCelebracion", DbType.Date, System.DateTime.Today);

            _dbDB.ExecuteNonQuery(dbCommandConsulta);
        }

        public DataTable BuscarListadoAsistenciaCelebracion(string cedula, string nombre)
        {
            System.Data.Common.DbCommand dbCommandConsulta = null;
            dbCommandConsulta = _dbDB.GetStoredProcCommand("spAsistenciaCelebracion_ConsultarListado");
            _dbDB.AddInParameter(dbCommandConsulta, "pNombre", DbType.String, nombre);
            _dbDB.AddInParameter(dbCommandConsulta, "pCedula", DbType.String, cedula);

            return _dbDB.ExecuteDataSet(dbCommandConsulta).Tables[0];
        }

        public DataTable BuscarAsistenciaxFechas(DateTime fecha1, DateTime fecha2)
        {
            System.Data.Common.DbCommand dbCommandConsulta = null;
            dbCommandConsulta = _dbDB.GetStoredProcCommand("spAsistenciaCelebracion_Imprimir");
            _dbDB.AddInParameter(dbCommandConsulta, "pFecha1", DbType.Date, fecha1);
            _dbDB.AddInParameter(dbCommandConsulta, "pFecha2", DbType.Date, fecha2);

            return _dbDB.ExecuteDataSet(dbCommandConsulta).Tables[0];
        }

        public DataTable Consultar()
        {
            System.Data.Common.DbCommand dbCommandConsulta = null;
            dbCommandConsulta = _dbDB.GetStoredProcCommand("spMiembros_Consultar");
            
            return _dbDB.ExecuteDataSet(dbCommandConsulta).Tables[0];
        }

        public DataTable LlenarMaestro()
        {
            System.Data.Common.DbCommand dbCommandConsulta = null;
            dbCommandConsulta = _dbDB.GetStoredProcCommand("spCelebraciones_LlenarMaestro");

            return _dbDB.ExecuteDataSet(dbCommandConsulta).Tables[0];
        }

    }
}
