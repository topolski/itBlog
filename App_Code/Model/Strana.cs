using System;

namespace Model
{
    /// <summary>
    /// Summary description for Strana
    /// </summary>
    public class Strana
    {
        private int _idStrane;
        private string _Putanja;
        private string _ImeStrane;

        public string ImeStrane
        {
            get { return _ImeStrane; }
            set { _ImeStrane = value; }
        }
        
        public string Putanja
        {
            get { return _Putanja; }
            set { _Putanja = value; }
        }
        
        public int idStrane
        {
            get { return _idStrane; }
            set { _idStrane = value; }
        }       
    }
}