using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace Data
{
    /// <summary>
    /// Summary description for DAL
    /// </summary>
    public class DAL
    {
        public static List<Model.Post> getPosts()
        {
            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection conn = null;
            SqlDataReader reader = null;
            try
            {
                conn = new SqlConnection(cs);
                SqlCommand com = new SqlCommand("IndexPostovi", conn);
                com.CommandType = CommandType.StoredProcedure;
                conn.Open();
                reader = com.ExecuteReader();
                List<Model.Post> postovi = new List<Model.Post>();
                while (reader.Read())
                {
                    Model.Post post = new Model.Post();
                    post.idPost = Int32.Parse(reader["idPost"].ToString());
                    post.Naslov = reader["Naslov"].ToString();
                    post.Slika = reader["Slika"].ToString();
                    post.OpisSlike = reader["OpisSlike"].ToString();
                    post.idAutor = Int32.Parse(reader["idAutor"].ToString());
                    post.Datum = DateTime.Parse(reader["Datum"].ToString());
                    post.OpisPosta = reader["OpisPosta"].ToString();
                    post.KorisničkoIme = reader["KorisničkoIme"].ToString();
                    postovi.Add(post);
                }
                return postovi;
            }
            catch (Exception exp)
            {
                HttpContext.Current.Trace.Warn("Greška", "Greška getPosts()", exp);
            }
            finally
            {
                if (reader != null) reader.Close();
                if (conn != null && conn.State != ConnectionState.Closed) conn.Close();
            }
            return null;
        }

        public static List<string> getBrKomentara()
        {
            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection conn = null;
            SqlDataReader reader = null;
            try
            {
                conn = new SqlConnection(cs);
                SqlCommand com = new SqlCommand("IndexBrojKomentara", conn);
                com.CommandType = CommandType.StoredProcedure;
                conn.Open();
                reader = com.ExecuteReader();
                List<string> brk = new List<string>();
                int i = 0;
                while (reader.Read())
                {
                    string br = reader["BrK"].ToString();
                    brk.Add(br);
                    i++;
                }
                return brk;
            }
            catch (Exception exp)
            {
                HttpContext.Current.Trace.Warn("Greška", "Greška getBrKomentara()", exp);
            }
            finally
            {
                if (reader != null) reader.Close();
                if (conn != null && conn.State != ConnectionState.Closed) conn.Close();
            }
            return null;
        }

        public static string getBrKomentara(string idPost)
        {
            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection conn = null;
            SqlDataReader reader = null;
            try
            {
                conn = new SqlConnection(cs);
                SqlCommand com = new SqlCommand("DetaljnijeBrojKomentara", conn);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@idPost", idPost);
                conn.Open();
                reader = com.ExecuteReader();
                string br = "";
                while (reader.Read())
                {
                    br = reader["BrK"].ToString();
                }
                return br;
            }
            catch (Exception exp)
            {
                HttpContext.Current.Trace.Warn("Greška", "Greška getBrKomentara(string idPost)", exp);
            }
            finally
            {
                if (reader != null) reader.Close();
                if (conn != null && conn.State != ConnectionState.Closed) conn.Close();
            }
            return null;
        }

        public static List<Model.Post> getPost(string idPost)
        {
            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection conn = null;
            SqlDataReader reader = null;
            try
            {
                conn = new SqlConnection(cs);
                SqlCommand com = new SqlCommand("DetaljnijePost", conn);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@idPost", idPost);
                conn.Open();
                reader = com.ExecuteReader();
                List<Model.Post> postovi = new List<Model.Post>();
                while (reader.Read())
                {
                    Model.Post post = new Model.Post();
                    post.Naslov = reader["Naslov"].ToString();                                        
                    post.idAutor = Int32.Parse(reader["idAutor"].ToString());
                    post.Datum = DateTime.Parse(reader["Datum"].ToString());                   
                    post.KorisničkoIme = reader["KorisničkoIme"].ToString();
                    post.SlikaAutora = reader["SlikaAutora"].ToString();
                    post.TekstOAutoru = reader["TekstOAutoru"].ToString();
                    post.WebSite = reader["WebSite"].ToString();
                    post.LinkedIn = reader["LinkedIn"].ToString();
                    post.Facebook = reader["Facebook"].ToString();
                    post.Twitter = reader["Twitter"].ToString();
                    post.Podnaslov = reader["Podnaslov"].ToString();
                    post.Teskt = reader["Tekst"].ToString();
                    postovi.Add(post);
                }
                return postovi;
            }
            catch (Exception exp)
            {
                HttpContext.Current.Trace.Warn("Greška", "Greška getPost(string idPost)", exp);
            }
            finally
            {
                if (reader != null) reader.Close();
                if (conn != null && conn.State != ConnectionState.Closed) conn.Close();
            }
            return null;
        }

        public static List<Model.Fajl> getSlike(string idPost)
        {
            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection conn = null;
            SqlDataReader reader = null;
            try
            {
                conn = new SqlConnection(cs);
                SqlCommand com = new SqlCommand("DetaljnijeSlike", conn);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@idPost", idPost);
                conn.Open();
                reader = com.ExecuteReader();
                List<Model.Fajl> slike = new List<Model.Fajl>();
                while (reader.Read())
                {
                    Model.Fajl slika = new Model.Fajl();
                    slika.Datum = DateTime.Parse(reader["Datum"].ToString());
                    slika.Putanja = reader["Putanja"].ToString();
                    slika.OpisFajla = reader["OpisFajla"].ToString();
                    slike.Add(slika);
                }
                return slike;
            }
            catch (Exception exp)
            {
                HttpContext.Current.Trace.Warn("Greška", "Greška getSlike(string idPost)", exp);
            }
            finally
            {
                if (reader != null) reader.Close();
                if (conn != null && conn.State != ConnectionState.Closed) conn.Close();
            }
            return null;
        }

        public static List<Model.Komentar> getKomentare(string idPost)
        {
            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection conn = null;
            SqlDataReader reader = null;
            try
            {
                conn = new SqlConnection(cs);
                SqlCommand com = new SqlCommand("DetaljnijeKomentari", conn);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@idPost", idPost);
                conn.Open();
                reader = com.ExecuteReader();
                List<Model.Komentar> komentari = new List<Model.Komentar>();
                while (reader.Read())
                {
                    Model.Komentar kom = new Model.Komentar();
                    kom.Datum = DateTime.Parse(reader["DatumKom"].ToString());
                    kom.idKomentara = Int32.Parse(reader["idKomentar"].ToString());
                    kom.Koment = reader["Komentar"].ToString();
                    kom.idPost = Int32.Parse(reader["idPost"].ToString());
                    kom.AutorKomentara = reader["AutorKomentara"].ToString();
                    kom.Email = reader["Email"].ToString();
                    kom.WebSite = reader["WebSite"].ToString();
                    kom.imeZaSliku = reader["imeZaSliku"].ToString();
                    kom.Putanja = reader["Putanja"].ToString();
                    komentari.Add(kom);
                }
                return komentari;
            }
            catch (Exception exp)
            {
                HttpContext.Current.Trace.Warn("Greška", "Greška getKomentare(string idPost)", exp);
            }
            finally
            {
                if (reader != null) reader.Close();
                if (conn != null && conn.State != ConnectionState.Closed) conn.Close();
            }
            return null;
        }

        public static List<string> getKorisnikeSaSlikom()
        {
            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection conn = null;
            SqlDataReader reader = null;
            try
            {
                conn = new SqlConnection(cs);
                SqlCommand com = new SqlCommand("DetaljnijeKorisnik", conn);
                com.CommandType = CommandType.StoredProcedure;
                conn.Open();
                reader = com.ExecuteReader();
                List<string> korSaSl = new List<string>();
                int i = 0;
                while (reader.Read())
                {
                    string kor = reader["Korisnik"].ToString();
                    korSaSl.Add(kor);
                    i++;
                }
                return korSaSl;
            }
            catch (Exception exp)
            {
                HttpContext.Current.Trace.Warn("Greška", "Greška getKorisnikeSaSlikom()", exp);
            }
            finally
            {
                if (reader != null) reader.Close();
                if (conn != null && conn.State != ConnectionState.Closed) conn.Close();
            }
            return null;
        }

        public static void ubaciKomentar(string ime, string email, string site, string komentar, string id, string imeZaSliku)
        {
            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection conn = null;
            SqlDataReader reader = null;
            try
            {
                conn = new SqlConnection(cs);
                SqlCommand com = new SqlCommand("DetaljnijeInsertKomentar", conn);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("Komentar", komentar);
                com.Parameters.AddWithValue("idPost", id);
                com.Parameters.AddWithValue("AutorKomentara", ime);
                com.Parameters.AddWithValue("Datum", DateTime.Now);
                com.Parameters.AddWithValue("Email", email);
                com.Parameters.AddWithValue("WebSite", site);
                com.Parameters.AddWithValue("imeZaSliku", imeZaSliku);
                conn.Open();
                com.ExecuteNonQuery();
            }
            catch (Exception exp)
            {
                HttpContext.Current.Trace.Warn("Greška", "Greška ubaciKomentar(string ime, string email, string site, string komentar, string id, string imeZaSliku)", exp);
            }
            finally
            {
                if (reader != null) reader.Close();
                if (conn != null && conn.State != ConnectionState.Closed) conn.Close();
            }
        }

        public static List<Model.Strana> getStrane(string idUloga)
        {
            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection conn = null;
            SqlDataReader reader = null;
            try
            {
                conn = new SqlConnection(cs);
                SqlCommand com = new SqlCommand("MasterGlavniMeni", conn);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@idUloga", idUloga);
                conn.Open();
                reader = com.ExecuteReader();
                List<Model.Strana> strane = new List<Model.Strana>();
                while (reader.Read())
                {
                    Model.Strana str = new Model.Strana();
                    str.ImeStrane = reader["ImeStrane"].ToString();
                    str.Putanja = reader["Putanja"].ToString();
                    strane.Add(str);
                }
                return strane;
            }
            catch (Exception exp)
            {
                HttpContext.Current.Trace.Warn("Greška", "Greška getStrane(string idUloga)", exp);
            }
            finally
            {
                if (reader != null) reader.Close();
                if (conn != null && conn.State != ConnectionState.Closed) conn.Close();
            }
            return null;
        }

        public static List<Model.Kategorija> getKategorije()
        {
            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection conn = null;
            SqlDataReader reader = null;
            try
            {
                conn = new SqlConnection(cs);
                SqlCommand com = new SqlCommand("MasterKategorije", conn);
                com.CommandType = CommandType.StoredProcedure;              
                conn.Open();
                reader = com.ExecuteReader();
                List<Model.Kategorija> kategorije = new List<Model.Kategorija>();
                while (reader.Read())
                {
                    Model.Kategorija kat = new Model.Kategorija();
                    kat.idKategorija = Int32.Parse(reader["idKategorija"].ToString());
                    kat.Naziv = reader["Naziv"].ToString();
                    kategorije.Add(kat);
                }
                return kategorije;
            }
            catch (Exception exp)
            {
                HttpContext.Current.Trace.Warn("Greška", "Greška getKategorije()", exp);
            }
            finally
            {
                if (reader != null) reader.Close();
                if (conn != null && conn.State != ConnectionState.Closed) conn.Close();
            }
            return null;
        }

        public static List<Model.Komentar> getPoslednjih5Komentara()
        {
            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection conn = null;
            SqlDataReader reader = null;
            try
            {
                conn = new SqlConnection(cs);
                SqlCommand com = new SqlCommand("MasterKomentariSaStrane", conn);
                com.CommandType = CommandType.StoredProcedure;              
                conn.Open();
                reader = com.ExecuteReader();
                List<Model.Komentar> komentari = new List<Model.Komentar>();
                while (reader.Read())
                {
                    Model.Komentar kom = new Model.Komentar();
                    kom.idPost = Int32.Parse(reader["idPost"].ToString());
                    kom.AutorKomentara = reader["AutorKomentara"].ToString();
                    kom.WebSite = reader["WebSite"].ToString();
                    kom.Naslov = reader["Naslov"].ToString();
                    komentari.Add(kom);
                }
                return komentari;
            }
            catch (Exception exp)
            {
                HttpContext.Current.Trace.Warn("Greška", "Greška getPoslednjih5Komentara()", exp);
            }
            finally
            {
                if (reader != null) reader.Close();
                if (conn != null && conn.State != ConnectionState.Closed) conn.Close();
            }
            return null;
        }

        public static List<Model.Post> getPosts(string upit, string parametar)
        {
            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection conn = null;
            SqlDataReader reader = null;
            try
            {
                conn = new SqlConnection(cs);
                SqlCommand com = new SqlCommand(upit, conn);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@kr", parametar);
                conn.Open();
                reader = com.ExecuteReader();
                List<Model.Post> postovi = new List<Model.Post>();
                while (reader.Read())
                {
                    Model.Post post = new Model.Post();
                    post.idPost = Int32.Parse(reader["idPost"].ToString());
                    post.Naslov = reader["Naslov"].ToString();
                    post.Slika = reader["Slika"].ToString();
                    post.OpisSlike = reader["OpisSlike"].ToString();
                    post.idAutor = Int32.Parse(reader["idAutor"].ToString());
                    post.Datum = DateTime.Parse(reader["Datum"].ToString());
                    post.OpisPosta = reader["OpisPosta"].ToString();
                    post.KorisničkoIme = reader["KorisničkoIme"].ToString();
                    postovi.Add(post);
                }
                return postovi;
            }
            catch (Exception exp)
            {
                HttpContext.Current.Trace.Warn("Greška", "Greška getPosts(string upit, string parametar)", exp);
            }
            finally
            {
                if (reader != null) reader.Close();
                if (conn != null && conn.State != ConnectionState.Closed) conn.Close();
            }
            return null;
        }

        public static Model.Fajl getSlikaMojNalog(string korisnik)
        {
            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection conn = null;
            SqlDataReader reader = null;
            try
            {
                conn = new SqlConnection(cs);
                SqlCommand com = new SqlCommand("MojNalog", conn);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@UserName", korisnik);
                conn.Open();
                reader = com.ExecuteReader();
                Model.Fajl slika = new Model.Fajl();
                reader.Read();
                slika.Putanja = reader["Putanja"].ToString();
                return slika;
            }
            catch (Exception exp)
            {
                HttpContext.Current.Trace.Warn("Greška", "Greška getSlikaMojNalog(string korisnik)", exp);
            }
            finally
            {
                if (reader != null) reader.Close();
                if (conn != null && conn.State != ConnectionState.Closed) conn.Close();
            }
            return null;
        }

        public static int upisSlikeKorisnika(string user, string relativnaPutanja, string ekstenzija) 
        {
            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection conn = null;
            SqlDataReader reader = null;
            try
            {
                conn = new SqlConnection(cs);
                SqlCommand com = new SqlCommand("MojNalogInsert", conn);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@putanja", relativnaPutanja + user + ekstenzija);
                com.Parameters.AddWithValue("@opisfajla", "Slika korisnika");
                com.Parameters.AddWithValue("@datum", DateTime.Now);
                com.Parameters.AddWithValue("@korisnik", user);
                conn.Open();
                return com.ExecuteNonQuery();
            }
            catch (Exception exp)
            {
                HttpContext.Current.Trace.Warn("Greška", "Greška upisSlikeKorisnika(string user, string relativnaPutanja, string ekstenzija)", exp);
            }
            finally
            {
                if (reader != null) reader.Close();
                if (conn != null && conn.State != ConnectionState.Closed) conn.Close();
            }
            return 0;
        }

        public static int upisSlikeZaPost(string user, string relativnaPutanja, int idPost, string ime)
        {
            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection conn = null;
            SqlDataReader reader = null;
            try
            {
                conn = new SqlConnection(cs);
                SqlCommand com = new SqlCommand("AdminUpisFajlova", conn);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@idPost", idPost);
                com.Parameters.AddWithValue("@putanja", relativnaPutanja + ime);
                com.Parameters.AddWithValue("@opisfajla", "Slika za post");
                com.Parameters.AddWithValue("@datum", DateTime.Now);
                com.Parameters.AddWithValue("@korisnik", user);
                conn.Open();
                return com.ExecuteNonQuery();
            }
            catch (Exception exp)
            {
                HttpContext.Current.Trace.Warn("Greška", "Greška upisSlikeZaPost(string user, string relativnaPutanja, string ekstenzija, int idPost, string ime)", exp);
            }
            finally
            {
                if (reader != null) reader.Close();
                if (conn != null && conn.State != ConnectionState.Closed) conn.Close();
            }
            return 0;
        }

        public static Model.Post getPostAutor(string ime)
        {
            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection conn = null;
            SqlDataReader reader = null;
            try
            {
                conn = new SqlConnection(cs);
                SqlCommand com = new SqlCommand("AutorPostovi", conn);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@ime", ime);
                conn.Open();
                reader = com.ExecuteReader();
                reader.Read();
                Model.Post post = new Model.Post();
                post.idAutor = Int32.Parse(reader["idAutor"].ToString());
                return post;
            }
            catch (Exception exp)
            {
                HttpContext.Current.Trace.Warn("Greška", "Greška getPostAutor(string ime)", exp);
            }
            finally
            {
                if (reader != null) reader.Close();
                if (conn != null && conn.State != ConnectionState.Closed) conn.Close();
            }
            return null;
        }

        public static int upisFajla(string user, string relativnaPutanja, int idPost, string ekstenzija, string opisFajla, string ime)
        {
            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection conn = null;
            SqlDataReader reader = null;
            try
            {
                conn = new SqlConnection(cs);
                SqlCommand com = new SqlCommand("AdminUpisFajlova", conn);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@idPost", idPost);
                com.Parameters.AddWithValue("@putanja", relativnaPutanja + ime + ekstenzija);
                com.Parameters.AddWithValue("@opisfajla", opisFajla);
                com.Parameters.AddWithValue("@datum", DateTime.Now);
                com.Parameters.AddWithValue("@korisnik", user);
                conn.Open();
                return com.ExecuteNonQuery();
            }
            catch (Exception exp)
            {
                HttpContext.Current.Trace.Warn("Greška", "Greška upisFajla(string user, string relativnaPutanja, int idPost, string ekstenzija, string opisFajla, string ime)", exp);
            }
            finally
            {
                if (reader != null) reader.Close();
                if (conn != null && conn.State != ConnectionState.Closed) conn.Close();
            }
            return 0;
        }
    }
}