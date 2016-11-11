using System;

namespace Model
{
    /// <summary>
    /// Summary description for Komentar
    /// </summary>
    public class Komentar
    {
        private int _idKomentara;
        private string _Koment;
        private int _idPost;
        private string _AutorKomentara;
        private DateTime _Datum;
        private string _Email;
        private string _WebSite;
        private string _imeZaSliku;
        private string _Putanja;
        private string _Naslov;

        public string Naslov
        {
            get { return _Naslov; }
            set { _Naslov = value; }
        }
        
        public string Putanja
        {
            get { return _Putanja; }
            set { _Putanja = value; }
        }
        
        public string imeZaSliku
        {
            get { return _imeZaSliku; }
            set { _imeZaSliku = value; }
        }
            
        public string WebSite
        {
            get { return _WebSite; }
            set { _WebSite = value; }
        }
        
        public string Email
        {
            get { return _Email; }
            set { _Email = value; }
        }
        
        public DateTime Datum
        {
            get { return _Datum; }
            set { _Datum = value; }
        }
        
        public string AutorKomentara
        {
            get { return _AutorKomentara; }
            set { _AutorKomentara = value; }
        }
        
        public int idPost
        {
            get { return _idPost; }
            set { _idPost = value; }
        }
        
        public string Koment
        {
            get { return _Koment; }
            set { _Koment = value; }
        }
        
        public int idKomentara
        {
            get { return _idKomentara; }
            set { _idKomentara = value; }
        }
        
    }
}