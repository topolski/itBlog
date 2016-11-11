using System;

namespace Model
{
    /// <summary>
    /// Summary description for Post
    /// </summary>
    public class Post
    {
        private int _idPost;
        private string _OpisPosta;
        private string _Naslov;
        private string _Slika;
        private string _OpisSlike;
        private int _idAutor;
        private DateTime _Datum;
        private string _KorisničkoIme;
        private string _SlikaAutora;
        private string _TekstOAutoru;
        private string _WebSite;
        private string _LinkedIn;
        private string _Facebook;
        private string _Twitter;
        private string _Podnaslov;
        private string _Tekst;

        public string Teskt
        {
            get { return _Tekst; }
            set { _Tekst = value; }
        }
        

        public string Podnaslov
        {
            get { return _Podnaslov; }
            set { _Podnaslov = value; }
        }
        

        public string Twitter
        {
            get { return _Twitter; }
            set { _Twitter = value; }
        }
        

        public string Facebook
        {
            get { return _Facebook; }
            set { _Facebook = value; }
        }
        

        public string LinkedIn
        {
            get { return _LinkedIn; }
            set { _LinkedIn = value; }
        }
        

        public string WebSite
        {
            get { return _WebSite; }
            set { _WebSite = value; }
        }
        

        public string TekstOAutoru
        {
            get { return _TekstOAutoru; }
            set { _TekstOAutoru = value; }
        }
        

        public string SlikaAutora
        {
            get { return _SlikaAutora; }
            set { _SlikaAutora = value; }
        }
        

        public string KorisničkoIme
        {
            get { return _KorisničkoIme; }
            set { _KorisničkoIme = value; }
        }
        
        public int idPost
        {
            get { return _idPost; }
            set { _idPost = value; }
        }

        public string Naslov
        {
            get { return _Naslov; }
            set { _Naslov = value; }
        }

        public string Slika
        {
            get { return _Slika; }
            set { _Slika = value; }
        }

        public string OpisSlike
        {
            get { return _OpisSlike; }
            set { _OpisSlike = value; }
        }

        public int idAutor
        {
            get { return _idAutor; }
            set { _idAutor = value; }
        }

        public DateTime Datum
        {
            get { return _Datum; }
            set { _Datum = value; }
        }

        public string OpisPosta
        {
            get { return _OpisPosta; }
            set { _OpisPosta = value; }
        }
    }
}