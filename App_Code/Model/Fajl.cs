using System;

namespace Model
{
    /// <summary>
    /// Summary description for Slika
    /// </summary>
    public class Fajl
    {
        private int _idFajla;
        private int _idPost;
        private string _Putanja;
        private string _OpisFajla;
        private DateTime _Datum;
        private string _Korisnik;

        public string Korisnik
        {
            get { return _Korisnik; }
            set { _Korisnik = value; }
        }

        public DateTime Datum
        {
            get { return _Datum; }
            set { _Datum = value; }
        }

        public string OpisFajla
        {
            get { return _OpisFajla; }
            set { _OpisFajla = value; }
        }

        public string Putanja
        {
            get { return _Putanja; }
            set { _Putanja = value; }
        }

        public int idPost
        {
            get { return _idPost; }
            set { _idPost = value; }
        }

        public int idFajla
        {
            get { return _idFajla; }
            set { _idFajla = value; }
        }
    }
}