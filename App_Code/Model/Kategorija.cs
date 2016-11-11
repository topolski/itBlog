using System;

namespace Model
{
    /// <summary>
    /// Summary description for Kategorija
    /// </summary>
    public class Kategorija
    {
        private int _idKategorija;
        private string _Naziv;

        public string Naziv
        {
            get { return _Naziv; }
            set { _Naziv = value; }
        }
        
        public int idKategorija
        {
            get { return _idKategorija; }
            set { _idKategorija = value; }
        }       
    }
}